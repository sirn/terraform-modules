output "address_id" {
  value = hcloud_floating_ip.this.id
}

output "address_type" {
  value = hcloud_floating_ip.this.type
}

output "address_ip_address" {
  value = hcloud_floating_ip.this.ip_address
}

output "address_cidr" {
  value = hcloud_floating_ip.this.ip_network
}

output "address_assignment_id" {
  value = hcloud_floating_ip_assignment.this[0].id
}

output "address_assignment_instance_id" {
  value = hcloud_floating_ip_assignment.this[0].server_id
}
