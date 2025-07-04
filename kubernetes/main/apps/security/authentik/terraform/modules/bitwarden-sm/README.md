# bitwarden-sm

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_bitwarden"></a> [bitwarden](#requirement\_bitwarden) | >= 0.13.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_bitwarden"></a> [bitwarden](#provider\_bitwarden) | 0.14.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [bitwarden_secret.secret](https://registry.terraform.io/providers/maxlaverse/bitwarden/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_organizationID"></a> [organizationID](#input\_organizationID) | n/a | `string` | n/a | yes |
| <a name="input_secret"></a> [secret](#input\_secret) | Secret name to find the Item in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fields"></a> [fields](#output\_fields) | n/a |
<!-- END_TF_DOCS -->
