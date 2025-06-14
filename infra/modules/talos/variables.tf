variable "image" {
  description = "Talos image configuration"
  type = object({
    factory_url       = optional(string, "https://factory.talos.dev")
    schematic         = string
    version           = string
    update_schematic  = optional(string)
    update_version    = optional(string)
    arch              = optional(string, "amd64")
    platform          = optional(string, "nocloud")
    proxmox_datastore = optional(string, "local")
  })
}

variable "cluster" {
  description = "Cluster configuration"
  type = object({
    name                       = string
    endpoint_ip                = string
    endpoint_hostname          = string
    endpoint_hostname_external = optional(string)
    gateway                    = string
    talos_version              = string
    proxmox_cluster_name       = string
    proxmox_network            = string
    vlan_id                    = optional(number)
  })
}

variable "talos_nodes" {
  description = "Configuration for cluster nodes"
  type = map(object({
    machine_type       = string
    cpu                = number
    ram_dedicated      = number
    data_disk_size     = optional(number, 20)
    datastore_snippets = optional(string)
    datastore_image    = optional(string)
    datastore_rootfs   = optional(string)
    igpu               = optional(bool, false)
    ip                 = optional(string, "")
    host_cidr          = optional(string, "24")
    mac_address        = optional(string)
    os_disk_size       = optional(number, 10)
    proxmox_host_node  = string
    update             = optional(bool, false)
    vm_id              = optional(number)
  }))
}
