resource "helm_release" "external-secrets" {
  depends_on       = [helm_release.cert-manager]
  cleanup_on_fail  = "true"
  timeout          = "360"
  create_namespace = "false"
  namespace        = "external-secrets"
  name             = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"

  values = [
    file("${path.module}/../../../kubernetes/main/apps/external-secrets/external-secrets/app/helm/values.yaml")
  ]
}

resource "kubernetes_secret" "cloudflare-tunnel-id-secret" {
  depends_on = [kubernetes_namespace.global]
  metadata {
    name      = "cloudflare-tunnel-id-secret"
    namespace = "network"
  }
  data = {
    CLOUDFLARE_TUNNEL_ID : ""
  }

  lifecycle {
    ignore_changes = [metadata]
  }
}
