variable "network_name" {
  description = "The name for this network."
  type        = string
}

variable "upcloud_zone" {
  description = "The Upcloud region for this resource."
  type        = string
}

variable "network_cidr" {
  description = "The CIDR for the network."
  type        = string
  default     = "10.0.0.0/24"
}

variable "network_dhcp" {
  description = "Enables DHCP for the network."
  type        = bool
  default     = true
}

variable "network_router" {
  description = "The ID of the router to attach this network to."
  type        = string
}

variable "network_family" {
  description = "The network familyi for this network."
  type        = string
  default     = "IPv4"
}
