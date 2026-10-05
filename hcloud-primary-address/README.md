# hcloud-primary-address

Create a Hetzner Primary IP in `hcloud_location`, such as `fsn1`.
Alternatively, set `primary_address_assignee_id` to create and assign the
address to a server. The location comes from that server.

Use `hcloud_location` instead of the removed `hcloud_dc` input.
`primary_address_location` replaces `primary_address_zone` and returns the
location, not a datacenter.

The address is retained when its server is deleted by default
(`primary_address_auto_delete: false`).

Module use requires Terraform 1.14 or later and hcloud 1.68.x.
Run `terraform init -backend=false` and `terraform test` in this directory.
Tests use a mock provider and do not call Hetzner.
