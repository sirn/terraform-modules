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
# Feature Flags
# ----------------------------------------

variable "enable_ssl" {
  description = "Enable SSL/TLS settings (ssl, always_use_https, automatic_https_rewrites). Requires Zone:Edit permission."
  type        = bool
  default     = false
}

variable "enable_protection" {
  description = "Enable content protection settings (security_level, email_obfuscation, hotlink_protection). Requires Zone:Edit permission."
  type        = bool
  default     = false
}

variable "enable_performance" {
  description = "Enable performance settings (minify). Requires Zone:Edit permission."
  type        = bool
  default     = false
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
