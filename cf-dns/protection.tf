# Security and content protection settings

# Note: browser_integrity_check, bot_fight_mode, and block_ai_bots are not
# available via the zone settings API. These must be configured manually
# in the Cloudflare dashboard or via other API endpoints.

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
