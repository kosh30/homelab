
variable "gitlab_project_id" {
  type        = number
  default     = 0
  description = "Gitlab project id"
}

variable "gitlab_project_path_with_namespace" {
  type        = string
  default     = ""
  description = "Gitlab project namespace"
  validation {
    condition     = (var.gitlab_project_id != 0 || var.gitlab_project_path_with_namespace != "")
    error_message = "Gitlab project id or project namespace should be defined"
  }
}

variable "cluster_name" {
  type    = string
  default = "k8s"
}
variable "proxmox" {
  type = any
}
