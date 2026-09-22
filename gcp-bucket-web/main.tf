data "google_project" "this" {
}

resource "google_storage_bucket" "this" {
  name          = var.name
  project       = data.google_project.this.project_id
  location      = var.gcp_location != "" ? var.gcp_location : var.gcp_region
  force_destroy = var.force_destroy

  uniform_bucket_level_access = var.uniform_bucket_level_access

  website {
    main_page_suffix = var.main_page_suffix
    not_found_page   = var.not_found_page != "" ? var.not_found_page : null
  }
}

resource "google_storage_bucket_iam_binding" "this" {
  for_each = { for m in var.iam : m.role => m }

  bucket  = google_storage_bucket.this.name
  role    = each.value.role
  members = each.value.members
}
