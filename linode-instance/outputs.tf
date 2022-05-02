output "instance_id" {
  value = linode_instance.this.id
}

output "instance_ipv4" {
  value = element(tolist(linode_instance.this.ipv4), 0)
}

output "instance_ipv6" {
  // cidrhost doesn't work here since it requires the host bit to be
  // lower than that of the prefix (so we can't trim /128 with /128)
  value = element(regex("^([^/]+)(/[0-9]+)?$", linode_instance.this.ipv6), 0)
}

output "instance_ipv4_private" {
  value = linode_instance.this.private_ip_address
}
