locals {
  proxmox_network_cidr = split("/", var.cluster.proxmox_network)[1]
  controller_network   = cidrsubnet(var.cluster.proxmox_network, 6, 15 + 1)
  worker_network       = cidrsubnet(var.cluster.proxmox_network, 6, 15 + 2)
  worker_labels        = "node-pool=worker,node-labels: node.cloudprovider.kubernetes.io/platform=nocloud"
}
