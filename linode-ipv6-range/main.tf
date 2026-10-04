resource "linode_ipv6_range" "this" {
  linode_id     = var.instance_id
  prefix_length = var.prefix_length
}
