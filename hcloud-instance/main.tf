resource "hcloud_server" "this" {
  name        = var.name
  image       = var.machine_image
  server_type = var.machine_type

  location   = (var.hcloud_location != "" && var.hcloud_dc == "") ? var.hcloud_location : null
  datacenter = var.hcloud_dc != "" ? var.hcloud_dc : null

  public_net {
    ipv4_enabled = var.network_ipv4_enabled
    ipv6_enabled = var.network_ipv6_enabled
    ipv4         = var.network_ipv4_primary_address_id != "" ? var.network_ipv4_primary_address_id : null
    ipv6         = var.network_ipv6_primary_address_id != "" ? var.network_ipv6_primary_address_id : null
  }

  lifecycle {
    ignore_changes = [
      image,
    ]
  }
}

resource "hcloud_server_network" "this" {
  count = var.network != null ? 1 : 0

  server_id = hcloud_server.this.id
  subnet_id = var.network.subnet_id
  ip        = var.network.ip
}
