variable "name" {
  description = "The name for this resource."
  type        = string
}

variable "address_type" {
  description = "The type of the address."
  type        = string
}

variable "hcloud_location" {
  description = "The Hetzner location for this resource."
  type        = string
}

variable "description" {
  description = "The description for the IP address."
  type        = string
  default     = ""
}

variable "delete_protection" {
  description = "Whether to prevent IP address from being deleted."
  type        = bool
  default     = true
}

variable "address_instance_id" {
  description = "The instance ID of a server to assign an address to."
  type        = string
  default     = ""
}
