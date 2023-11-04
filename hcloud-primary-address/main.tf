resource "hcloud_primary_ip" "this" {
  name          = var.name

  datacenter    = (var.hcloud_dc != "" && var.primary_address_assignee_id == "") ? var.hcloud_dc : null
  type          = var.primary_address_type
  assignee_type = var.primary_address_assignee_type
  assignee_id   = var.primary_address_assignee_id != "" ? var.primary_address_assignee_id : null

  auto_delete = var.primary_address_auto_delete
}
