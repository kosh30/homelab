resource "helm_release" "cert-manager" {
  depends_on       = [kubernetes_namespace.global]
  cleanup_on_fail  = "true"
  timeout          = "360"
  create_namespace = "false"
  namespace        = "cert-manager"
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"

  values = [
    file("${path.module}/../../../kubernetes/main/apps/cert-manager/cert-manager/app/helm/values.yaml")
  ]
}
