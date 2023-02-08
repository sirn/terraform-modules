variable "instance_id" {
  description = "The instance ID to assign IP address range to"
  type        = string
}

variable "prefix_length" {
  description = "The prefix length to request IPv6 range for"
  type        = number
  default     = 64
}
