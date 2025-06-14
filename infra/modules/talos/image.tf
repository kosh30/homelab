locals {
  version      = var.image.version
  schematic    = var.image.schematic
  schematic_id = jsondecode(data.http.schematic_id.response_body)["id"]

  update_version      = coalesce(var.image.update_version, var.image.version)
  update_schematic    = coalesce(var.image.update_schematic, var.image.schematic)
  update_schematic_id = jsondecode(data.http.updated_schematic_id.response_body)["id"]

  image_id        = "${local.schematic_id}_${local.version}"
  update_image_id = "${local.update_schematic_id}_${local.update_version}"
}

data "http" "schematic_id" {
  url                = "${var.image.factory_url}/schematics"
  method             = "POST"
  request_body       = local.schematic
  request_timeout_ms = 300000
}

data "http" "updated_schematic_id" {
  url                = "${var.image.factory_url}/schematics"
  method             = "POST"
  request_body       = local.update_schematic
  request_timeout_ms = 300000
}

resource "talos_image_factory_schematic" "this" {
  schematic = local.schematic
}

resource "talos_image_factory_schematic" "updated" {
  schematic = local.update_schematic
}

locals {
  # _host_nodes = {
  #   for node_name, node in var.talos_nodes :
  #   node_name => {
  #     proxmox_host_node = node.proxmox_host_node
  #     update            = node.update
  #     version           = node.update ? local.update_version : local.version
  #   }
  # }
  # talos_nodes = local._host_nodes
  _proxmox_nodes = [for k, v in var.talos_nodes : v.proxmox_host_node]
  image_ids      = zipmap([for talos_node_name, talos_node in var.talos_nodes : "${talos_node.proxmox_host_node}_${talos_node.update ? local.update_image_id : local.image_id}"], local._proxmox_nodes)

}

resource "proxmox_virtual_environment_download_file" "this" {
  overwrite_unmanaged = true
  upload_timeout      = 600
  for_each            = local.image_ids

  # proxmox_node, talos version, schema_id
  node_name    = each.value
  content_type = "iso"
  datastore_id = var.image.proxmox_datastore

  file_name               = "talos-${talos_image_factory_schematic.this.id}-${each.key}-${var.image.platform}-${var.image.arch}.img"
  url                     = "${var.image.factory_url}/image/${talos_image_factory_schematic.this.id}/${local.version}/${var.image.platform}-${var.image.arch}.raw.xz"
  decompression_algorithm = "zst"
  overwrite               = false

  lifecycle {
    prevent_destroy = false
  }
}

output "image_id" {
  value = proxmox_virtual_environment_download_file.this
}
