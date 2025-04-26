variable "name" {
  description = "The name for this resource."
  type        = string
  default     = "instance"
}

variable "linode_region" {
  description = "The Linode region for this resource."
  type        = string
}

variable "machine_type" {
  description = "The machine type for the VM."
  type        = string
  default     = "g6-nanode-1"
}

variable "machine_image" {
  description = "The disk image for the VM."
  type        = string
  default     = ""
}

variable "machine_tags" {
  description = "The list of tags for the VM."
  type        = list(string)
  default     = []
}

variable "keys_dir" {
  description = "The directory containing SSH public keys."
  type        = string
  default     = ""
}

variable "keys" {
  description = "The list of authoized keys for the VM."
  type        = list(string)
  default     = []
}

variable "private_networking" {
  description = "Enables private networking. Cannot be disabled once enabled."
  type        = bool
  default     = false
}

variable "disks" {
  description = "The list of disks for this instance."
  type = list(object({
    name       = string
    filesystem = string
    image      = string
    size       = number
  }))
  default = []
}

variable "configs" {
  description = "The list of configurations for this instance."
  type = list(object({
    name        = string
    kernel      = string
    virt_mode   = string
    root_device = string
    disks       = map(map(string))
    helpers     = map(string)
  }))

  default = []
}

variable "volumes" {
  description = "The list of additional volumes for this instance."
  type = list(object({
    name = string
    size = number
  }))

  default = []
}

variable "booted" {
  description = "Boot the machine after creation."
  type        = bool
  default     = true
}

variable "boot_config" {
  description = "The name of configuration to use for boot."
  type        = string
  default     = ""
}
