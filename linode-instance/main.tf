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
  tags       = var.machine_tags

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
  for_each  = { for v in var.disks : v.name => v }
  linode_id = linode_instance.this.id

  label           = each.value.name
  size            = each.value.size
  filesystem      = each.value.filesystem
  image           = each.value.image != "" ? each.value.image : null
  authorized_keys = each.value.image != "" ? local.ssh_keys : null
}

resource "linode_instance_config" "this" {
  for_each  = { for v in var.configs : v.name => v }
  linode_id = linode_instance.this.id

  label       = each.value.name
  kernel      = each.value.kernel != "" ? each.value.kernel : "linode/direct-disk"
  virt_mode   = each.value.virt_mode
  root_device = each.value.root_device

  dynamic "device" {
    for_each = each.value.disks
    content {
      device_name = device.key
      disk_id     = linode_instance_disk.this[device.value.disk].id
    }
  }

  helpers {
    devtmpfs_automount = lookup(each.value.helpers, "devtmpfs_automount", true)
    distro             = lookup(each.value.helpers, "distro", true)
    modules_dep        = lookup(each.value.helpers, "modules_dep", true)
    network            = lookup(each.value.helpers, "network", false)
    updatedb_disabled  = lookup(each.value.helpers, "updatedb_disabled", true)
  }
}

resource "linode_volume" "this" {
  for_each = { for v in var.volumes : v.name => v }

  label  = each.value.name
  size   = each.value.size
  region = var.linode_region
}
