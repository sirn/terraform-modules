output "bucket_self_link" {
  value = google_storage_bucket.this.self_link
}

output "bucket_id" {
  value = google_storage_bucket.this.id
}
