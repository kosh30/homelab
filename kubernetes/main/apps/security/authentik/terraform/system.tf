import {
  to = authentik_brand.default
  id = data.authentik_brand.authentik-default.id
}

# Create/manage the default brand
resource "authentik_brand" "default" {
  domain           = "authentik-default"
  default          = true
  branding_title   = "authentik"
  branding_logo    = "/static/dist/assets/icons/icon_left_brand.svg"
  branding_favicon = "/static/dist/assets/icons/icon.png"

  flow_authentication = data.authentik_flow.default-brand-authentication.id
  flow_invalidation   = data.authentik_flow.default-brand-invalidation.id
  flow_user_settings  = data.authentik_flow.default-brand-user-settings.id
}


resource "authentik_brand" "home" {
  domain           = var.CLUSTER_DOMAIN
  default          = false
  branding_title   = "Home"
  branding_logo    = "/static/dist/assets/icons/icon_left_brand.svg"
  branding_favicon = "/static/dist/assets/icons/icon.png"

  flow_authentication = authentik_flow.authentication.uuid
  flow_invalidation   = data.authentik_flow.default-invalidation.id
  flow_user_settings  = data.authentik_flow.default-user-settings.id
}

resource "authentik_service_connection_kubernetes" "local" {
  name  = "local"
  local = true
}
