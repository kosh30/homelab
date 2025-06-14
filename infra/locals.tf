locals {
  proxmox_config        = yamldecode(data.sops_file.global_secret.raw).proxmox
  talos_version         = var.talos_version
  talos_upgrade_version = var.talos_upgrade_version != "" ? var.talos_upgrade_version : var.talos_version
  proxmox_network_cidr  = nonsensitive(split("/", local.proxmox_config.network)[1])
  controller_network    = nonsensitive(cidrsubnet(local.proxmox_config.network, 6, 15 + 1))
  worker_network        = nonsensitive(cidrsubnet(local.proxmox_config.network, 6, 15 + 2))

  controllers = {
    "ctrl-001" = {
      cpu           = 2
      ram_dedicated = 4096
    }
    "ctrl-002" = {
      cpu           = 2
      ram_dedicated = 4096
    }
    "ctrl-003" = {
      cpu           = 2
      ram_dedicated = 4096
    }
  }

  workers = {
    "wk-001" = {
      cpu           = 2
      ram_dedicated = 4096
    }
    "wk-002" = {
      cpu           = 2
      ram_dedicated = 4096
    }
    "wk-003" = {
      cpu           = 2
      ram_dedicated = 4096
    }
  }
}
