variable "network_name" {
  description = "The name for this network."
  type        = string
}

variable "subnetwork_name" {
  description = "The name for this subnetwork."
  type        = string
  default     = ""
}

variable "gcp_region" {
  description = "The Google Cloud region for this resource."
  type        = string
}

variable "network_cidr" {
  description = "The CIDR for the network."
  type        = string
  default     = "192.168.64.0/20"
}

variable "auto_create_subnetworks" {
  description = "Automatically create subnetworks."
  type        = bool
  default     = false
}
