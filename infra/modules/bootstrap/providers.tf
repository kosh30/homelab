terraform {
  required_version = ">= 1"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.35.0"
    }

    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.71"
    }

    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.1.3"
    }

    http = {
      source  = "hashicorp/http"
      version = ">= 3.4.5"
    }
  }
}
