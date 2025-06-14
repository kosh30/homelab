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
  }
}

resource "kubernetes_namespace" "flux_system" {
  metadata {
    name = "flux-system"
  }

  lifecycle {
    ignore_changes = [metadata]
  }
}

variable "sops_key_path" {
  default     = "~/.config/sops/age/keys.txt"
  description = "Path to the SOPS key file"
  type        = string
}

resource "kubernetes_secret" "age" {
  depends_on = [kubernetes_namespace.flux_system]
  metadata {
    name      = "sops-age"
    namespace = "flux-system"
    annotations = {
      "reflector.v1.k8s.emberstack.com/reflection-allowed"            = "true"
      "reflector.v1.k8s.emberstack.com/reflection-allowed-namespaces" = "application.*"
      "reflector.v1.k8s.emberstack.com/reflection-auto-enabled"       = "true"
      "reflector.v1.k8s.emberstack.com/reflection-auto-namespaces"    = "application.*"
    }
  }
  data = {
    "keys.agekey" = file(pathexpand(var.sops_key_path))
  }
}

resource "helm_release" "flux_operator" {
  depends_on = [kubernetes_namespace.flux_system]

  name       = "flux-operator"
  namespace  = "flux-system"
  repository = "oci://ghcr.io/controlplaneio-fluxcd/charts"
  chart      = "flux-operator"
  wait       = true
}

# ==========================================
# Bootstrap Flux Instance
# ==========================================
resource "helm_release" "flux_instance" {
  depends_on = [helm_release.flux_operator]

  name       = "flux-instance"
  namespace  = "flux-system"
  repository = "oci://ghcr.io/controlplaneio-fluxcd/charts"
  chart      = "flux-instance"
  values = [
    file("${path.module}/../../../kubernetes/core/fluxcd/operator/values/components.yaml")
  ]
  set {
    name  = "distribution.version"
    value = "2.x"
  }
}
