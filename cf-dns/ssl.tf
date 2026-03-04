# SSL/TLS settings

resource "cloudflare_zone_setting" "ssl" {
  zone_id = cloudflare_zone.this.id
  setting = "ssl"
  value   = var.ssl_mode
}

resource "cloudflare_zone_setting" "always_use_https" {
  zone_id = cloudflare_zone.this.id
  setting = "always_use_https"
  value   = local.bool_to_onoff[var.always_use_https]
}

resource "cloudflare_zone_setting" "automatic_https_rewrites" {
  zone_id = cloudflare_zone.this.id
  setting = "automatic_https_rewrites"
  value   = local.bool_to_onoff[var.automatic_https_rewrites]
}
