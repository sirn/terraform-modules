output "address_self_link" {
  value = google_compute_address.this.self_link
}

output "address_id" {
  value = google_compute_address.this.id
}

output "address_ipv4" {
  value = google_compute_address.this.address
}
