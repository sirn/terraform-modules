variable "mac_address" {
  description = "The MAC address of the machine to attach to."
  type        = string
  default     = ""
}

variable "upcloud_zone" {
  description = "The Upcloud region for this resource."
  type        = string
}
