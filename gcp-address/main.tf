data "google_project" "this" {
}

resource "google_compute_address" "this" {
  name         = var.name
  project      = data.google_project.this.project_id
  region       = var.gcp_region
  network_tier = var.network_tier
}
