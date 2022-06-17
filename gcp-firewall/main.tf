data "google_project" "this" {
}

resource "google_compute_firewall" "this" {
  name    = var.name
  project = data.google_project.this.project_id
  network = var.network

  dynamic "allow" {
    for_each = var.allow_icmp ? [1] : []
    content {
      protocol = "icmp"
    }
  }

  dynamic "allow" {
    for_each = length(var.allow_tcp) > 0 ? [1] : []
    content {
      protocol = "tcp"
      ports    = var.allow_tcp
    }
  }

  dynamic "allow" {
    for_each = length(var.allow_udp) > 0 ? [1] : []
    content {
      protocol = "udp"
      ports    = var.allow_udp
    }
  }

  source_tags   = var.source_tags
  source_ranges = var.source_ranges
  target_tags   = var.target_tags
}
