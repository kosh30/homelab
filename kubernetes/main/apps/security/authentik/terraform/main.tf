locals {
  bitwarden_organizationID = data.terraform_remote_state.talos.outputs.bitwarden.organizationID
}
