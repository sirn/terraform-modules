output "image_self_link" {
  value = google_compute_image.this.self_link
}

output "image_id" {
  value = google_compute_image.this.id
}

output "image_licenses" {
  value = google_compute_image.this.licenses
}
