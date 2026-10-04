# hcloud-instance

Create a Hetzner server with optional private-network attachment.

The `network` input defaults to null. To attach the server, supply:

~~~hcl
network = {
  subnet_id = module.network.subnet_id
  ip        = "10.0.0.2"
}
~~~

Use the cloud subnet ID, not the network ID. The object must be known as
non-null during planning, but its subnet ID can be unknown. This permits a
new network and server attachment in one plan without a separate enable flag.
Do not manage the same attachment through an inline server network block.

`instance_network_ipv4` returns the attachment IP, or null without an
attachment. Existing public outputs and the server resource address stay
unchanged. Terraform does not configure the guest interface or routes.

Run `terraform init -backend=false` and `terraform test` in this directory.
Tests cover no attachment, an attachment, and a first plan with an unknown
subnet ID. Tests use a mock provider and require Terraform 1.7 or later.
Module use still requires Terraform 1.5 or later.
