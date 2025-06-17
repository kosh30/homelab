resource "helm_release" "cilium" {
  cleanup_on_fail  = "true"
  timeout          = "360"
  create_namespace = "false"
  namespace        = "kube-system"
  name             = "cilium"
  repository       = "oci://ghcr.io/home-operations/charts-mirror/cilium"
  chart            = "cilium"

  values = [
    file("${path.module}/../../../kubernetes/main/apps/kube-system/cilium/app/helm/values.yaml")
  ]
}
