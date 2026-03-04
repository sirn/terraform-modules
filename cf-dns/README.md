# cf-dns

Terraform module for managing Cloudflare DNS zones with optional security and performance settings.

## Features

- DNS zone creation and management
- DNS record sets (A, AAAA, CNAME, MX, TXT, etc.)
- Optional SSL/TLS configuration
- Optional content protection (email obfuscation, hotlink protection)
- Optional performance settings (Auto Minify)

All features work on Cloudflare Free and Pro plans.

## Usage

### DNS-only mode (default)

```hcl
module "dns" {
  source = "git@git.sr.ht:~sirn/terraform-modules//cf-dns"

  account_id  = "your-account-id"
  domain_name = "example.com"

  record_sets = [
    {
      name    = "@"
      type    = "A"
      ttl     = "300"
      proxied = true
      rrdatas = ["203.0.113.1"]
    },
    {
      name    = "www"
      type    = "CNAME"
      ttl     = "3600"
      proxied = true
      rrdatas = ["example.com."]
    }
  ]
}
```

### Full configuration

```hcl
module "dns" {
  source = "git@git.sr.ht:~sirn/terraform-modules//cf-dns"

  account_id  = "your-account-id"
  domain_name = "example.com"

  enable_ssl         = true
  enable_protection  = true
  enable_performance = true

  ssl_mode                 = "strict"
  always_use_https         = true
  automatic_https_rewrites = true

  security_level     = "medium"
  email_obfuscation  = true
  hotlink_protection = true

  minify_css  = true
  minify_js   = true
  minify_html = false

  record_sets = [
    # ... your records
  ]
}
```

## Required API Token Permissions

| Feature | Permission |
|---------|------------|
| **Basic DNS** | `Zone:Edit` |
| **SSL/TLS** | `Zone:Edit` |
| **Protection** | `Zone:Edit` |
| **Performance** | `Zone:Edit` |

Create a token at https://dash.cloudflare.com/profile/api-tokens with **Zone:Edit** permission for the zones you want to manage.

## Feature Flags

All optional features are disabled by default:

| Flag | Description |
|------|-------------|
| `enable_ssl` | Enable SSL/TLS settings |
| `enable_protection` | Enable content protection settings |
| `enable_performance` | Enable performance settings |

## Inputs

### Required

| Name | Description | Type |
|------|-------------|------|
| `account_id` | Cloudflare account ID | `string` |
| `domain_name` | Domain name for the zone | `string` |

### DNS

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `zone_type` | Zone type (`full`, `partial`, etc.) | `string` | `"full"` |
| `record_sets` | List of DNS record sets | `list(any)` | `[]` |

### SSL/TLS (requires `enable_ssl = true`)

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `ssl_mode` | SSL mode (`off`, `flexible`, `full`, `strict`) | `string` | `"strict"` |
| `always_use_https` | Redirect HTTP to HTTPS | `bool` | `true` |
| `automatic_https_rewrites` | Enable HTTPS rewrites | `bool` | `true` |

### Protection (requires `enable_protection = true`)

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `security_level` | Security level (`off`, `essentially_off`, `low`, `medium`, `high`, `under_attack`) | `string` | `"medium"` |
| `email_obfuscation` | Hide email addresses from scrapers | `bool` | `true` |
| `hotlink_protection` | Prevent other sites from embedding your images | `bool` | `false` |

### Performance (requires `enable_performance = true`)

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `minify_css` | Minify CSS files | `bool` | `false` |
| `minify_js` | Minify JavaScript files | `bool` | `false` |
| `minify_html` | Minify HTML files | `bool` | `false` |

## Outputs

| Name | Description |
|------|-------------|
| `zone_id` | Cloudflare zone ID |
| `zone_name` | Domain name |
| `name_servers` | Cloudflare name servers for the zone |

## License

MIT
