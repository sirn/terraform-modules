output "instance_self_link" {
  value = google_compute_instance.this.self_link
}

output "instance_id" {
  value = google_compute_instance.this.id
}

output "instance_ipv4" {
  value = google_compute_instance.this.network_interface[0].access_config[0].nat_ip
}
