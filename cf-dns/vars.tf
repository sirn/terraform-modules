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

# ----------------------------------------
# Security Settings
# ----------------------------------------

variable "security_level" {
  description = "Security level (off, essentially_off, low, medium, high, under_attack)"
  type        = string
  default     = "medium"
}

variable "browser_integrity_check" {
  description = "Enable browser integrity check"
  type        = bool
  default     = true
}

variable "bot_fight_mode" {
  description = "Enable Bot Fight Mode"
  type        = bool
  default     = true
}

variable "block_ai_bots" {
  description = "Block AI training bots (false = allow AI crawlers)"
  type        = bool
  default     = true
}

# ----------------------------------------
# Content Protection
# ----------------------------------------

variable "email_obfuscation" {
  description = "Enable email obfuscation"
  type        = bool
  default     = true
}

variable "hotlink_protection" {
  description = "Enable hotlink protection"
  type        = bool
  default     = false
}

# ----------------------------------------
# SSL/TLS Settings
# ----------------------------------------

variable "ssl_mode" {
  description = "SSL mode (off, flexible, full, strict)"
  type        = string
  default     = "strict"
}

variable "always_use_https" {
  description = "Redirect HTTP to HTTPS"
  type        = bool
  default     = true
}

variable "automatic_https_rewrites" {
  description = "Enable automatic HTTPS rewrites"
  type        = bool
  default     = true
}

# ----------------------------------------
# Performance Settings
# ----------------------------------------

variable "minify_css" {
  description = "Minify CSS"
  type        = bool
  default     = false
}

variable "minify_js" {
  description = "Minify JavaScript"
  type        = bool
  default     = false
}

variable "minify_html" {
  description = "Minify HTML"
  type        = bool
  default     = false
}
