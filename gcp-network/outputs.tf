output "network_self_link" {
  value = google_compute_network.this.self_link
}

output "network_id" {
  value = google_compute_network.this.id
}

output "subnetwork_self_link" {
  value = google_compute_subnetwork.this.self_link
}

output "subnetwork_id" {
  value = google_compute_subnetwork.this.id
}
