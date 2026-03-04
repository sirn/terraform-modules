# Security and content protection settings

resource "cloudflare_zone_setting" "security_level" {
  count = var.enable_protection ? 1 : 0

  zone_id    = cloudflare_zone.this.id
  setting_id = "security_level"
  value      = var.security_level
}

resource "cloudflare_zone_setting" "email_obfuscation" {
  count = var.enable_protection ? 1 : 0

  zone_id    = cloudflare_zone.this.id
  setting_id = "email_obfuscation"
  value      = local.bool_to_onoff[var.email_obfuscation]
}

resource "cloudflare_zone_setting" "hotlink_protection" {
  count = var.enable_protection ? 1 : 0

  zone_id    = cloudflare_zone.this.id
  setting_id = "hotlink_protection"
  value      = local.bool_to_onoff[var.hotlink_protection]
}
