data "google_compute_default_service_account" "default" {
}

resource "google_container_node_pool" "this" {
  name    = var.name
  cluster = var.cluster_id
  version = var.node_version == "" ? null : var.node_version

  # node_count is the current count, initial_node_count is the count when
  # node pool is initially created. If initial_node_count < min node count,
  # it will essentially disable autoscaling after node creation.
  node_count         = var.autoscaling_enabled ? null : var.node_count
  initial_node_count = var.autoscaling_enabled ? var.autoscaling_min_nodes : var.node_count

  dynamic "autoscaling" {
    for_each = (var.autoscaling_enabled ? [1] : [])

    content {
      min_node_count = var.autoscaling_min_nodes
      max_node_count = var.autoscaling_max_nodes
    }
  }

  node_config {
    machine_type = var.machine_type
    preemptible  = var.machine_preemptible

    service_account = (
      var.service_account_email != "" ?
      var.service_account_email :
      data.google_compute_default_service_account.default.email
    )

    oauth_scopes = var.service_account_scopes

    dynamic "workload_metadata_config" {
      for_each = (var.workload_identity_enabled ? [1] : [])

      content {
        mode = var.workload_identity_metadata
      }
    }
  }
}
