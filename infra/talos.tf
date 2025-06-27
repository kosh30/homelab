

resource "tls_private_key" "fluxcd" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
  lifecycle {
    create_before_destroy = true
  }
}

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
    proxmox_endpoint           = nonsensitive(local.proxmox_config.endpoint)
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

module "gitlab" {
  source                      = "./modules/gitlab"
  gitlab_project_id           = tonumber(local.gitlab_config.project_id)
  proxmox                     = local.proxmox_config
  fluxcd_bootstrap_public_key = tls_private_key.fluxcd.public_key_openssh
}

output "gitlab" {
  sensitive = true
  value     = module.gitlab.gitlab_project_data
}

module "flux-bootstrap" {
  source       = "./modules/bootstrap"
  git_path     = "/kubernetes/cluster/${module.talos-cluster.talos-cluster.name}"
  proxmox      = local.proxmox_config
  cluster_name = module.talos-cluster.talos_config.cluster_name
  # git_url      = "ssh://${replace(":", "/", module.gitlab.gitlab_project_data.ssh_url_to_repo)}"
  git_url      = module.gitlab.gitlab_project_data.http_url_to_repo
  git_user     = module.gitlab.deploy_token.username
  git_password = module.gitlab.deploy_token.token
  bitwarden    = local.bitwarden_config

}


resource "local_file" "bgb_config" {
  filename = "${path.module}/../.local/bgb_config.conf"
  content  = <<EOF
router bgp 64513
  bgp router-id 192.168.96.1
  no bgp ebgp-requires-policy

  neighbor k8s peer-group
  neighbor k8s remote-as 64514
  %{for k, v in local.vms}
  neighbor ${v.ip} peer-group k8s
  %{endfor}
  address-family ipv4 unicast
  neighbor k8s next-hop-self
  neighbor k8s soft-reconfiguration inbound
  exit-address-family
exit
EOF
}
