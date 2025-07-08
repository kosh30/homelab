terraform {
  required_version = ">= 1"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.66.1"
    }
    talos = {
      source  = "siderolabs/talos"
      version = ">=0.6.0"
    }
    http = {
      source  = "hashicorp/http"
      version = ">=3.4.5"
    }
    local = {
      source  = "hashicorp/local"
      version = ">=2.5.2"
    }

    null = {
      source  = "hashicorp/null"
      version = ">=3.2.3"
    }

    time = {
      source  = "hashicorp/time"
      version = ">=0.13.1"
    }
  }
}
