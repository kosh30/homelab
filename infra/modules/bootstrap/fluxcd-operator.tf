
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
      "reflector.v1.k8s.emberstack.com/reflection-allowed"      = "true"
      "reflector.v1.k8s.emberstack.com/reflection-auto-enabled" = "true"
    }
  }
  data = {
    "keys.agekey" = file(pathexpand(var.sops_key_path))
  }
}

resource "kubernetes_secret" "git-auth" {
  metadata {
    name      = "git-token-auth"
    namespace = "flux-system"
  }

  data = {
    username = var.git_user
    password = var.git_password
  }
}

resource "helm_release" "flux_operator" {
  depends_on = [kubernetes_namespace.flux_system, helm_release.coredns]

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
    file("${path.module}/../../../kubernetes/main/apps/flux-system/instance/app/helm/values.yaml")
  ]
  set {
    name  = "distribution.version"
    value = "2.x"
  }

  set {
    name  = "instance.distribution.version"
    value = var.flux_version
  }
  set {
    name  = "instance.distribution.registry"
    value = var.flux_registry
  }

  set {
    name  = "instance.sync.kind"
    value = "GitRepository"
  }
  set {
    name  = "instance.sync.url"
    value = var.git_url
  }
  set {
    name  = "instance.sync.path"
    value = var.git_path
  }
  set {
    name  = "instance.sync.ref"
    value = var.git_ref
  }
  set {
    name  = "instance.sync.provider"
    value = "generic"
  }
  set {
    name  = "instance.sync.pullSecret"
    value = "git-token-auth"
  }
}
