
terraform {
  required_version = ">= 1"
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = ">= 18.0.0"
    }
  }
}
data "gitlab_project" "by_id" {
  count = var.gitlab_project_id != 0 ? 1 : 0
  id    = var.gitlab_project_id
}

data "gitlab_project" "by_namespace" {
  count               = var.gitlab_project_id == 0 ? 1 : 0
  path_with_namespace = var.gitlab_project_path_with_namespace
}

locals {
  gitlab_broject = var.gitlab_project_id != 0 ? data.gitlab_project.by_id[0] : data.gitlab_project.by_namespace[0]
}


resource "gitlab_cluster_agent" "this" {
  name    = "${var.cluster_name}-${var.proxmox.cluster_name}"
  project = local.gitlab_broject.id
}

resource "gitlab_repository_file" "agent_config" {
  project   = gitlab_cluster_agent.this.project
  branch    = "main" // or use the `default_branch` attribute from a project data source / resource
  file_path = ".gitlab/agents/${gitlab_cluster_agent.this.name}/config.yaml"
  encoding  = "base64"
  content = base64encode(<<CONTENT
# the GitLab Agent for Kubernetes configuration goes here ...
ci_access:
  projects:
    - id: ${local.gitlab_broject.id}
CONTENT
  )
  author_email          = "terraform@kosh.casa"
  author_name           = "Terraform"
  create_commit_message = "feature: add agent config for ${gitlab_cluster_agent.this.name} [skip ci]"
  delete_commit_message = "feature: remove agent config for ${gitlab_cluster_agent.this.name} [skip ci]"
  update_commit_message = "feature: update agent config for ${gitlab_cluster_agent.this.name} [skip ci]"
  overwrite_on_create   = true
}

variable "fluxcd_bootstrap_public_key" {
  type = string
}
resource "gitlab_deploy_key" "fluxcd_bootstrap_key" {
  key      = var.fluxcd_bootstrap_public_key
  project  = local.gitlab_broject.id
  title    = "${var.cluster_name}-fluxcd-key"
  can_push = true
}

output "gitlab_project_data" {
  sensitive = true
  value     = var.gitlab_project_id != 0 ? data.gitlab_project.by_id[0] : data.gitlab_project.by_namespace[0]
}

resource "gitlab_deploy_token" "gitlab-ro-token" {
  project = local.gitlab_broject.id
  name    = "flux-${var.cluster_name}-ro-token"
  scopes = [
    "read_repository"
  ]
}

output "deploy_token" {
  sensitive = true
  value     = gitlab_deploy_token.gitlab-ro-token
}
