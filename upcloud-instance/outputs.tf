output "instance_id" {
  value = upcloud_server.this.id
}

output "instance_mac_address" {
  value = element(concat([
    for net in upcloud_server.this.network_interface :
    net.mac_address if "${net.ip_address_family}-${net.type}" == "IPv4-public"
  ], [null]), 0)
}

output "instance_ipv4" {
  value = element(concat([
    for net in upcloud_server.this.network_interface :
    net.ip_address if "${net.ip_address_family}-${net.type}" == "IPv4-public"
  ], [null]), 0)
}

output "instance_ipv4_private" {
  value = element(concat([
    for net in upcloud_server.this.network_interface :
    net.ip_address if "${net.ip_address_family}-${net.type}" == "IPv4-private"
  ], [null]), 0)
}

output "instance_ipv6" {
  value = element(concat([
    for net in upcloud_server.this.network_interface :
    net.ip_address if "${net.ip_address_family}-${net.type}" == "IPv6-public"
  ], [null]), 0)
}

output "instance_ipv6_private" {
  value = element(concat([
    for net in upcloud_server.this.network_interface :
    net.ip_address if "${net.ip_address_family}-${net.type}" == "IPv6-private"
  ], [null]), 0)
}
