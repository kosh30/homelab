terraform {
  required_version = ">= 1"
  backend "s3" {
    bucket         = "serverless-svelte-kosh-deploys"
    key            = "kosh-made/authentik-terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2025.8.0"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = ">= 0.13.6"
    }
  }
}

provider "bitwarden" {
  access_token = data.terraform_remote_state.talos.outputs.bitwarden.token
  experimental {
    embedded_client = true
  }
}

provider "authentik" {
  token = data.terraform_remote_state.talos.outputs.authentic-secrets.AUTHENTIK_BOOTSTRAP_TOKEN
  url   = "https://sso.kosh.casa"
}
