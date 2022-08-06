resource "upcloud_network" "this" {
  name   = var.network_name
  zone   = var.upcloud_zone
  router = var.network_router

  ip_network {
    address = var.network_cidr
    dhcp    = var.network_dhcp
    family  = var.network_family
  }
}
