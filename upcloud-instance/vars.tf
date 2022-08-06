variable "name" {
  description = "The name for this resource."
  type        = string
  default     = "instance"
}

variable "upcloud_zone" {
  description = "The Upcloud region for this resource."
  type        = string
}

variable "machine_type" {
  description = "The machine type for the VM."
  type        = string
  default     = "1xCPU-1GB"
}

variable "machine_image" {
  description = "The disk image for the VM."
  type        = string
  default     = ""
}

variable "machine_disk_size" {
  description = "The amount of space in GiB for the VM."
  type        = number
  default     = 25
}

variable "networks" {
  description = "The list of additional networks for the VM."
  type        = list(any)
  default     = []
}
