output "service_account_email" {
  description = "The email address of the service account"
  value       = google_service_account.this.email
}

output "service_account_id" {
  description = "The ID of the service account"
  value       = google_service_account.this.account_id
}

output "service_account_name" {
  description = "The fully-qualified name of the service account"
  value       = google_service_account.this.name
}

output "service_account_unique_id" {
  description = "The unique ID of the service account"
  value       = google_service_account.this.unique_id
}
