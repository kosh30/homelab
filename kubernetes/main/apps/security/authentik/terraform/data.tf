data "terraform_remote_state" "talos" {
  backend = "s3"
  config = {
    bucket = "serverless-svelte-kosh-deploys"
    key    = "kosh-made/terraform.tfstate"
    region = "eu-central-1"
  }
}

data "authentik_certificate_key_pair" "generated" {
  name = "authentik Self-signed Certificate"
}

data "authentik_brand" "authentik-default" {
  domain = "authentik-default"
}

# Get the default flows
data "authentik_flow" "default-brand-authentication" {
  slug = "default-authentication-flow"
}

data "authentik_flow" "default-brand-invalidation" {
  slug = "default-invalidation-flow"
}

data "authentik_flow" "default-brand-user-settings" {
  slug = "default-user-settings-flow"
}



# output "data" {
#   value = data.terraform_remote_state.talos.outputs
# }
