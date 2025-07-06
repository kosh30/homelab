locals {
  authentik_groups = {
    downloads      = { name = "Downloads" }
    home           = { name = "Home" }
    infrastructure = { name = "Infrastructure" }
    media          = { name = "Media" }
    monitoring     = { name = "Monitoring" }
    users          = { name = "Users" }
  }
}

data "authentik_group" "admins" {
  name = "authentik Admins"
}

resource "authentik_group" "grafana_admin" {
  name         = "Grafana Admins"
  is_superuser = false
}

resource "authentik_group" "default" {
  for_each     = local.authentik_groups
  name         = each.value.name
  is_superuser = false
}

resource "authentik_policy_binding" "application_policy_binding" {
  for_each = local.applications

  target = authentik_application.application[each.key].uuid
  group  = authentik_group.default[each.value.group].id
  order  = 0
}

# module "onepassword_discord" {
#   source = "github.com/joryirving/terraform-1password-item"
#   vault  = "Kubernetes"
#   item   = "discord"
# }

##Oauth
# resource "authentik_source_oauth" "discord" {
#   name                = "Discord"
#   slug                = "discord"
#   authentication_flow = data.authentik_flow.default-source-authentication.id
#   enrollment_flow     = authentik_flow.enrollment-invitation.uuid
#   user_matching_mode  = "email_deny"
#
#   provider_type   = "discord"
#   consumer_key    = module.onepassword_discord.fields["DISCORD_CLIENT_ID"]
#   consumer_secret = module.onepassword_discord.fields["DISCORD_CLIENT_SECRET"]
# }

# resource "authentik_source_oauth" "gitlab" {
#   name                = "gitlab"
#   slug                = "gitlab"
#   authentication_flow = data.authentik_flow.default-source-authentication.id
#   enrollment_flow     = data.authentik_flow.default-source-enrollment.id
#
#   consumer_key        = "foo"
#   consumer_secret     = "bar"
#   access_token_url    = "https://gitlab.com/oauth/token"
#   authorization_url   = "https://gitlab.com/oauth/authorize"
#   oidc_jwks_url       = "https://gitlab.com/oauth/discovery/keys"
#   oidc_well_known_url = "https://gitlab.com/.well-known/openid-configuration"
#   profile_url         = "https://gitlab.com/oauth/userinfo"
#   provider_type       = "openidconnect"
#   lifecycle {
#     ignore_changes = [consumer_key, consumer_secret]
#   }
# }

resource "authentik_group" "infra" {
  name         = "infra"
  is_superuser = false
}

resource "authentik_group" "admins" {
  name         = "admins"
  is_superuser = true
}

resource "authentik_group" "users" {
  name         = "users"
  is_superuser = false
}

resource "authentik_group" "forgejo" {
  name         = "forgejo"
  is_superuser = false
  parent       = authentik_group.users.id
}

resource "authentik_group" "miniflux" {
  name         = "miniflux"
  is_superuser = false
  parent       = authentik_group.users.id
}

resource "authentik_group" "nextcloud" {
  name         = "nextcloud"
  is_superuser = false
  parent       = authentik_group.users.id
  attributes   = jsonencode({ nexcloud_quota = "10 GB" })
}

resource "authentik_group" "vikunja" {
  name         = "vikunja"
  is_superuser = false
  parent       = authentik_group.users.id
}
