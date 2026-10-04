variable "network_name" {
  description = "The name for the private network."
  type        = string
}

variable "network_ip_range" {
  description = "The IP range for the private network."
  type        = string
  default     = "10.0.0.0/16"
}

variable "network_zone" {
  description = "The Hetzner network zone for the subnet."
  type        = string
  default     = "eu-central"
}

variable "subnet_ip_range" {
  description = "The IP range for the cloud subnet."
  type        = string
  default     = "10.0.0.0/24"
}
