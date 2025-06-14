terraform {
  required_version = ">= 1"
  backend "s3" {
    bucket         = "serverless-svelte-kosh-deploys"
    key            = "kosh-made/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.71"
    }

    sops = {
      source  = "carlpett/sops"
      version = ">= 1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
  }
}

provider "proxmox" {
  endpoint = local.proxmox_config.endpoint
  username = local.proxmox_config.username
  password = local.proxmox_config.password
  insecure = true
  ssh {
    agent       = true
    private_key = "/home/kosh/.ssh/id_ed25519"
  }
}
