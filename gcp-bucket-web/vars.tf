variable "name" {
  description = "The name for this resource."
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
  default     = true
}

variable "main_page_suffix" {
  description = "The index document for the website."
  type        = string
  default     = "index.html"
}

variable "not_found_page" {
  description = "The 404 page for the website."
  type        = string
  default     = "404.html"
}

variable "iam" {
  description = "The list of IAM member and roles to bind to the bucket."
  type = list(object({
    role    = string
    members = list(string)
  }))
  default = []
}
