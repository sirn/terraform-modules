variable "domain_name" {
  description = "The domain name for this resource."
  type        = string
}

variable "default_ttl" {
  description = "The default TTL for this resource."
  type        = string
  default     = "3600"
}

variable "record_sets" {
  description = "The list of record sets in this zone."
  type        = list(any)
  default     = []
}
