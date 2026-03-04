# Bot Management settings
# Uses separate Bot Management API (not Zone Settings)

resource "cloudflare_bot_management" "this" {
  zone_id = cloudflare_zone.this.id

  # Bot Fight Mode (available on all plans)
  fight_mode = var.bot_fight_mode

  # AI Bots Protection (available on all plans)
  # "block" = enabled, "allow" = disabled
  ai_bots_protection = var.block_ai_bots ? "block" : "allow"
}
