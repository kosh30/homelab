resource "helm_release" "coredns" {
  depends_on       = [helm_release.cilium]
  cleanup_on_fail  = "true"
  timeout          = "360"
  create_namespace = "false"
  namespace        = "kube-system"
  name             = "coredns"
  repository       = "https://coredns.github.io/helm"
  chart            = "coredns"

  values = [
    file("${path.module}/../../../kubernetes/main/apps/kube-system/coredns/app/helm/values.yaml")
  ]
}
