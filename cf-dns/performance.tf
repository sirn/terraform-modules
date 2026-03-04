# Performance settings

resource "cloudflare_zone_setting" "minify" {
  count      = var.minify_css || var.minify_js || var.minify_html ? 1 : 0
  zone_id    = cloudflare_zone.this.id
  setting_id = "minify"
  value      = jsonencode({
    css  = local.bool_to_onoff[var.minify_css]
    html = local.bool_to_onoff[var.minify_html]
    js   = local.bool_to_onoff[var.minify_js]
  })
}
