output "key_ring_id" {
  value = google_kms_key_ring.this.id
}

output "crypto_key_id" {
  value = { for n in google_kms_crypto_key.this : n.name => n.id }
}
