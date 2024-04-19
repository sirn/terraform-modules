resource "google_kms_key_ring" "this" {
  name     = var.keyring_name
  location = var.gcp_location != "" ? var.gcp_location : var.gcp_zone
}

resource "google_kms_crypto_key" "this" {
  for_each = { for k in var.crypto_keys : k.name => k }

  name            = each.value.name
  key_ring        = google_kms_key_ring.this.id
  rotation_period = each.value.rotation_period
  purpose         = each.value.purpose
}
