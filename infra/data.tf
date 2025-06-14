data "sops_file" "global_secret" {
  source_file = "${path.module}/../secret_encrypted.yaml"
  input_type  = "yaml"
}
data "proxmox_virtual_environment_users" "acme" {}
data "proxmox_virtual_environment_nodes" "this" {}
locals {
  proxmox_nodes = toset(data.proxmox_virtual_environment_nodes.this.names)
}

data "proxmox_virtual_environment_datastores" "snippets" {
  for_each  = local.proxmox_nodes
  node_name = each.value
  filters = {
    content_types = ["snippets"]
  }
}

data "proxmox_virtual_environment_datastores" "images" {
  for_each  = local.proxmox_nodes
  node_name = each.value
  filters = {
    content_types = ["images"]
  }
}

data "proxmox_virtual_environment_datastores" "containers" {
  for_each  = local.proxmox_nodes
  node_name = each.value
  filters = {
    content_types = ["rootdir"]
  }
}

output "proxmox_data" {
  sensitive = true
  value     = data.proxmox_virtual_environment_users.acme
}

output "cluster_nodes" {
  value = data.proxmox_virtual_environment_nodes.this
}

output "cluster_storages" {
  value = data.proxmox_virtual_environment_datastores.snippets
}

locals {
  nos = tolist(local.proxmox_nodes)
  _controllers = { for k, v in local.controllers : k => merge(v, {
    vm_id        = lookup(v, "vm_id", index(keys(local.controllers), k) + 300),
    ip           = lookup(v, "ip", cidrhost(local.controller_network, index(keys(local.controllers), k) + 1)),
    host_cidr    = local.proxmox_network_cidr
    machine_type = "controlplane"
  }) }

  _workers = { for k, v in local.workers : k => merge(v, {
    vm_id        = lookup(v, "vm_id", index(keys(local.workers), k) + 400),
    ip           = lookup(v, "ip", cidrhost(local.worker_network, index(keys(local.workers), k) + 1)),
    host_cidr    = local.proxmox_network_cidr
    machine_type = "worker"
  }) }
  vms         = merge(local._controllers, local._workers)
  vm_node_map = { for idx, vm in keys(local.vms) : vm => local.nos[idx % length(local.nos)] }
  # Assign snippet storage to each VM based on its assigned node
  vm_storage_map = {
    for vm, node in local.vm_node_map :
    vm => merge(local.vms[vm], {
      proxmox_host_node  = node,
      datastore_snippets = data.proxmox_virtual_environment_datastores.snippets[node].datastores[0].id
      datastore_images   = data.proxmox_virtual_environment_datastores.images[node].datastores[0].id
      datastore_rootfs   = data.proxmox_virtual_environment_datastores.containers[node].datastores[0].id
    })
  }
}

output "vm_node_assignments" {
  value = local.vm_storage_map
}
