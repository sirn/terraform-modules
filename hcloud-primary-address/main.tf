resource "hcloud_primary_ip" "this" {
  name = var.name

  location      = (var.hcloud_location != "" && var.primary_address_assignee_id == "") ? var.hcloud_location : null
  type          = var.primary_address_type
  assignee_type = var.primary_address_assignee_id != "" ? var.primary_address_assignee_type : null
  assignee_id   = var.primary_address_assignee_id != "" ? var.primary_address_assignee_id : null

  auto_delete = var.primary_address_auto_delete
}
