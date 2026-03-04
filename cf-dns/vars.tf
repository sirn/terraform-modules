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
# Security Settings (Zone Settings API)
# ----------------------------------------

variable "security_level" {
  description = "Security level (off, essentially_off, low, medium, high, under_attack)"
  type        = string
  default     = "medium"
}

# Note: Browser Integrity Check is configured via Configuration Rules, not Zone Settings
# It must be set up separately if needed.

# ----------------------------------------
# Bot Management (Separate API)
# ----------------------------------------

variable "bot_fight_mode" {
  description = "Enable Bot Fight Mode (via Bot Management API)"
  type        = bool
  default     = true
}

variable "ai_bots_protection" {
  description = "AI bots protection mode (block, disabled, only_on_ad_pages)"
  type        = string
  default     = "block"

  validation {
    condition     = contains(["block", "disabled", "only_on_ad_pages"], var.ai_bots_protection)
    error_message = "ai_bots_protection must be one of: block, disabled, only_on_ad_pages"
  }
}

# ----------------------------------------
# Content Protection (Zone Settings API)
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
# SSL/TLS Settings (Zone Settings API)
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
# Performance Settings (Zone Settings API)
# ----------------------------------------

variable "minify_css" {
  description = "Minify CSS via Auto Minify"
  type        = bool
  default     = false
}

variable "minify_js" {
  description = "Minify JavaScript via Auto Minify"
  type        = bool
  default     = false
}

variable "minify_html" {
  description = "Minify HTML via Auto Minify"
  type        = bool
  default     = false
}
