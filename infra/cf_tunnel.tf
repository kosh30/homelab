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

  key = "cloudflare"
  value = jsonencode({
    CLOUDFLARE_DNS_TOKEN     = local.cloudflare_config.main_token
    CLOUDFLARE_ZONE_ID       = local.cloudflare_config.dns_zone_id
    CLOUDFLARE_TUNEL_TOKEN   = data.cloudflare_zero_trust_tunnel_cloudflared_token.this.token
    CLOUDFLARE_TUNNEL_SECRET = cloudflare_zero_trust_tunnel_cloudflared.this.tunnel_secret
    CLOUDFLARE_ACCOUNT_TAG   = cloudflare_zero_trust_tunnel_cloudflared.this.account_id
    CLOUDFLARE_TUNNEL_ID     = cloudflare_zero_trust_tunnel_cloudflared.this.id
  })
}

resource "random_string" "github_token" {
  length  = 41
  numeric = true
  special = false
  lower   = true
  upper   = false
}

resource "random_string" "gitlab_token" {
  length  = 41
  numeric = true
  special = false
  lower   = true
  upper   = false
}


resource "bitwarden_secret" "flux" {
  note            = "flux secrets"
  project_id      = local.bitwarden_config.projectID
  organization_id = local.bitwarden_config.organizationID

  key = "flux"
  value = jsonencode({
    FLUX_GITHUB_WEBHOOK_TOKEN = random_string.github_token.result
    FLUX_GITLAB_WEBHOOK_TOKEN = random_string.gitlab_token.result
  })
}
