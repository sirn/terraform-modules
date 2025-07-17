resource "cloudflare_page_rule" "this" {
  for_each = { for rule in var.page_rules : rule.target => rule }

  zone_id  = var.zone_id
  target   = each.value.target
  priority = each.value.priority
  status   = lookup(each.value, "status", "active")

  actions {
    dynamic "forwarding_url" {
      for_each = lookup(each.value.actions, "forwarding_url", null) != null ? [each.value.actions.forwarding_url] : []
      content {
        url         = forwarding_url.value.url
        status_code = forwarding_url.value.status_code
      }
    }

    dynamic "cache_level" {
      for_each = lookup(each.value.actions, "cache_level", null) != null ? [each.value.actions.cache_level] : []
      content {
        value = cache_level.value
      }
    }

    dynamic "ssl" {
      for_each = lookup(each.value.actions, "ssl", null) != null ? [each.value.actions.ssl] : []
      content {
        value = ssl.value
      }
    }

    dynamic "always_use_https" {
      for_each = lookup(each.value.actions, "always_use_https", false) ? [true] : []
      content {
        value = always_use_https.value
      }
    }

    dynamic "browser_cache_ttl" {
      for_each = lookup(each.value.actions, "browser_cache_ttl", null) != null ? [each.value.actions.browser_cache_ttl] : []
      content {
        value = browser_cache_ttl.value
      }
    }

    dynamic "edge_cache_ttl" {
      for_each = lookup(each.value.actions, "edge_cache_ttl", null) != null ? [each.value.actions.edge_cache_ttl] : []
      content {
        value = edge_cache_ttl.value
      }
    }
  }
}