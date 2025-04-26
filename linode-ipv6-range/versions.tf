terraform {
  required_version = ">= 1.1.5"
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 2.38.0"
    }
  }
}
