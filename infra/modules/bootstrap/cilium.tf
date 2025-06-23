resource "helm_release" "cilium" {
  depends_on       = [kubernetes_namespace.global]
  cleanup_on_fail  = "true"
  timeout          = "360"
  create_namespace = "false"
  namespace        = "kube-system"
  name             = "cilium"
  repository       = "https://helm.cilium.io/"
  chart            = "cilium"

  values = [
    file("${path.module}/../../../kubernetes/main/apps/kube-system/cilium/app/helm/values.yaml")
  ]
}
