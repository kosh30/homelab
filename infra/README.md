# infra

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | >= 18.0.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.16.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.35.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.5.2 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.71 |
| <a name="requirement_sops"></a> [sops](#requirement\_sops) | >= 1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.3 |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.78.2 |
| <a name="provider_sops"></a> [sops](#provider\_sops) | 1.2.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_flux-bootstrap"></a> [flux-bootstrap](#module\_flux-bootstrap) | ./modules/bootstrap | n/a |
| <a name="module_gitlab"></a> [gitlab](#module\_gitlab) | ./modules/gitlab | n/a |
| <a name="module_talos-cluster"></a> [talos-cluster](#module\_talos-cluster) | ./modules/talos | n/a |

## Resources

| Name | Type |
|------|------|
| [local_sensitive_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.talosconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [tls_private_key.fluxcd](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [proxmox_virtual_environment_datastores.containers](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/data-sources/virtual_environment_datastores) | data source |
| [proxmox_virtual_environment_datastores.images](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/data-sources/virtual_environment_datastores) | data source |
| [proxmox_virtual_environment_datastores.snippets](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/data-sources/virtual_environment_datastores) | data source |
| [proxmox_virtual_environment_nodes.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/data-sources/virtual_environment_nodes) | data source |
| [proxmox_virtual_environment_users.acme](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/data-sources/virtual_environment_users) | data source |
| [sops_file.global_secret](https://registry.terraform.io/providers/carlpett/sops/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_talos_upgrade_version"></a> [talos\_upgrade\_version](#input\_talos\_upgrade\_version) | Upgrade talos nodes to version | `string` | `"v1.10.4"` | no |
| <a name="input_talos_version"></a> [talos\_version](#input\_talos\_version) | Talos version | `string` | `"v1.10.3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_nodes"></a> [cluster\_nodes](#output\_cluster\_nodes) | n/a |
| <a name="output_cluster_storages"></a> [cluster\_storages](#output\_cluster\_storages) | n/a |
| <a name="output_gitlab"></a> [gitlab](#output\_gitlab) | n/a |
| <a name="output_networks"></a> [networks](#output\_networks) | n/a |
| <a name="output_proxmox_data"></a> [proxmox\_data](#output\_proxmox\_data) | n/a |
| <a name="output_terraform_output"></a> [terraform\_output](#output\_terraform\_output) | n/a |
| <a name="output_vm_node_assignments"></a> [vm\_node\_assignments](#output\_vm\_node\_assignments) | n/a |
<!-- END_TF_DOCS -->
