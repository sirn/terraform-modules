variable "zone_id" {
  description = "The Cloudflare zone ID"
  type        = string
}

variable "page_rules" {
  description = "List of page rules to create"
  type = list(object({
    target   = string
    priority = number
    status   = optional(string, "active")
    actions  = any
  }))
  default = []
}