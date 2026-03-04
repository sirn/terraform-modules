# Bot Management settings
# Uses separate Bot Management API (not Zone Settings)

resource "cloudflare_bot_management" "this" {
  zone_id = cloudflare_zone.this.id

  # Bot Fight Mode (available on all plans)
  fight_mode = var.bot_fight_mode

  # AI Bots Protection (available on all plans)
  # "block" = block AI bots, "disabled" = allow AI bots, "only_on_ad_pages" = only on ad pages
  ai_bots_protection = var.ai_bots_protection
}
