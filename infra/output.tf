output "terraform_output" {
  sensitive = true
  value     = module.talos-cluster
}

output "networks" {
  value = {
    controller_network = local.controller_network
    worker_network     = local.worker_network
  }
}
