locals {
  crds = [
    # renovate: datasource=github-releases depName=kubernetes-sigs/external-dns
    "https://raw.githubusercontent.com/kubernetes-sigs/external-dns/refs/tags/v0.17.0/config/crd/standard/dnsendpoint.yaml",
    # renovate: datasource=github-releases depName=kubernetes-sigs/gateway-api
    "https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.3.0/experimental-install.yaml",
    # renovate: datasource=github-releases depName=prometheus-operator/prometheus-operator
    "https://github.com/prometheus-operator/prometheus-operator/releases/download/v0.83.0/stripped-down-crds.yaml",
  ]
}
