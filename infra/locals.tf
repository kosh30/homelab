locals {
  proxmox_config          = yamldecode(data.sops_file.global_secret.raw).proxmox
  gitlab_config           = yamldecode(data.sops_file.global_secret.raw).gitlab
  bitwarden_config        = yamldecode(data.sops_file.global_secret.raw).bitwarden
  talos_version           = var.talos_version
  talos_upgrade_version   = var.talos_upgrade_version != "" ? var.talos_upgrade_version : var.talos_version
  proxmox_network_cidr    = nonsensitive(split("/", local.proxmox_config.network)[1])
  controller_network      = nonsensitive(cidrsubnet(local.proxmox_config.network, 6, 15 + 1))
  worker_network          = nonsensitive(cidrsubnet(local.proxmox_config.network, 6, 15 + 2))
  mac_prefix              = "BC:24:11:D1"
  controlplane_mac_suffix = "61"
  worker_mac_suffix       = "64"

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
