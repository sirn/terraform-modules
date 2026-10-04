output "instance_id" {
  value = hcloud_server.this.id
}

output "instance_ipv4" {
  value = hcloud_server.this.ipv4_address
}

output "instance_ipv6" {
  value = hcloud_server.this.ipv6_address
}

output "instance_ipv6_network" {
  value = hcloud_server.this.ipv6_network
}

output "instance_network_ipv4" {
  value = var.network != null ? hcloud_server_network.this[0].ip : null
}
