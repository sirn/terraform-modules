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

  authorized_keys = length(local.disks) == 0 ? local.ssh_keys : null
  private_ip      = var.private_networking

  group = var.machine_group != "" ? var.machine_group : null
  tags  = var.machine_tags

  dynamic "config" {
    for_each = var.configs

    content {
      label       = config.value.name
      kernel      = config.value.kernel != "" ? config.value.kernel : "linode/direct-disk"
      virt_mode   = config.value.virt_mode
      root_device = config.value.root_device

      devices {
        dynamic "sda" {
          for_each = lookup(config.value.disks, "sda", null) != null ? [config.value.disks.sda] : []
          content {
            disk_label = lookup(sda.value, "disk", null)
            volume_id = (
              lookup(sda.value, "volume", null) != null ?
              linode_volume.this[sda.value.volume].id :
              null
            )
          }
        }
        dynamic "sdb" {
          for_each = lookup(config.value.disks, "sdb", null) != null ? [config.value.disks.sdb] : []
          content {
            disk_label = lookup(sdb.value, "disk", null)
            volume_id = (
              lookup(sdb.value, "volume", null) != null ?
              linode_volume.this[sdb.value.volume].id :
              null
            )
          }
        }
        dynamic "sdc" {
          for_each = lookup(config.value.disks, "sdc", null) != null ? [config.value.disks.sdc] : []
          content {
            disk_label = lookup(sdc.value, "disk", null)
            volume_id = (
              lookup(sdc.value, "volume", null) != null ?
              linode_volume.this[sdc.value.volume].id :
              null
            )
          }
        }
        dynamic "sdd" {
          for_each = lookup(config.value.disks, "sdd", null) != null ? [config.value.disks.sdd] : []
          content {
            disk_label = lookup(sdd.value, "disk", null)
            volume_id = (
              lookup(sdd.value, "volume", null) != null ?
              linode_volume.this[sdd.value.volume].id :
              null
            )
          }
        }
        dynamic "sde" {
          for_each = lookup(config.value.disks, "sde", null) != null ? [config.value.disks.sde] : []
          content {
            disk_label = lookup(sde.value, "disk", null)
            volume_id = (
              lookup(sde.value, "volume", null) != null ?
              linode_volume.this[sde.value.volume].id :
              null
            )
          }
        }
        dynamic "sdf" {
          for_each = lookup(config.value.disks, "sdf", null) != null ? [config.value.disks.sdf] : []
          content {
            disk_label = lookup(sdf.value, "disk", null)
            volume_id = (
              lookup(sdf.value, "volume", null) != null ?
              linode_volume.this[sdf.value.volume].id :
              null
            )
          }
        }
        dynamic "sdg" {
          for_each = lookup(config.value.disks, "sdg", null) != null ? [config.value.disks.sdg] : []
          content {
            disk_label = lookup(sdg.value, "disk", null)
            volume_id = (
              lookup(sdg.value, "volume", null) != null ?
              linode_volume.this[sdg.value.volume].id :
              null
            )
          }
        }
        dynamic "sdh" {
          for_each = lookup(config.value.disks, "sdh", null) != null ? [config.value.disks.sdh] : []
          content {
            disk_label = lookup(sdh.value, "disk", null)
            volume_id = (
              lookup(sdh.value, "volume", null) != null ?
              linode_volume.this[sdh.value.volume].id :
              null
            )
          }
        }
      }

      helpers {
        devtmpfs_automount = lookup(config.value.helpers, "devtmpfs_automount", true)
        distro             = lookup(config.value.helpers, "distro", true)
        modules_dep        = lookup(config.value.helpers, "modules_dep", true)
        network            = lookup(config.value.helpers, "network", false)
        updatedb_disabled  = lookup(config.value.helpers, "updatedb_disabled", true)
      }
    }
  }

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
  for_each  = { for v in var.disks : v.label => v }
  linode_id = linode_instance.this

  label           = each.value.name
  size            = each.value.size
  filesystem      = each.value.filesystem
  image           = each.value.image != "" ? each.value.image : null
  authorized_keys = local.ssh_keys
}

resource "linode_volume" "this" {
  for_each = { for v in var.volumes : v.name => v }

  label  = each.value.name
  size   = each.value.size
  region = var.linode_region
}
