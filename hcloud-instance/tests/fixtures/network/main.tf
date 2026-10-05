terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.68.0"
    }
  }
}

module "network" {
  source = "../../../../hcloud-network"

  network_name = "test"
}

module "instance" {
  source = "../../.."

  machine_image   = "debian-12"
  machine_type    = "cax11"
  hcloud_location = "fsn1"
  network = {
    subnet_id = module.network.subnet_id
    ip        = "10.0.0.2"
  }
}

output "instance_network_ipv4" {
  value = module.instance.instance_network_ipv4
}
