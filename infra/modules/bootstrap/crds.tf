data "helm_template" "prometheus_operator_crds" {
  chart      = "prometheus-operator-crds"
  name       = "prometheus-operator-crds"
  repository = "https://prometheus-community.github.io/helm-charts"
}

data "kubectl_file_documents" "prometheus_operator_crds" {
  content = data.helm_template.prometheus_operator_crds.manifest
}

resource "kubectl_manifest" "apply_prometheus_operator_crds" {
  for_each          = data.kubectl_file_documents.prometheus_operator_crds.manifests
  yaml_body         = each.value
  server_side_apply = true
  apply_only        = true
  force_conflicts   = true
}
