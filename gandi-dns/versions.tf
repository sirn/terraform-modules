terraform {
  required_version = ">= 1.1.5"
  required_providers {
    gandi = {
      source  = "go-gandi/gandi"
      version = "2.2.4"
    }
  }
}
