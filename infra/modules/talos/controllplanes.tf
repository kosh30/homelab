locals {
  controlplane_prefix   = "controlplane"
  controlplane_id_start = 200
  controlplane_nodes = {
    for k, v in var.talos_nodes : k => merge(v, {}) if v.machine_type == "controlplane"
  }
}

resource "proxmox_virtual_environment_file" "controlplane_metadata" {
  for_each     = local.controlplane_nodes
  node_name    = each.value.proxmox_host_node
  content_type = "snippets"
  datastore_id = each.value.datastore_snippets

  source_raw {
    data = templatefile("${path.module}/machine-config/metadata.yaml.tpl", {
      hostname : each.key,
      id : each.value.vm_id,
      providerID : "proxmox://${var.cluster.proxmox_cluster_name}/${each.value.vm_id}",
      type : "${each.value.cpu}VCPU-${floor(each.value.ram_dedicated / 1024)}GB",
      region : var.cluster.proxmox_cluster_name,
      zone : each.value.proxmox_host_node,
      cert : talos_machine_secrets.this.client_configuration.ca_certificate
    })
    file_name = "${each.key}.metadata.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "controllplanes" {
  for_each    = local.controlplane_nodes
  node_name   = each.value.proxmox_host_node
  depends_on  = [proxmox_virtual_environment_file.controlplane_metadata]
  name        = each.key
  description = each.value.machine_type == "controlplane" ? "Talos Control Plane" : "Talos Worker"
  tags        = each.value.machine_type == "controlplane" ? ["k8s", "control-plane"] : ["k8s", "worker"]
  on_boot     = true
  vm_id       = each.value.vm_id

  machine       = "q35"
  scsi_hardware = "virtio-scsi-single"
  bios          = "seabios"

  agent {
    enabled = true
  }

  cpu {
    cores    = each.value.cpu
    type     = "host"
    affinity = "0,1"
  }

  memory {
    dedicated = each.value.ram_dedicated
  }

  network_device {
    bridge      = "vmbr0"
    mac_address = each.value.mac_address
    # vlan_id     = var.cluster.vlan_id
    enabled  = true
    firewall = true
  }
  # os disk
  disk {
    datastore_id = each.value.datastore_rootfs
    interface    = "scsi0"
    iothread     = true
    cache        = "writethrough"
    discard      = "on"
    file_format  = "raw"
    size         = 10
    file_id      = proxmox_virtual_environment_download_file.this["${each.value.proxmox_host_node}_${each.value.update == true ? local.update_image_id : local.image_id}"].id
  }

  boot_order = ["scsi0"]

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 6.X.
  }
  startup {
    down_delay = -1
    order      = 1
    up_delay   = -1
  }

  initialization {
    datastore_id = each.value.datastore_rootfs
    ip_config {
      ipv4 {
        address = each.value.ip != "" ? "${each.value.ip}/${local.proxmox_network_cidr}" : "${cidrhost(local.controller_network, index(keys(local.controlplane_nodes), each.key) + 1)}/${local.proxmox_network_cidr}"
        gateway = var.cluster.gateway
      }
    }
    meta_data_file_id = proxmox_virtual_environment_file.controlplane_metadata[each.key].id
  }

  dynamic "hostpci" {
    for_each = each.value.igpu ? [1] : []
    content {
      # Passthrough iGPU
      device  = "hostpci0"
      mapping = "iGPU"
      pcie    = true
      rombar  = true
      xvga    = false
    }
  }
}

resource "time_sleep" "controlerplane" {
  create_duration = "60s"
  depends_on      = [proxmox_virtual_environment_vm.controllplanes]
}

resource "talos_machine_configuration_apply" "controlplane" {
  depends_on                  = [time_sleep.controlerplane]
  for_each                    = local.controlplane_nodes
  node                        = each.value.ip
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.this[each.key].machine_configuration
  lifecycle {
    # re-run config apply if vm changes
    replace_triggered_by = [proxmox_virtual_environment_vm.controllplanes[each.key]]
  }
}


resource "talos_machine_bootstrap" "controlplane" {
  depends_on           = [talos_machine_configuration_apply.controlplane]
  node                 = split("/", local.controlplane_nodes[keys(local.controlplane_nodes)[0]].ip)[0]
  client_configuration = talos_machine_secrets.this.client_configuration
}

resource "talos_cluster_kubeconfig" "this" {
  depends_on           = [talos_machine_bootstrap.controlplane]
  node                 = split("/", local.controlplane_nodes[keys(local.controlplane_nodes)[0]].ip)[0]
  client_configuration = talos_machine_secrets.this.client_configuration
}

output "kubeconfig_config" {
  sensitive = true
  value     = talos_cluster_kubeconfig.this
}

output "talos_config" {
  sensitive = true
  value     = data.talos_client_configuration.this
}
