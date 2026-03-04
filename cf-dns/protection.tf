# Security and content protection settings (Zone Settings API)

resource "cloudflare_zone_setting" "security_level" {
  zone_id    = cloudflare_zone.this.id
  setting_id = "security_level"
  value      = var.security_level
}

resource "cloudflare_zone_setting" "email_obfuscation" {
  zone_id    = cloudflare_zone.this.id
  setting_id = "email_obfuscation"
  value      = local.bool_to_onoff[var.email_obfuscation]
}

resource "cloudflare_zone_setting" "hotlink_protection" {
  zone_id    = cloudflare_zone.this.id
  setting_id = "hotlink_protection"
  value      = local.bool_to_onoff[var.hotlink_protection]
}

# Note: Browser Integrity Check is NOT available via Zone Settings API.
# It can only be configured via:
# - Cloudflare Dashboard (Security > Settings)
# - Configuration Rules API (property name: "bic")
# To configure via Configuration Rules, create a rule with:
#   action = "skip" and action_parameters { ruleset = "bic" }
