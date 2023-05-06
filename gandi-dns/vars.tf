variable "domain_name" {
  description = "The domain name for this resource."
  type        = string
}

variable "record_sets" {
  description = "The list of record sets in this zone."
  type        = list(any)
  default     = []
}
