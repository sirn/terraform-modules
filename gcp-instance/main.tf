data "google_project" "this" {
}

data "google_compute_default_service_account" "this" {
}

locals {
  has_tcp  = length(var.network_allow_tcp) > 0
  has_udp  = length(var.network_allow_udp) > 0
  has_icmp = var.network_allow_icmp
  has_fw   = local.has_tcp || local.has_udp || local.has_icmp
}

resource "google_compute_disk" "this" {
  for_each = { for v in var.attached_disks : v.name => v }

  name = each.value.name
  type = each.value.type
  size = each.value.size
  zone = var.gcp_zone
}

resource "google_compute_firewall" "this" {
  count = local.has_fw ? 1 : 0

  name    = "${var.name}-default"
  project = data.google_project.this.project_id
  network = var.network

  dynamic "allow" {
    for_each = local.has_icmp ? [1] : []
    content {
      protocol = "icmp"
    }
  }

  dynamic "allow" {
    for_each = local.has_tcp ? [1] : []
    content {
      protocol = "tcp"
      ports    = var.network_allow_tcp
    }
  }

  dynamic "allow" {
    for_each = local.has_udp ? [1] : []
    content {
      protocol = "udp"
      ports    = var.network_allow_udp
    }
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

  tags = concat(
    var.network_tags,
    (
      local.has_fw ?
      ["${var.name}-default"] :
      []
    )
  )

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
      nat_ip       = var.nat_ip != "" ? var.nat_ip : null
      network_tier = var.network_tier
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

  metadata = merge(
    {
      serial-port-enable = var.serial_port ? "true" : "false"
    },
    var.metadata
  )

  lifecycle {
    ignore_changes = [
      boot_disk[0].initialize_params,
    ]
  }
}
