resource "upcloud_floating_ip_address" "this" {
  zone        = var.upcloud_zone
  mac_address = var.mac_address != "" ? var.mac_address : null
}
