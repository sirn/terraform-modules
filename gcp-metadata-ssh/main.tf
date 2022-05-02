data "google_project" "this" {
}

locals {
  ssh_keys = join(
    "\n",
    flatten(
      [
        for k in fileset(var.keys_dir, "*.pub") :
        [
          for l in split("\n", chomp(file("${var.keys_dir}/${k}"))) :
          "${trim("${k}", ".pub")}:${l}"
        ]
      ]
    )
  )
}

resource "google_compute_project_metadata_item" "this" {
  key     = "ssh-keys"
  project = data.google_project.this.project_id
  value   = local.ssh_keys
}
