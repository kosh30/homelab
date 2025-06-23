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

locals {
  gateway_api_crds_urls = [
    # renovate: datasource=github-releases depName=kubernetes-sigs/gateway-api
    "https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.3.0/experimental-install.yaml"
  ]
}

data "http" "gateway_api_crds" {
  count = length(local.gateway_api_crds_urls)
  url   = local.gateway_api_crds_urls[count.index]
}

# Install Gateway API CRD's. Requirement to be installed before Cilium is running
resource "kubectl_manifest" "gateway_api_crds" {
  count     = length(local.gateway_api_crds_urls)
  yaml_body = data.http.gateway_api_crds[count.index].body
}
