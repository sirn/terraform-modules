output "object_self_link" {
  value = data.google_storage_bucket_object.this.self_link
}

output "object_id" {
  value = data.google_storage_bucket_object.this.id
}
