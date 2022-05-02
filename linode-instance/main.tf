locals {
  keys_from_directory = (
    var.keys_dir != "" ?
    flatten(
      [
        for k in fileset(var.keys_dir, "*.pub") :
        [
          for l in split("\n", chomp(file("${var.keys_dir}/${k}"))) : l
        ]
      ]
    )
    : []
  )

  ssh_keys = concat(var.keys, local.keys_from_directory)
}

resource "linode_instance" "this" {
  label  = var.name
  region = var.linode_region
  image  = var.machine_image != "" ? var.machine_image : null
  type   = var.machine_type

  authorized_keys = local.ssh_keys
  private_ip      = var.private_networking

  group = var.machine_group != "" ? var.machine_group : null
  tags  = var.machine_tags

  lifecycle {
    ignore_changes = [
      config,
      swap_size,
      authorized_keys,
      disk,
    ]
  }
}
