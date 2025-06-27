resource "cloudflare_zero_trust_tunnel_cloudflared" "this" {
  account_id = local.cloudflare_config.tunnel_account
  name       = "cf_tunnel_k8s"
}

data "cloudflare_zero_trust_tunnel_cloudflared_token" "this" {
  account_id = cloudflare_zero_trust_tunnel_cloudflared.this.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.this.id
}

resource "bitwarden_secret" "cloudflare" {
  note            = "cloudflare secrets"
  project_id      = local.bitwarden_config.projectID
  organization_id = local.bitwarden_config.organizationID

  key             = "cloudflare"
  value = jsonencode({
    CLOUDFLARE_DNS_TOKEN     = local.cloudflare_config.main_token
    CLOUDFLARE_ZONE_ID       = local.cloudflare_config.dns_zone_id
    CLOUDFLARE_TUNEL_TOKEN   = data.cloudflare_zero_trust_tunnel_cloudflared_token.this.token
    CLOUDFLARE_TUNNEL_SECRET = cloudflare_zero_trust_tunnel_cloudflared.this.tunnel_secret
    CLOUDFLARE_ACCOUNT_TAG   = cloudflare_zero_trust_tunnel_cloudflared.this.account_id
    CLOUDFLARE_TUNNEL_ID     = cloudflare_zero_trust_tunnel_cloudflared.this.id
  })
}