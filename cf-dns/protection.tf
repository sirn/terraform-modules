# Security and content protection settings

locals {
  # Convert booleans to "on"/"off" strings for Cloudflare API
  bool_to_onoff = {
    true  = "on"
    false = "off"
  }
}

# Security settings
resource "cloudflare_zone_setting" "browser_integrity_check" {
  zone_id    = cloudflare_zone.this.id
  setting_id = "browser_integrity_check"
  value      = local.bool_to_onoff[var.browser_integrity_check]
}

resource "cloudflare_zone_setting" "bot_fight_mode" {
  zone_id    = cloudflare_zone.this.id
  setting_id = "bot_fight_mode"
  value      = local.bool_to_onoff[var.bot_fight_mode]
}

resource "cloudflare_zone_setting" "block_ai_bots" {
  count      = var.block_ai_bots != null ? 1 : 0
  zone_id    = cloudflare_zone.this.id
  setting_id = "block_ai_bots"
  value      = local.bool_to_onoff[var.block_ai_bots]
}

resource "cloudflare_zone_setting" "security_level" {
  zone_id    = cloudflare_zone.this.id
  setting_id = "security_level"
  value      = var.security_level
}

# Content protection
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
