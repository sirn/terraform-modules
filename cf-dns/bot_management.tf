# Bot Management settings
# Uses separate Bot Management API (not Zone Settings)
# Requires Bot Management:Edit permission
# Note: Bot Fight Mode is available on all plans, but the API may require
# Super Bot Fight Mode or Bot Management subscription

resource "cloudflare_bot_management" "this" {
  count = var.enable_bot_management ? 1 : 0

  zone_id = cloudflare_zone.this.id

  # Bot Fight Mode (available on all plans)
  fight_mode = var.bot_fight_mode

  # AI Bots Protection (available on all plans)
  # "block" = enabled, "disabled" = disabled, "only_on_ad_pages" = only on ad pages
  ai_bots_protection = var.ai_bots_protection
}
