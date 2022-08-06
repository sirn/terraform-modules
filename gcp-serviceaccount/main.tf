data "google_project" "this" {
}

data "google_compute_default_service_account" "this" {
}

resource "google_service_account" "this" {
  account_id   = var.service_account_id
  display_name = var.service_account_name
}

resource "google_project_iam_member" "this" {
  for_each = { for role in var.roles : role => role }

  project = data.google_project.this.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.this.email}"
}

locals {
  members = flatten([
    for r in var.members : [
      for m in r.members :
      {
        member = m,
        role   = r.role,
      }
    ]
  ])
}

resource "google_service_account_iam_member" "this" {
  for_each = { for m in local.members : "${m.role}/${m.member}" => m }

  service_account_id = google_service_account.this.name
  role               = each.value.role
  member             = each.value.member
}
