resource "cloudflare_page_rule" "this" {
  for_each = { for rule in var.page_rules : rule.target => rule }

  zone_id  = var.zone_id
  target   = each.value.target
  priority = each.value.priority
  status   = lookup(each.value, "status", "active")

  actions = {
    forwarding_url = lookup(each.value.actions, "forwarding_url", null) != null ? {
      url         = each.value.actions.forwarding_url.url
      status_code = each.value.actions.forwarding_url.status_code
    } : null

    cache_level = lookup(each.value.actions, "cache_level", null)
    ssl = lookup(each.value.actions, "ssl", null)
    always_use_https = lookup(each.value.actions, "always_use_https", null)
    browser_cache_ttl = lookup(each.value.actions, "browser_cache_ttl", null)
    edge_cache_ttl = lookup(each.value.actions, "edge_cache_ttl", null)
  }
}