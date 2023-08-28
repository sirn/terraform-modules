output "cluster_self_link" {
  value = google_container_cluster.this.self_link
}

output "cluster_id" {
  value = google_container_cluster.this.id
}

output "node_version" {
  value = google_container_cluster.this.node_version
}
