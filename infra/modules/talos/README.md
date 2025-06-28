# talos

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >=3.4.5 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >=2.5.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >=3.2.3 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.66.1 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | >=0.6.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | 3.5.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.3 |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.78.2 |
| <a name="provider_talos"></a> [talos](#provider\_talos) | 0.8.1 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.13.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.review](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [proxmox_virtual_environment_download_file.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file) | resource |
| [proxmox_virtual_environment_file.controlplane_metadata](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_file.worker_metadata](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_vm.controllplanes](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |
| [proxmox_virtual_environment_vm.workers](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |
| [talos_cluster_kubeconfig.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/cluster_kubeconfig) | resource |
| [talos_image_factory_schematic.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/image_factory_schematic) | resource |
| [talos_image_factory_schematic.updated](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/image_factory_schematic) | resource |
| [talos_machine_bootstrap.controlplane](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_bootstrap) | resource |
| [talos_machine_configuration_apply.controlplane](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_configuration_apply.workers](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_secrets.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_secrets) | resource |
| [time_sleep.controlerplane](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [http_http.schematic_id](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.updated_schematic_id](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [talos_client_configuration.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/client_configuration) | data source |
| [talos_machine_configuration.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/machine_configuration) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Cluster configuration | <pre>object({<br/>    name                       = string<br/>    endpoint_ip                = string<br/>    endpoint_hostname          = string<br/>    endpoint_hostname_external = optional(string)<br/>    gateway                    = string<br/>    talos_version              = string<br/>    proxmox_cluster_name       = string<br/>    proxmox_network            = string<br/>    proxmox_endpoint           = string<br/>    vlan_id                    = optional(number)<br/>  })</pre> | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | Talos image configuration | <pre>object({<br/>    factory_url       = optional(string, "https://factory.talos.dev")<br/>    schematic         = string<br/>    version           = string<br/>    update_schematic  = optional(string)<br/>    update_version    = optional(string)<br/>    arch              = optional(string, "amd64")<br/>    platform          = optional(string, "nocloud")<br/>    proxmox_datastore = optional(string, "local")<br/>  })</pre> | n/a | yes |
| <a name="input_talos_nodes"></a> [talos\_nodes](#input\_talos\_nodes) | Configuration for cluster nodes | <pre>map(object({<br/>    machine_type       = string<br/>    cpu                = number<br/>    ram_dedicated      = number<br/>    data_disk_size     = optional(number, 20)<br/>    datastore_snippets = optional(string)<br/>    datastore_image    = optional(string)<br/>    datastore_rootfs   = optional(string)<br/>    igpu               = optional(bool, false)<br/>    ip                 = optional(string, "")<br/>    host_cidr          = optional(string, "24")<br/>    mac_address        = optional(string)<br/>    os_disk_size       = optional(number, 10)<br/>    proxmox_host_node  = string<br/>    update             = optional(bool, false)<br/>    vm_id              = optional(number)<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_image_id"></a> [image\_id](#output\_image\_id) | n/a |
| <a name="output_kubeconfig_config"></a> [kubeconfig\_config](#output\_kubeconfig\_config) | n/a |
| <a name="output_talos-cluster"></a> [talos-cluster](#output\_talos-cluster) | n/a |
| <a name="output_talos_config"></a> [talos\_config](#output\_talos\_config) | n/a |
<!-- END_TF_DOCS -->
