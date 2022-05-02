locals {
  domain_name = (
    can(regex("\\.$", var.domain_name)) ?
    var.domain_name :
    "${var.domain_name}."
  )
}
resource "google_dns_managed_zone" "this" {
  name     = var.name
  dns_name = local.domain_name

  dynamic "dnssec_config" {
    for_each = (
      var.dnssec ?
      [1] : []
    )

    content {
      kind          = var.dnssec_kind
      non_existence = var.dnssec_non_existence
      state         = var.dnssec_state

      dynamic "default_key_specs" {
        for_each = var.dnssec_key_specs

        content {
          algorithm  = default_key_specs.value.algorithm
          key_length = default_key_specs.value.key_length
          key_type   = default_key_specs.value.key_type
          kind       = default_key_specs.value.kind
        }
      }
    }
  }
}

resource "google_dns_record_set" "this" {
  for_each = {
    for v in var.record_sets :
    "${v.name}/${v.type}" => merge(v, {
      name = (
        v.name == "@" ?
        google_dns_managed_zone.this.dns_name :
        "${v.name}.${google_dns_managed_zone.this.dns_name}"
      )
    })
  }

  managed_zone = google_dns_managed_zone.this.name
  name         = each.value.name
  type         = each.value.type
  ttl          = each.value.ttl
  rrdatas      = each.value.rrdatas
}
