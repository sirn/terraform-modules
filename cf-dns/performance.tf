# Performance settings

resource "cloudflare_zone_setting" "minify" {
  zone_id    = cloudflare_zone.this.id
  setting_id = "minify"
  value = {
    css  = local.bool_to_onoff[var.minify_css]
    js   = local.bool_to_onoff[var.minify_js]
    html = local.bool_to_onoff[var.minify_html]
  }
}
