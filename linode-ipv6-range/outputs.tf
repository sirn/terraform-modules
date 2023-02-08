output "network" {
  value = "${linode_ipv6_range.this.range}/${linode_ipv6_range.this.prefix_length}"
}

output "prefix" {
  value = linode_ipv6_range.this.range
}

output "prefix_length" {
  value = linode_ipv6_range.this.prefix_length
}
