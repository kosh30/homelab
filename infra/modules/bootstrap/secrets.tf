variable "bitwarden" {
  type = object({
    token          = string
    projectID      = string
    organizationID = string
  })
}
resource "kubernetes_secret" "bitwarden" {
  depends_on = [kubernetes_namespace.global]
  metadata {
    name      = "bitwarden"
    namespace = "external-secrets"
  }
  data = {
    token          = var.bitwarden.token
    projectID      = var.bitwarden.projectID
    organizationID = var.bitwarden.organizationID
  }
}
