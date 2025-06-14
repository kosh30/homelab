module "talos-cluster" {
  source = "./modules/talos"

  image = {
    version        = local.talos_version
    update_version = local.talos_upgrade_version
    schematic      = file("${path.module}/../talosconfig/image_schematics.yaml")
    # Point this to a new schematic file to update the schematic
    update_schematic = file("${path.module}/../talosconfig/image_schematics.yaml")
  }

  cluster = {
    name                       = "home-cluster"
    endpoint_ip                = "192.168.96.10"
    endpoint_hostname          = "api.cluster.local"
    endpoint_hostname_external = "k8s-api.kosh.casa"
    gateway                    = "192.168.96.1"
    talos_version              = local.talos_version
    proxmox_cluster_name       = "pve"
    proxmox_network            = nonsensitive(local.proxmox_config.network)
    vlan_id                    = 2
  }

  talos_nodes = local.vm_storage_map
}

resource "local_sensitive_file" "kubeconfig" {
  filename = "${path.module}/../kubeconfig.yaml"
  content  = module.talos-cluster.kubeconfig_config.kubeconfig_raw
}

resource "local_sensitive_file" "talosconfig" {
  content  = module.talos-cluster.talos_config.talos_config
  filename = "${path.module}/../talosconfig.yaml"
}

module "flux-bootstrap" {
  source = "./modules/bootstrap"
}