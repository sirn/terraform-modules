data "google_project" "this" {
}

data "google_container_engine_versions" "this" {
  location       = var.gcp_zone
  version_prefix = var.version_prefix
}

resource "google_container_cluster" "this" {
  name         = var.name
  project      = data.google_project.this.project_id
  location     = var.gcp_location != "" ? var.gcp_location : var.gcp_zone
  network      = var.network
  node_version = data.google_container_engine_versions.this.latest_node_version

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
