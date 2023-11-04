variable "name" {
  description = "The name of the primary address"
  type        = string
}

variable "hcloud_dc" {
  description = "The Hetzner datacenter for this resource"
  type        = string
  default     = ""
}

variable "primary_address_type" {
  description = "The type of the address"
  type        = string
}

variable "primary_address_assignee_type" {
  description = "The assignee type of the address"
  type        = string
  default     = "server"
}

variable "primary_address_assignee_id" {
  description = "The assignee ID of the address"
  type        = string
  default     = ""
}

variable "primary_address_auto_delete" {
  description = "Whether to automatically delete the address after VM termination"
  type        = bool
  default     = false
}
