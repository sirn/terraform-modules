data "google_project" "this" {
}

data "google_container_engine_versions" "this" {
  location       = var.gcp_zone
  version_prefix = var.version_prefix
}

resource "google_container_cluster" "this" {
  name               = var.name
  project            = data.google_project.this.project_id
  location           = var.gcp_location != "" ? var.gcp_location : var.gcp_zone
  network            = var.network
  node_version       = data.google_container_engine_versions.this.latest_node_version
  min_master_version = data.google_container_engine_versions.this.latest_node_version

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  dynamic "workload_identity_config" {
    for_each = (var.workload_identity_enabled ? [1] : [])

    content {
      workload_pool = "${data.google_project.this.project_id}.svc.id.goog"
    }
  }

  release_channel {
    channel = var.release_channel
  }
}
