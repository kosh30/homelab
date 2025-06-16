# gitlab

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | >= 18.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | 18.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [gitlab_cluster_agent.this](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/cluster_agent) | resource |
| [gitlab_deploy_key.fluxcd_bootstrap_key](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/deploy_key) | resource |
| [gitlab_deploy_token.gitlab-ro-token](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/deploy_token) | resource |
| [gitlab_repository_file.agent_config](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/repository_file) | resource |
| [gitlab_project.by_id](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/data-sources/project) | data source |
| [gitlab_project.by_namespace](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | `"k8s"` | no |
| <a name="input_fluxcd_bootstrap_public_key"></a> [fluxcd\_bootstrap\_public\_key](#input\_fluxcd\_bootstrap\_public\_key) | n/a | `string` | n/a | yes |
| <a name="input_gitlab_project_id"></a> [gitlab\_project\_id](#input\_gitlab\_project\_id) | Gitlab project id | `number` | `0` | no |
| <a name="input_gitlab_project_path_with_namespace"></a> [gitlab\_project\_path\_with\_namespace](#input\_gitlab\_project\_path\_with\_namespace) | Gitlab project namespace | `string` | `""` | no |
| <a name="input_proxmox"></a> [proxmox](#input\_proxmox) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_deploy_token"></a> [deploy\_token](#output\_deploy\_token) | n/a |
| <a name="output_gitlab_project_data"></a> [gitlab\_project\_data](#output\_gitlab\_project\_data) | n/a |
<!-- END_TF_DOCS -->
