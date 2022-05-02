data "google_project" "this" {
}

resource "google_compute_network" "this" {
  name    = var.network_name
  project = data.google_project.this.project_id

  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "this" {
  name = (
    var.subnetwork_name != "" ?
    var.subnetwork_name :
    "${var.network_name}-subnet"
  )

  project = data.google_project.this.project_id
  region  = var.gcp_region
  network = google_compute_network.this.self_link

  ip_cidr_range            = var.network_cidr
  private_ip_google_access = true
}
