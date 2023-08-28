variable "name" {
  description = "The name for this resource."
  type        = string
}

variable "cluster_id" {
  description = "The ID of the cluster to assign this node pool to."
  type        = string
}

variable "node_count" {
  description = "The number of initial nodes in this node pool."
  type        = number
  default     = 3
}

variable "node_version" {
  description = "The version of the Kubelet in this node pool."
  type        = string
  default     = ""
}

variable "autoscaling_enabled" {
  description = "Enables autoscaling."
  type        = bool
  default     = false
}

variable "autoscaling_min_nodes" {
  description = "The minimum number of nodes to automatically scale down to."
  type        = number
  default     = 3
}

variable "autoscaling_max_nodes" {
  description = "The maximum number of nodes to automatically scale up to."
  type        = number
  default     = 5
}

variable "workload_identity_enabled" {
  description = "Enables Workload Identity for this node pool."
  type        = bool
  default     = true
}

variable "workload_identity_metadata" {
  description = "The mode of Workload Identity metadata."
  type        = string
  default     = "GKE_METADATA"
}

variable "machine_type" {
  description = "The machine type for the node pool."
  type        = string
  default     = "e2-micro"
}

variable "machine_preemptible" {
  description = "Enables preemptible."
  type        = bool
  default     = false
}

variable "service_account_email" {
  description = "The Service Account to use with this node pool."
  type        = string
  default     = ""
}

variable "service_account_scopes" {
  description = "The Service Account scope to use with this node pool."
  type        = list(any)
  default = [
    "https://www.googleapis.com/auth/cloud-platform",
  ]
}
