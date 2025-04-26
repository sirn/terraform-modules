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
  type   = var.machine_type

  image           = var.machine_image != "" ? var.machine_image : null
  authorized_keys = var.machine_image != "" && length(var.disks) == 0 ? local.ssh_keys : null

  private_ip = var.private_networking

  group = var.machine_group != "" ? var.machine_group : null
  tags  = var.machine_tags

  booted            = var.booted
  boot_config_label = var.boot_config != "" ? var.boot_config : null

  lifecycle {
    ignore_changes = [
      booted,
      authorized_keys,
      swap_size,
    ]
  }
}

resource "linode_instance_disk" "this" {
  for_each  = { for v in var.disks : lower(v.name) => v }
  linode_id = linode_instance.this.id

  label           = each.value.name
  size            = each.value.size
  filesystem      = each.value.filesystem
  image           = each.value.image != "" ? each.value.image : null
  authorized_keys = each.value.image != "" ? local.ssh_keys : null
}

resource "linode_instance_config" "this" {
  for_each  = { for v in var.configs : lower(v.name) => v }
  linode_id = linode_instance.this.id

  label       = config.value.name
  kernel      = config.value.kernel != "" ? config.value.kernel : "linode/direct-disk"
  virt_mode   = config.value.virt_mode
  root_device = config.value.root_device

  helpers {
    devtmpfs_automount = lookup(config.value.helpers, "devtmpfs_automount", true)
    distro             = lookup(config.value.helpers, "distro", true)
    modules_dep        = lookup(config.value.helpers, "modules_dep", true)
    network            = lookup(config.value.helpers, "network", false)
    updatedb_disabled  = lookup(config.value.helpers, "updatedb_disabled", true)
  }
}

resource "linode_volume" "this" {
  for_each = { for v in var.volumes : v.name => v }

  label  = each.value.name
  size   = each.value.size
  region = var.linode_region
}
