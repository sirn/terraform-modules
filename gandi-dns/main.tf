locals {
  domain_name = trimsuffix(var.domain_name, ".")
}

resource "gandi_livedns_domain" "this" {
  name = local.domain_name

  lifecycle {
    ignore_changes = [
      ttl,
      automatic_snapshots,
    ]
  }
}

resource "gandi_livedns_record" "this" {
  for_each = {
    for v in var.record_sets :
    "${v.name}/${v.type}" => v
  }

  zone   = gandi_livedns_domain.this.id
  name   = each.value.name
  type   = each.value.type
  ttl    = each.value.ttl
  values = each.value.rrdatas
}
