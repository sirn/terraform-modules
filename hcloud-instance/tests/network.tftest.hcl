mock_provider "hcloud" {}

run "without_network" {
  command = plan

  variables {
    machine_image   = "debian-12"
    machine_type    = "cax11"
    hcloud_location = "fsn1"
  }

  assert {
    condition     = output.instance_network_ipv4 == null
    error_message = "An unattached server must not have a private IP."
  }
}

run "with_network" {
  command = plan

  variables {
    machine_image   = "debian-12"
    machine_type    = "cax11"
    hcloud_location = "fsn1"
    network = {
      subnet_id = "123-10.0.0.0/24"
      ip        = "10.0.0.2"
    }
  }

  assert {
    condition     = output.instance_network_ipv4 == "10.0.0.2"
    error_message = "The private IP must match the requested attachment."
  }
}

run "with_unknown_subnet" {
  command = plan

  module {
    source = "./tests/fixtures/network"
  }

  assert {
    condition     = output.instance_network_ipv4 == "10.0.0.2"
    error_message = "A first plan must accept an unknown subnet ID."
  }
}
