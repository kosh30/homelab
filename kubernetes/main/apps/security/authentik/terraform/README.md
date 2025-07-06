# terraform

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_authentik"></a> [authentik](#requirement\_authentik) | 2025.6.0 |
| <a name="requirement_bitwarden"></a> [bitwarden](#requirement\_bitwarden) | >= 0.13.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_authentik"></a> [authentik](#provider\_authentik) | 2025.6.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_onepassword_application"></a> [onepassword\_application](#module\_onepassword\_application) | ./modules/bitwarden-sm | n/a |

## Resources

| Name | Type |
|------|------|
| [authentik_application.application](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/application) | resource |
| [authentik_brand.default](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/brand) | resource |
| [authentik_brand.home](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/brand) | resource |
| [authentik_flow.authentication](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/flow) | resource |
| [authentik_flow.recovery](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/flow) | resource |
| [authentik_flow_stage_binding.authentication-identification](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/flow_stage_binding) | resource |
| [authentik_flow_stage_binding.authentication-login](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/flow_stage_binding) | resource |
| [authentik_flow_stage_binding.authentication-mfa-validation](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/flow_stage_binding) | resource |
| [authentik_flow_stage_binding.recovery-flow-binding-00](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/flow_stage_binding) | resource |
| [authentik_flow_stage_binding.recovery-flow-binding-10](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/flow_stage_binding) | resource |
| [authentik_flow_stage_binding.recovery-flow-binding-20](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/flow_stage_binding) | resource |
| [authentik_flow_stage_binding.recovery-flow-binding-30](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/flow_stage_binding) | resource |
| [authentik_group.admins](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/group) | resource |
| [authentik_group.default](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/group) | resource |
| [authentik_group.forgejo](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/group) | resource |
| [authentik_group.grafana_admin](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/group) | resource |
| [authentik_group.infra](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/group) | resource |
| [authentik_group.miniflux](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/group) | resource |
| [authentik_group.nextcloud](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/group) | resource |
| [authentik_group.users](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/group) | resource |
| [authentik_group.vikunja](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/group) | resource |
| [authentik_policy_binding.application_policy_binding](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/policy_binding) | resource |
| [authentik_policy_expression.user-settings-authorization](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/policy_expression) | resource |
| [authentik_policy_password.password-complexity](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/policy_password) | resource |
| [authentik_provider_oauth2.oauth2](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/provider_oauth2) | resource |
| [authentik_service_connection_kubernetes.local](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/service_connection_kubernetes) | resource |
| [authentik_stage_authenticator_validate.authentication-mfa-validation](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/stage_authenticator_validate) | resource |
| [authentik_stage_email.recovery-email](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/stage_email) | resource |
| [authentik_stage_identification.authentication-identification](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/stage_identification) | resource |
| [authentik_stage_identification.recovery-identification](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/stage_identification) | resource |
| [authentik_stage_prompt.password-change-prompt](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/stage_prompt) | resource |
| [authentik_stage_prompt_field.email](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/stage_prompt_field) | resource |
| [authentik_stage_prompt_field.locale](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/stage_prompt_field) | resource |
| [authentik_stage_prompt_field.name](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/stage_prompt_field) | resource |
| [authentik_stage_prompt_field.password](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/stage_prompt_field) | resource |
| [authentik_stage_prompt_field.password-repeat](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/stage_prompt_field) | resource |
| [authentik_stage_prompt_field.username](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/stage_prompt_field) | resource |
| [authentik_stage_user_login.authentication-login](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/stage_user_login) | resource |
| [authentik_stage_user_write.password-change-write](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/resources/stage_user_write) | resource |
| [authentik_brand.authentik-default](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/brand) | data source |
| [authentik_certificate_key_pair.generated](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/certificate_key_pair) | data source |
| [authentik_flow.default-authorization](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/flow) | data source |
| [authentik_flow.default-brand-authentication](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/flow) | data source |
| [authentik_flow.default-brand-invalidation](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/flow) | data source |
| [authentik_flow.default-brand-user-settings](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/flow) | data source |
| [authentik_flow.default-invalidation](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/flow) | data source |
| [authentik_flow.default-provider-invalidation](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/flow) | data source |
| [authentik_flow.default-user-settings](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/flow) | data source |
| [authentik_group.admins](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/group) | data source |
| [authentik_property_mapping_provider_saml.email](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/property_mapping_provider_saml) | data source |
| [authentik_property_mapping_provider_saml.groups](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/property_mapping_provider_saml) | data source |
| [authentik_property_mapping_provider_saml.name](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/property_mapping_provider_saml) | data source |
| [authentik_property_mapping_provider_saml.upn](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/property_mapping_provider_saml) | data source |
| [authentik_property_mapping_provider_saml.username](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/property_mapping_provider_saml) | data source |
| [authentik_property_mapping_provider_scope.email](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/property_mapping_provider_scope) | data source |
| [authentik_property_mapping_provider_scope.oauth2](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/property_mapping_provider_scope) | data source |
| [authentik_property_mapping_provider_scope.openid](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/property_mapping_provider_scope) | data source |
| [authentik_property_mapping_provider_scope.profile](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/property_mapping_provider_scope) | data source |
| [authentik_stage.default-authentication-password](https://registry.terraform.io/providers/goauthentik/authentik/2025.6.0/docs/data-sources/stage) | data source |
| [terraform_remote_state.talos](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_CLUSTER_DOMAIN"></a> [CLUSTER\_DOMAIN](#input\_CLUSTER\_DOMAIN) | n/a | `string` | `"kosh.casa"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
