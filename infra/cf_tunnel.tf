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

resource "kubernetes_secret" "cloudflare-tunnel-secret" {
  depends_on = [module.flux-bootstrap, bitwarden_secret.cloudflare]
  metadata {
    name      = "cloudflare-tunnel-secret"
    namespace = "network"
  }
  data = {
    CLOUDFLARE_TUNNEL_ID = cloudflare_zero_trust_tunnel_cloudflared.this.id
    TUNNEL_TOKEN         = data.cloudflare_zero_trust_tunnel_cloudflared_token.this.token
  }

  lifecycle {
    ignore_changes = [
      metadata,
      data
    ]
  }
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

resource "random_password" "authentik_bootstrap_password" {
  length  = 16
  special = true
}

resource "random_password" "authentik_bootstrap_token" {
  length  = 64
  special = true
}

resource "random_password" "authentik_secret_key" {
  length = 64
}


resource "bitwarden_secret" "crunchy-pgo" {
  note            = "crunchy-pgo secrets"
  project_id      = local.bitwarden_config.projectID
  organization_id = local.bitwarden_config.organizationID

  key = "crunchy-pgo"
  value = jsonencode({
    CRUNCHY_PGO_CIPHER_PASS = random_password.authentik_bootstrap_password.result
  })
}

resource "bitwarden_secret" "postgresql-bucket" {
  note            = "authentik secrets"
  project_id      = local.bitwarden_config.projectID
  organization_id = local.bitwarden_config.organizationID

  key = "postgresql-bucket"
  value = jsonencode({
    AWS_ACCESS_KEY_ID     = local.hetzner_config.s3.acces_key_id
    AWS_SECRET_ACCESS_KEY = local.hetzner_config.s3.access_key_secret
    ENDPOINT              = "https://${local.hetzner_config.s3.address}"
    REGION                = local.hetzner_config.s3.region
    BUCKET                = "kosh-k8s-pg-backup01"
  })
}


resource "bitwarden_secret" "authentik" {
  note            = "authentik secrets"
  project_id      = local.bitwarden_config.projectID
  organization_id = local.bitwarden_config.organizationID

  key = "authentik"
  value = jsonencode({
    AUTHENTIK_BOOTSTRAP_EMAIL    = local.authentik_config.AUTHENTIK_BOOTSTRAP_EMAIL
    AUTHENTIK_BOOTSTRAP_PASSWORD = random_password.authentik_bootstrap_password.result
    AUTHENTIK_BOOTSTRAP_TOKEN    = random_password.authentik_bootstrap_token.result
    AUTHENTIK_SECRET_KEY         = random_password.authentik_secret_key.result
  })
}

output "authentic-secrets" {
  sensitive = true
  value = {
    AUTHENTIK_BOOTSTRAP_EMAIL    = local.authentik_config.AUTHENTIK_BOOTSTRAP_EMAIL
    AUTHENTIK_BOOTSTRAP_PASSWORD = random_password.authentik_bootstrap_password.result
    AUTHENTIK_BOOTSTRAP_TOKEN    = random_password.authentik_bootstrap_token.result
    AUTHENTIK_SECRET_KEY         = random_password.authentik_secret_key.result
  }
}

locals {
  oauth_apps = [
    # "dashbrr",
    "grafana",
    # "headlamp",
    # "kyoo",
    # "lubelogger",
    "open-webui",
    # "paperless",
    # "portainer"
  ]
}
resource "random_string" "oauthIDs" {
  count   = length(local.oauth_apps)
  length  = 40
  special = false
  upper   = true
  lower   = true
  numeric = true
}

resource "random_string" "oauth" {
  count   = length(local.oauth_apps)
  length  = 128
  special = false
  upper   = true
  lower   = true
  numeric = true
}

locals {
  app_ids     = { for i, s in local.oauth_apps : "${upper(replace(s, "-", "_"))}_CLIENT_ID" => random_string.oauthIDs[i].result }
  app_secrets = { for i, s in local.oauth_apps : "${upper(replace(s, "-", "_"))}_CLIENT_SECRET" => random_string.oauth[i].result }
}
resource "bitwarden_secret" "authentikApplications" {
  note            = "$ authentik secrets"
  project_id      = local.bitwarden_config.projectID
  organization_id = local.bitwarden_config.organizationID
  key             = "authentikApps"
  value           = jsonencode(merge(local.app_ids, local.app_secrets))
}

resource "bitwarden_secret" "searxng" {
  note            = "searxng secrets"
  project_id      = local.bitwarden_config.projectID
  organization_id = local.bitwarden_config.organizationID
  key             = "searxng"
  value           = jsonencode({ searxng_secret_key : random_password.authentik_secret_key.result })
}
