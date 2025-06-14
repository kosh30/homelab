resource "talos_machine_secrets" "this" {
  talos_version = var.cluster.talos_version
}

data "talos_client_configuration" "this" {
  cluster_name         = var.cluster.name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = [var.cluster.endpoint_hostname]
  nodes                = [for k, v in var.talos_nodes : v.ip]
}

data "talos_machine_configuration" "this" {
  for_each         = var.talos_nodes
  cluster_name     = var.cluster.name
  cluster_endpoint = "https://${var.cluster.endpoint_hostname}:6443"
  talos_version    = var.cluster.talos_version
  machine_type     = each.value.machine_type
  machine_secrets  = talos_machine_secrets.this.machine_secrets
  config_patches = each.value.machine_type == "controlplane" ? [
    templatefile("${path.module}/machine-config/common.yaml", {
      name                      = each.key
      cluster_endpoint_hostname = var.cluster.endpoint_hostname
      cluster_name              = var.cluster.name
      cluster_endpoint_ip       = var.cluster.endpoint_ip
      dns_server                = cidrhost(var.cluster.proxmox_network, 1)
      hostname                  = each.key
      proxmox_subnet            = var.cluster.proxmox_network
      region                    = var.cluster.proxmox_cluster_name
      zone                      = each.value.proxmox_host_node
    }),
    templatefile("${path.module}/machine-config/controlplane.yaml", {
      cluster_endpoint_hostname = var.cluster.endpoint_hostname
      cluster_endpoint_ip       = var.cluster.endpoint_ip
    })
    ] : [
    templatefile("${path.module}/machine-config/common.yaml", {
      name                      = each.key
      cluster_endpoint_hostname = var.cluster.endpoint_hostname
      cluster_name              = var.cluster.name
      cluster_endpoint_ip       = var.cluster.endpoint_ip
      dns_server                = cidrhost(var.cluster.proxmox_network, 1)
      hostname                  = each.key
      proxmox_subnet            = var.cluster.proxmox_network
      region                    = var.cluster.proxmox_cluster_name
      zone                      = each.value.proxmox_host_node
    }),
    templatefile("${path.module}/machine-config/worker.yaml", {
      name                      = each.key
      cluster_endpoint_hostname = var.cluster.endpoint_hostname
      cluster_name              = var.cluster.name
      cluster_endpoint_ip       = var.cluster.endpoint_ip
      dns_server                = cidrhost(var.cluster.proxmox_network, 1)
      hostname                  = each.key
      proxmox_subnet            = var.cluster.proxmox_network
      labels                    = join(",", [local.worker_labels])
    }),
  ]
}
