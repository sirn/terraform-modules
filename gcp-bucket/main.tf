data "google_project" "this" {
}

resource "google_storage_bucket" "this" {
  name          = var.name
  project       = data.google_project.this.project_id
  location      = var.gcp_location != "" ? var.gcp_location : var.gcp_region
  force_destroy = var.force_destroy

  uniform_bucket_level_access = var.uniform_bucket_level_access

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules

    content {
      action {
        type          = lookup(lifecycle_rule.value.action, "type", null)
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }

      condition {
        age                        = lookup(lifecycle_rule.value.condition, "age", null)
        created_before             = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state                 = lookup(lifecycle_rule.value.condition, "with_state", null)
        num_newer_versions         = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
        custom_time_before         = lookup(lifecycle_rule.value.condition, "custom_time_before", null)
        days_since_custom_time     = lookup(lifecycle_rule.value.condition, "days_since_custom_time", null)
        days_since_noncurrent_time = lookup(lifecycle_rule.value.condition, "days_since_noncurrent_time", null)
        noncurrent_time_before     = lookup(lifecycle_rule.value.condition, "noncurrent_time_before", null)

        matches_storage_class = (
          contains(keys(lifecycle_rule.value.condition), "matches_storage_class") ?
          split(",", lifecycle_rule.value.condition["matches_storage_class"]) :
          null
        )
      }
    }
  }

  versioning {
    enabled = var.versioning_enabled
  }

  dynamic "website" {
    for_each = var.website_enabled ? [1] : []
    content {
      main_page_suffix = var.website_main_page_suffix
      not_found_page   = var.website_not_found_page != "" ? var.website_not_found_page : null
    }
  }
}

resource "google_storage_bucket_iam_binding" "this" {
  for_each = { for m in var.iam : "${m.role}" => m }

  bucket  = google_storage_bucket.this.name
  role    = each.value.role
  members = each.value.members
}
