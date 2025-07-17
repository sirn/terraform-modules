output "zone_id" {
  description = "The Cloudflare zone ID"
  value       = cloudflare_zone.this.id
}

output "zone_name" {
  description = "The Cloudflare zone name"
  value       = cloudflare_zone.this.name
}

output "name_servers" {
  description = "The Cloudflare name servers for this zone"
  value       = cloudflare_zone.this.name_servers
}