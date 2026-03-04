# Security and content protection settings

# Security settings
resource "cloudflare_zone_setting" "browser_integrity_check" {
  zone_id = cloudflare_zone.this.id
  setting = "browser_integrity_check"
  value   = local.bool_to_onoff[var.browser_integrity_check]
}

resource "cloudflare_zone_setting" "bot_fight_mode" {
  zone_id = cloudflare_zone.this.id
  setting = "bot_fight_mode"
  value   = local.bool_to_onoff[var.bot_fight_mode]
}

resource "cloudflare_zone_setting" "block_ai_bots" {
  count   = var.block_ai_bots != null ? 1 : 0
  zone_id = cloudflare_zone.this.id
  setting = "block_ai_bots"
  value   = local.bool_to_onoff[var.block_ai_bots]
}

resource "cloudflare_zone_setting" "security_level" {
  zone_id = cloudflare_zone.this.id
  setting = "security_level"
  value   = var.security_level
}

# Content protection
resource "cloudflare_zone_setting" "email_obfuscation" {
  zone_id = cloudflare_zone.this.id
  setting = "email_obfuscation"
  value   = local.bool_to_onoff[var.email_obfuscation]
}

resource "cloudflare_zone_setting" "hotlink_protection" {
  zone_id = cloudflare_zone.this.id
  setting = "hotlink_protection"
  value   = local.bool_to_onoff[var.hotlink_protection]
}

# Page Shield (continuous script monitoring + replace insecure JS)
resource "cloudflare_page_shield" "this" {
  count    = var.page_shield_enabled ? 1 : 0
  zone_id  = cloudflare_zone.this.id
  enabled  = var.page_shield_enabled
  notifies = true
}

# API Shield (schema validation)
resource "cloudflare_api_shield" "this" {
  count   = var.api_shield_enabled ? 1 : 0
  zone_id = cloudflare_zone.this.id
}

resource "cloudflare_api_shield_schema_validation_settings" "this" {
  count                         = var.api_shield_enabled ? 1 : 0
  zone_id                       = cloudflare_zone.this.id
  validation_default_mitigation = "block"
}
