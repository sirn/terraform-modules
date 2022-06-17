output "network_self_link" {
  value = google_compute_network.this.self_link
}

output "network_id" {
  value = google_compute_network.this.id
}

output "subnetwork_self_link" {
  value = (
    length(google_compute_subnetwork.this) > 0 ?
    google_compute_subnetwork.this[0].self_link :
    null
  )
}

output "subnetwork_id" {
  value = (
    length(google_compute_subnetwork.this) > 0 ?
    google_compute_subnetwork.this[0].id :
    null
  )
}
