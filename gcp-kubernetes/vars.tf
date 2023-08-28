variable "name" {
  description = "The name for this resource."
  type        = string
}

variable "gcp_location" {
  description = "The Google Cloud zone for this resource."
  type        = string
  default     = ""
}

variable "gcp_zone" {
  description = "The Google Cloud zone for this resource."
  type        = string
  default     = ""
}

variable "network" {
  description = "The name or self link of the network to use with this cluster."
  type        = string
  default     = "default"
}

variable "workload_identity_enabled" {
  description = "Enables Workload Identity for this cluster."
  type        = bool
  default     = true
}

variable "version_prefix" {
  description = "The version prefix of the Kubernetes master for this cluster."
  type        = string
  default     = "1."
}

variable "release_channel" {
  description = "The release channel of the Kubernetes master for this cluster."
  type        = string
  default     = "REGULAR"
}
