mock_provider "hcloud" {}

run "unassigned_address" {
  command = plan

  variables {
    name                 = "test-ipv4"
    hcloud_location      = "fsn1"
    primary_address_type = "ipv4"
  }

  assert {
    condition     = output.primary_address_location == "fsn1"
    error_message = "The address must use the requested location."
  }

  assert {
    condition     = output.primary_address_type == "ipv4" && !hcloud_primary_ip.this.auto_delete
    error_message = "The address must retain the requested type and survive server deletion by default."
  }
}

run "assigned_address" {
  command = plan

  variables {
    name                        = "test-ipv6"
    primary_address_type        = "ipv6"
    primary_address_assignee_id = "123"
  }

  assert {
    condition     = output.primary_address_assignee_id == 123 && output.primary_address_assignee_type == "server"
    error_message = "An assigned address must use the requested server."
  }
}
