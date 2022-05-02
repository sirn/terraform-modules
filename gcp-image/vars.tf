variable "image_family" {
  description = "The image name."
  type        = string
  default     = "debian-10"
}

variable "image_project" {
  description = "The Google Cloud Project hosting the image."
  type        = string
  default     = "debian-cloud"
}
