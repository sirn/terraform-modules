variable "name" {
  description = "The name for this resouce."
  type        = string
}

variable "network" {
  description = "The name or self link of the network to use with this firewall."
  type        = string
  default     = "default"
}

variable "allow_icmp" {
  description = "Enables ICMP for this firewall."
  type        = bool
  default     = false
}

variable "allow_tcp" {
  description = "The list of TCP ports or ranges to open for this firewall."
  type        = list(string)
  default     = []
}

variable "allow_udp" {
  description = "The list of UDP ports or ranges to open for this firewall."
  type        = list(string)
  default     = []
}

variable "source_tags" {
  description = "The list of source tags to apply this firewall to."
  type        = list(string)
  default     = []
}

variable "source_ranges" {
  description = "The list of source CIDR ranges to apply this firewall to."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "target_tags" {
  description = "The list of target tags to apply this firewall to."
  type        = list(string)
  default     = []
}
