# bootstrap

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.16.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 2.1.3 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.35.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.71 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.17.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 2.1.3 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.37.1 |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.78.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.cilium](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.coredns](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.flux_instance](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.flux_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.apply_prometheus_operator_crds](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.flux_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.proxmox-csi-namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.age](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.git-auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.proxmox-csi-plugin-secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [proxmox_virtual_environment_role.csi-role](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_role) | resource |
| [proxmox_virtual_environment_user.csi-user](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_user) | resource |
| [proxmox_virtual_environment_user_token.proxmox-csi-user-token](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_user_token) | resource |
| [helm_template.prometheus_operator_crds](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/data-sources/template) | data source |
| [kubectl_file_documents.prometheus_operator_crds](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/data-sources/file_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | `"k8s"` | no |
| <a name="input_flux_registry"></a> [flux\_registry](#input\_flux\_registry) | Flux distribution registry | `string` | `"ghcr.io/fluxcd"` | no |
| <a name="input_flux_version"></a> [flux\_version](#input\_flux\_version) | Flux version semver range | `string` | `"2.x"` | no |
| <a name="input_git_password"></a> [git\_password](#input\_git\_password) | n/a | `string` | n/a | yes |
| <a name="input_git_path"></a> [git\_path](#input\_git\_path) | Path to the cluster manifests in the Git repository | `string` | n/a | yes |
| <a name="input_git_ref"></a> [git\_ref](#input\_git\_ref) | Git branch or tag in the format refs/heads/main or refs/tags/v1.0.0 | `string` | `"refs/heads/main"` | no |
| <a name="input_git_url"></a> [git\_url](#input\_git\_url) | Git repository URL | `string` | n/a | yes |
| <a name="input_git_user"></a> [git\_user](#input\_git\_user) | n/a | `string` | n/a | yes |
| <a name="input_proxmox"></a> [proxmox](#input\_proxmox) | Proxmox configuration | `any` | n/a | yes |
| <a name="input_sops_key_path"></a> [sops\_key\_path](#input\_sops\_key\_path) | Path to the SOPS key file | `string` | `"~/.config/sops/age/keys.txt"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
