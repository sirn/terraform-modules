resource "hcloud_floating_ip" "this" {
  name          = var.name
  type          = var.address_type
  home_location = var.hcloud_location != "" ? var.hcloud_location : null
  description   = var.description

  delete_protection = var.delete_protection
}

resource "hcloud_floating_ip_assignment" "this" {
  for_each = var.address_instance_id ? [1] : []

  floating_ip_id = hcloud_floating_ip.this.id
  server_id      = var.address_instance_id
}
