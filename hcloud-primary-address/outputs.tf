output "primary_address_id" {
  value = hcloud_primary_ip.this.id
}

output "primary_address_type" {
  value = hcloud_primary_ip.this.type
}

output "primary_address_zone" {
  value = hcloud_primary_ip.this.datacenter
}

output "primary_address_ip_address" {
  value = hcloud_primary_ip.this.ip_address
}

output "primary_address_cidr" {
  value = hcloud_primary_ip.this.ip_network
}

output "primary_address_assignee_id" {
  value = hcloud_primary_ip.this.assignee_id
}

output "primary_address_assignee_type" {
  value = hcloud_primary_ip.this.assignee_type
}

output "primary_address_delete_protection" {
  value = hcloud_primary_ip.this.delete_protection
}
