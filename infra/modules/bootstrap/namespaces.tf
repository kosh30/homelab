locals {
  namespcaces = [
    "external-secrets",
    "network"
  ]
}

resource "kubernetes_namespace" "global" {
  depends_on = [
    kubectl_manifest.gateway_api_crds,
    kubectl_manifest.apply_prometheus_operator_crds
  ]
  for_each = toset(local.namespcaces)
  metadata {
    name = each.key
  }
  lifecycle {
    ignore_changes = [metadata]
  }
}
