output "bucket_self_link" {
  value = google_storage_bucket.this.self_link
}

output "bucket_id" {
  value = google_storage_bucket.this.id
}

output "bucket_name" {
  value = google_storage_bucket.this.name
}

output "bucket_url" {
  value = google_storage_bucket.this.url
}

output "website_url" {
  value = var.website_enabled ? "https://storage.googleapis.com/${google_storage_bucket.this.name}" : null
}
