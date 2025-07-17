output "page_rule_ids" {
  description = "Map of page rule targets to their IDs"
  value = {
    for target, rule in cloudflare_page_rule.this : target => rule.id
  }
}