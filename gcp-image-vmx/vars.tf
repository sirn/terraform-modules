variable "name" {
  description = "The name for this resource."
  type        = string
}

variable "source_image" {
  description = "The self link of the original image."
  type        = string
  default     = ""
}

variable "source_disk" {
  description = "The self link to the image resource."
  type        = string
  default     = ""
}

variable "image_licenses" {
  description = "The list of licenses of the original image."
  type        = list(any)
  default     = []
}
