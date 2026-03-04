locals {
  domain_name = trimsuffix(var.domain_name, ".")
}

resource "cloudflare_zone" "this" {
  account = {
    id = var.account_id
  }

  name = local.domain_name
  type = var.zone_type
}

// Due to Cloudflare API treating each record as its own entity
// rather than allowing multiple rrdatas within single record,
// we need to transform the input variable (compatible with other
// dns provider) from:
//
//   [
//     {
//       "name" = "www",
//       "type" = "A",
//       "ttl" = 3600,
//       "rrdatas" = [
//         "127.0.0.1",
//         "127.0.0.2",
//       ],
//     },
//   ]
//
// Into this:
//
//   [
//     {
//       "key" => "www/A/1",
//       "value" => {
//         "name" = "www",
//         "type" = "A",
//         "ttl" = 3600,
//         "rrdatas" = "127.0.0.1",
//       },
//     },
//     {
//       "key" => "www/A/2",
//       "value" => {
//         "name" = "www",
//         "type" = "A",
//         "ttl" = 3600,
//         "rrdatas" = "127.0.0.2",
//       },
//     },
//   ]
//
// Since flatten only supports flatten a list of map into map, but cannot
// merge a key into a single map, so we have to do this terrible hack.
locals {
  other_records = flatten([
    for v in var.record_sets : [
      for idx, rr in v.rrdatas : {
        key = "${v.name}/${v.type}/${idx + 1}",
        value = {
          name     = v.name,
          type     = v.type,
          ttl      = lookup(v, "proxied", false) ? 1 : v.ttl,
          proxied  = lookup(v, "proxied", false),
          priority = 0,
          rrdata   = rr,
          flags    = null,
          tag      = null,
        },
      }
    ] if v.type != "MX" && v.type != "CAA"
  ])

  // MX record requires priority argument, but we're using the same
  // "10 in.server.example" format as all other DNS modules, so some
  // gymnastic is required.
  mx_records = flatten([
    for v in var.record_sets : [
      for idx, rr in v.rrdatas : {
        key = "${v.name}/${v.type}/${idx + 1}",
        value = merge(
          {
            name    = v.name,
            type    = v.type,
            ttl     = v.ttl,
            proxied = false,
            flags   = null,
            tag     = null,
          },
          regex("^(?P<priority>[0-9]+) (?P<rrdata>.*)$", rr),
        ),
      }
    ] if v.type == "MX"
  ])

  // CAA record requires tag argument, but we're using the same
  // "10 tag domain" format as all other DNS modules, so some
  // gymnastic is required.
  caa_records = flatten([
    for v in var.record_sets : [
      for idx, rr in v.rrdatas : {
        key = "${v.name}/${v.type}/${idx + 1}",
        value = merge(
          {
            name     = v.name,
            type     = v.type,
            ttl      = v.ttl,
            priority = 0,
            proxied  = false,
          },
          regex("^(?P<flags>[0-9]+) (?P<tag>[a-zA-Z0-9]+) \"(?P<rrdata>[^\"]+)\"$", rr),
        ),
      }
    ] if v.type == "CAA"
  ])

  records = concat(local.other_records, local.mx_records, local.caa_records)
}

# Cloudflare Provider v5 is horrible, live with it
# https://github.com/cloudflare/terraform-provider-cloudflare/issues/5517
resource "cloudflare_dns_record" "this" {
  for_each = {
    for v in local.records :
    v.key => v.value
  }

  zone_id  = cloudflare_zone.this.id
  name     = each.value.name
  ttl      = each.value.ttl
  type     = each.value.type
  priority = each.value.priority
  proxied  = each.value.proxied
  content  = each.value.flags != null ? null : each.value.rrdata

  tags     = []
  settings = {
    flatten_cname = false
    ipv4_only     = false
    ipv6_only     = false
  }

  data = each.value.flags != null ? {
    flags = each.value.flags
    tag   = each.value.tag
    value = each.value.rrdata
  } : null
}
