resource "upcloud_server" "this" {
  hostname = var.name
  zone     = var.upcloud_zone
  plan     = var.machine_type

  template {
    storage = var.machine_image
    size    = var.machine_disk_size
  }

  dynamic "network_interface" {
    for_each = var.networks

    content {
      type = network_interface.value.type
      network = (
        lookup(network_interface.value, "network", null) != null ?
        network_interface.value.network :
        null
      )
      ip_address = (
        lookup(network_interface.value, "ip_address", null) != null ?
        network_interface.value.ip_address :
        null
      )
      ip_address_family = (
        lookup(network_interface.value, "ip_address_family", null) != null ? network_interface.value.ip_address_family :
        null
      )
    }
  }
}
