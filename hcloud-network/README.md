# hcloud-network

Create a Hetzner private network and one cloud subnet.

| Input | Default |
| --- | --- |
| `network_name` | required |
| `network_ip_range` | `10.0.0.0/16` |
| `network_zone` | `eu-central` |
| `subnet_ip_range` | `10.0.0.0/24` |

Outputs: `network_id` and `subnet_id`. Pass `subnet_id` to
hcloud-instance's optional `network` object. A server location such as FSN1
is not a network zone.

Terraform creates the attachment, not the guest interface configuration.
Configure guest IPs and routes separately. Reserve the subnet gateway address.

Run `terraform init -backend=false` and `terraform test` in this directory.
Tests use a mock provider and do not call Hetzner. Module use requires
Terraform 1.14 or later and hcloud 1.68.x.
