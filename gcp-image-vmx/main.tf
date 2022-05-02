data "google_project" "this" {
}

resource "google_compute_image" "this" {
  name         = var.name
  project      = data.google_project.this.project_id
  source_image = var.source_image != "" ? var.source_image : null

  dynamic "raw_disk" {
    for_each = (
      var.source_disk != "" ?
      [1] : []
    )

    content {
      source = var.source_disk
    }
  }

  licenses = concat(var.image_licenses, [
    "https://www.googleapis.com/compute/v1/projects/vm-options/global/licenses/enable-vmx"
  ])
}
