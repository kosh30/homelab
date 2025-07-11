locals {
  decoded_config          = yamldecode(data.sops_file.global_secret.raw)
  proxmox_config          = local.decoded_config.proxmox
  gitlab_config           = local.decoded_config.gitlab
  bitwarden_config        = local.decoded_config.bitwarden
  cloudflare_config       = local.decoded_config.cloudflare
  authentik_config        = local.decoded_config.authentik
  hetzner_config          = local.decoded_config.hetzner
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
      ram_dedicated = 3072
    }
    # "ctrl-002" = {
    #   cpu           = 1
    #   ram_dedicated = 3072
    # }
    # "ctrl-003" = {
    #   cpu           = 1
    #   ram_dedicated = 3072
    # }
  }

  workers = {
    "wk-001" = {
      cpu           = 6
      ram_dedicated = 24576
    }
    # "wk-002" = {
    #   cpu           = 2
    #   ram_dedicated = 4096
    # }
    # "wk-003" = {
    #   cpu           = 2
    #   ram_dedicated = 4096
    # }
  }
}
