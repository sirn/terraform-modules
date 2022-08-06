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

variable "gcp_location" {
  description = "The Google Cloud location for this resource."
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "Enables destroying object on updates."
  type        = bool
  default     = false
}

variable "uniform_bucket_level_access" {
  description = "Enables uniform bucket-level access."
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Enables versioning."
  type        = bool
  default     = false
}

variable "lifecycle_rules" {
  description = "The versioning lifecycle rules."

  type = list(object({
    action    = map(string)
    condition = map(string)
  }))

  default = []
}

variable "iam" {
  description = "The list of IAM member and roles to bind to the bucket."

  type = list(object({
    role    = string
    members = list(string)
  }))

  default = []
}
