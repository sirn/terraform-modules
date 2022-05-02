variable "name" {
  description = "The name for this resources."
  type        = string
  default     = "instance"
}

variable "gcp_region" {
  description = "The Google Cloud region for this resource."
  type        = string
  default     = ""
}
