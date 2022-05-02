variable "name" {
  description = "The name for this resource."
  type        = string
}

variable "domain_name" {
  description = "The domain name for this resource."
  type        = string
}

variable "record_sets" {
  description = "The list of record sets in this zone."
  type        = list(any)
  default     = []
}

variable "dnssec" {
  description = "Enables DNSSEC for this resource."
  type        = bool
  default     = true
}

variable "dnssec_kind" {
  description = "The kind of DNSSEC configuration."
  type        = string
  default     = "dns#managedZoneDnsSecConfig"
}

variable "dnssec_non_existence" {
  description = "The mechanism for denial-of-existence response."
  type        = string
  default     = "nsec3"
}

variable "dnssec_state" {
  description = "The state of DNSSEC (off, on, transfer)."
  type        = string
  default     = "on"
}

variable "dnssec_key_specs" {
  description = "The list of DNSSEC key specs."

  type = list(object({
    algorithm  = string,
    key_length = number,
    key_type   = string,
    kind       = string,
  }))

  default = [
    {
      algorithm  = "ecdsap256sha256",
      key_length = 256,
      key_type   = "keySigning",
      kind       = "dns#dnsKeySpec",
    },
    {
      algorithm  = "ecdsap256sha256",
      key_length = 256,
      key_type   = "zoneSigning",
      kind       = "dns#dnsKeySpec",
    },
  ]
}
