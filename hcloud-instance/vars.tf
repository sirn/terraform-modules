variable "name" {
  description = "The name for this resource."
  type        = string
  default     = "instance"
}

variable "hcloud_location" {
  description = "The Hetzner location for this resource"
  type        = string
  default     = ""
}

variable "hcloud_dc" {
  description = "The Hetzner datacenter for this resource"
  type        = string
  default     = ""
}

variable "machine_type" {
  description = "The machine type for the VM."
  type        = string
  default     = "CX11"
}

variable "machine_image" {
  description = "The disk image for the VM."
  type        = string
  default     = ""
}

variable "network" {
  description = "The private subnet and IP for this server."
  type = object({
    subnet_id = string
    ip        = string
  })
  default = null
}

variable "network_ipv4_enabled" {
  description = "Whether to enable IPv4 for the resource."
  type        = bool
  default     = true
}

variable "network_ipv6_enabled" {
  description = "Whether to enable IPv6 for the resource."
  type        = bool
  default     = true
}

variable "network_ipv4_primary_address_id" {
  description = "The primary address ID for an IPv4"
  type        = string
  default     = ""
}

variable "network_ipv6_primary_address_id" {
  description = "The primary address ID for an IPv6"
  type        = string
  default     = ""
}
