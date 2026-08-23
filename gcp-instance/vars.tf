variable "name" {
  description = "The name for this resource."
  type        = string
  default     = "instance"
}

variable "gcp_zone" {
  description = "The Google Cloud zone for this resource."
  type        = string
}

variable "allow_stopping_for_update" {
  description = "Enables stopping for update."
  type        = bool
  default     = false
}

variable "machine_type" {
  description = "The machine type for the VM."
  type        = string
  default     = "e2-micro"
}

variable "machine_image" {
  description = "The disk image for the VM."
  type        = string
}

variable "machine_cpu_platform" {
  description = "The minimal CPU platform for the VM."
  type        = string
  default     = ""
}

variable "machine_disk_size" {
  description = "The amount of space in GiB for the VM."
  type        = number
  default     = 10
}

variable "machine_disk_type" {
  description = "The type of persistent disk for the VM."
  type        = string
  default     = "pd-balanced"
}

variable "service_account_email" {
  description = "The Service Account to use with this VM."
  type        = string
  default     = ""
}

variable "service_account_scopes" {
  description = "The Service Account scope to use with this VM."
  type        = list(string)
  default = [
    "https://www.googleapis.com/auth/cloud-platform",
  ]
}

variable "network" {
  description = "The name or self link of the network to use with this VM."
  type        = string
  default     = "default"
}

variable "subnetwork" {
  description = "The name or self link of the subnetwork to use with this VM."
  type        = string
  default     = ""
}

variable "network_allow_icmp" {
  description = "Enables ICMP for this VM."
  type        = bool
  default     = false
}

variable "network_allow_tcp" {
  description = "The list of TCP ports or ranges to open for this VM."
  type        = list(string)
  default     = []
}

variable "network_allow_udp" {
  description = "The list of UDP ports or ranges to open for this VM."
  type        = list(string)
  default     = []
}

variable "network_tags" {
  description = "The list of network tags to add to this VM."
  type        = list(string)
  default     = []
}

variable "nat_ip" {
  description = "The IP address for this instance."
  type        = string
  default     = ""
}

variable "network_tier" {
  description = "The networking tier for the external IP. PREMIUM or STANDARD."
  type        = string
  default     = "PREMIUM"
}

variable "attached_disks" {
  description = "The list of attached disks for this instance."
  type = list(object({
    name = string
    size = number
    type = string
  }))

  default = []
}

variable "serial_port" {
  description = "Enables serial port."
  type        = bool
  default     = false
}

variable "metadata" {
  description = "Additional instance metadata to merge into the VM."
  type        = map(string)
  default     = {}
}
