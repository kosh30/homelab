terraform {
  required_version = ">= 1"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.16.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.35.0"
    }

    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.71"
    }
  }
}
