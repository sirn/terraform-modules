mock_provider "hcloud" {}

run "default_subnet" {
  command = plan

  variables {
    network_name = "test"
  }

  assert {
    condition     = hcloud_network.this.name == "test" && hcloud_network.this.ip_range == "10.0.0.0/16"
    error_message = "The network must use the requested name and default range."
  }

  assert {
    condition     = hcloud_network_subnet.this.ip_range == "10.0.0.0/24" && hcloud_network_subnet.this.network_zone == "eu-central" && hcloud_network_subnet.this.type == "cloud"
    error_message = "The default subnet must be a cloud subnet in eu-central."
  }
}

run "custom_subnet" {
  command = plan

  variables {
    network_name     = "custom"
    network_ip_range = "10.20.0.0/16"
    subnet_ip_range  = "10.20.1.0/24"
    network_zone     = "us-east"
  }

  assert {
    condition     = hcloud_network.this.ip_range == "10.20.0.0/16" && hcloud_network_subnet.this.ip_range == "10.20.1.0/24" && hcloud_network_subnet.this.network_zone == "us-east"
    error_message = "The network and subnet must accept caller settings."
  }
}
