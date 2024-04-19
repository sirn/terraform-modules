variable "keyring_name" {
  description = "The name for this key ring."
  type        = string
}

variable "crypto_keys" {
  description = "The list of crypto keys."

  type = list(object({
    name            = string,
    rotation_period = string,
    purpose         = string,
  }))

  default = []
}

variable "gcp_location" {
  description = "The Google Cloud location for this resource."
  type        = string
  default     = ""
}

variable "gcp_zone" {
  description = "The Google Cloud zone for this resource."
  type        = string
  default     = ""
}
