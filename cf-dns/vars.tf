variable "account_id" {
  description = "The Cloudflare account ID"
  type        = string
}

variable "domain_name" {
  description = "The domain name for this resource."
  type        = string
}

variable "zone_type" {
  description = "The type of the Cloudflare zone"
  type        = string
  default     = "full"
}

variable "record_sets" {
  description = "The list of record sets in this zone."
  type        = list(any)
  default     = []
}
