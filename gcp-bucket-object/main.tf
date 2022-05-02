data "google_storage_bucket_object" "this" {
  name   = var.name
  bucket = var.bucket
}
