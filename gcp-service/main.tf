data "google_project" "this" {
}

resource "google_project_service_identity" "this" {
  provider = google-beta

  # Google Compute Engine service account does not require service identity;
  # an attempt to create them will result in an error.
  count = var.service == "compute.googleapis.com" ? 0 : 1

  project = data.google_project.this.project_id
  service = var.service
}

data "google_compute_default_service_account" "this" {
}

locals {
  # Google Compute Engine service account is special, it must be retrieved
  # via data.google_compute_default_service_account rather than
  # service_identity
  # data source
  service_account_email = (
    var.service == "compute.googleapis.com" ?
    data.google_compute_default_service_account.this.email :
    google_project_service_identity.this[0].email
  )
}

resource "google_project_iam_member" "this" {
  provider = google-beta
  for_each = { for role in var.roles : role => role }

  project = data.google_project.this.project_id
  role    = each.value
  member  = "serviceAccount:${local.service_account_email}"
}
