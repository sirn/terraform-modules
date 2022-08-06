variable "service_account_id" {
  description = "The ID of the Service Account."
  type        = string
}

variable "service_account_name" {
  description = "The name of the Service Account."
  type        = string
}

variable "roles" {
  description = "The list of roles to assign to the Service Account."
  type        = list(any)
  default     = []
}

variable "members" {
  description = "The list of IAM member and roles to bind to the Service Account."

  type = list(object({
    role    = string
    members = list(string)
  }))

  default = []
}
