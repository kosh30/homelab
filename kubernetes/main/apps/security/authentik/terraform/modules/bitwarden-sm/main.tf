terraform {
  required_version = ">= 1"
  required_providers {
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = ">= 0.13.6"
    }
  }
}

variable "secret" {
  description = "Secret name to find the Item in"
  type        = string
}

variable "organizationID" {
  type = string
}

data "bitwarden_secret" "secret" {
  key             = var.secret
  organization_id = var.organizationID
}

output "fields" {
  value = jsondecode(data.bitwarden_secret.secret.value)
}
