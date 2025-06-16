output "talos-cluster" {
  value = {
    name = data.talos_client_configuration.this.cluster_name
  }
}
