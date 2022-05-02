data "google_project" "this" {
}

data "google_compute_default_service_account" "this" {
}

resource "google_compute_disk" "this" {
  for_each = { for v in var.attached_disks : v.name => v }

  name = each.value.name
  type = each.value.type
  size = each.value.size
  zone = var.gcp_zone
}

resource "google_compute_firewall" "this" {
  name    = "${var.name}-default"
  project = data.google_project.this.project_id
  network = var.network

  allow {
    protocol = "tcp"
    ports    = var.network_allow_tcp
  }

  allow {
    protocol = "udp"
    ports    = var.network_allow_udp
  }

  source_ranges = [
    "0.0.0.0/0",
  ]

  target_tags = [
    "${var.name}-default",
  ]
}

resource "google_compute_instance" "this" {
  name         = var.name
  project      = data.google_project.this.project_id
  zone         = var.gcp_zone
  machine_type = var.machine_type

  tags = concat(var.network_tags, ["${var.name}-default"])

  allow_stopping_for_update = var.allow_stopping_for_update

  min_cpu_platform = var.machine_cpu_platform

  boot_disk {
    initialize_params {
      image = var.machine_image
      size  = var.machine_disk_size
      type  = var.machine_disk_type
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork != "" ? var.subnetwork : null

    access_config {
      nat_ip = var.nat_ip != "" ? var.nat_ip : null
    }
  }

  dynamic "attached_disk" {
    for_each = var.attached_disks

    content {
      source      = google_compute_disk.this[attached_disk.value.name].self_link
      device_name = google_compute_disk.this[attached_disk.value.name].name
    }
  }

  service_account {
    email = (
      var.service_account_email != "" ?
      var.service_account_email :
      data.google_compute_default_service_account.this.email
    )

    scopes = var.service_account_scopes
  }

  metadata = {
    serial-port-enable = var.serial_port ? "true" : "false"
  }

  lifecycle {
    ignore_changes = [
      boot_disk[0].initialize_params,
    ]
  }
}
