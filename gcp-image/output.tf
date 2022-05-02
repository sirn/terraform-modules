output "image_self_link" {
  value = data.google_compute_image.this.self_link
}

output "image_id" {
  value = data.google_compute_image.this.id
}

output "image_licenses" {
  value = data.google_compute_image.this.licenses
}
