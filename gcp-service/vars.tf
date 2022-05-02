variable "service" {
  description = "The name of the Default Service Account to import."
  type        = string
}

variable "roles" {
  description = "The list of roles to assign to the Default Service Account."
  type        = list(any)
  default     = []
}
