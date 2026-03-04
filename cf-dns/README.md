# cf-dns

Terraform module for managing Cloudflare DNS zones with optional security, performance, and bot management settings.

## Features

- DNS zone creation and management
- DNS record sets (A, AAAA, CNAME, MX, TXT, etc.)
- Optional SSL/TLS configuration
- Optional content protection (email obfuscation, hotlink protection)
- Optional Bot Management (Bot Fight Mode, AI bots protection)
- Optional performance settings (Auto Minify)

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

  # Enable feature groups
  enable_ssl            = true
  enable_protection     = true
  enable_performance    = true
  enable_bot_management = true

  # SSL/TLS settings
  ssl_mode                = "strict"
  always_use_https        = true
  automatic_https_rewrites = true

  # Content protection
  security_level     = "medium"
  email_obfuscation  = true
  hotlink_protection = true

  # Performance
  minify_css  = true
  minify_js   = true
  minify_html = false

  # Bot Management
  bot_fight_mode     = true
  ai_bots_protection = "block"  # block, disabled, only_on_ad_pages

  record_sets = [
    # ... your records
  ]
}
```

## Required API Token Permissions

| Feature | Permission | Notes |
|---------|------------|-------|
| **Basic DNS** | `Zone:Edit` | Required for zone creation and DNS records |
| **SSL/TLS** | `Zone:Edit` | Enable with `enable_ssl = true` |
| **Protection** | `Zone:Edit` | Enable with `enable_protection = true` |
| **Performance** | `Zone:Edit` | Enable with `enable_performance = true` |
| **Bot Management** | `Bot Management:Edit` | Requires Super Bot Fight Mode or Bot Management subscription |

### Token Configuration

1. Go to https://dash.cloudflare.com/profile/api-tokens
2. Create a custom token with:
   - **Zone:Edit** permission (for all features except Bot Management)
   - **Bot Management:Edit** permission (only if using `enable_bot_management = true`)
   - Include the specific zones you want to manage

## Feature Flags

All optional features are disabled by default for safety:

| Flag | Default | Description | Required Permission |
|------|---------|-------------|---------------------|
| `enable_ssl` | `false` | SSL/TLS settings (`ssl`, `always_use_https`, `automatic_https_rewrites`) | Zone:Edit |
| `enable_protection` | `false` | Content protection (`security_level`, `email_obfuscation`, `hotlink_protection`) | Zone:Edit |
| `enable_performance` | `false` | Performance settings (`minify`) | Zone:Edit |
| `enable_bot_management` | `false` | Bot Management (`bot_fight_mode`, `ai_bots_protection`) | Bot Management:Edit |

## Inputs

### Required

| Name | Description | Type |
|------|-------------|------|
| `account_id` | Cloudflare account ID | `string` |
| `domain_name` | Domain name for the zone | `string` |

### Optional

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `zone_type` | Zone type (`full`, `partial`, etc.) | `string` | `"full"` |
| `record_sets` | List of DNS record sets | `list(any)` | `[]` |
| `enable_ssl` | Enable SSL/TLS settings | `bool` | `false` |
| `enable_protection` | Enable content protection | `bool` | `false` |
| `enable_performance` | Enable performance settings | `bool` | `false` |
| `enable_bot_management` | Enable Bot Management | `bool` | `false` |
| `ssl_mode` | SSL mode (`off`, `flexible`, `full`, `strict`) | `string` | `"strict"` |
| `always_use_https` | Redirect HTTP to HTTPS | `bool` | `true` |
| `automatic_https_rewrites` | Enable HTTPS rewrites | `bool` | `true` |
| `security_level` | Security level | `string` | `"medium"` |
| `email_obfuscation` | Hide email addresses | `bool` | `true` |
| `hotlink_protection` | Prevent hotlinking | `bool` | `false` |
| `minify_css` | Minify CSS | `bool` | `false` |
| `minify_js` | Minify JavaScript | `bool` | `false` |
| `minify_html` | Minify HTML | `bool` | `false` |
| `bot_fight_mode` | Enable Bot Fight Mode | `bool` | `true` |
| `ai_bots_protection` | AI bots protection | `string` | `"block"` |

## Outputs

| Name | Description |
|------|-------------|
| `zone_id` | Cloudflare zone ID |
| `zone_name` | Domain name |
| `name_servers` | Cloudflare name servers for the zone |

## Notes

### Browser Integrity Check

Browser Integrity Check is **not** available via the Zone Settings API. It can only be configured via:
- Cloudflare Dashboard: **Security** > **Settings**
- Configuration Rules API (property name: `bic`)

To configure via Configuration Rules, create a rule with `action = "skip"` and `action_parameters { ruleset = "bic" }`.

### Bot Management Requirements

Bot Management API requires a **Super Bot Fight Mode** or **Bot Management** subscription. On Free/Pro plans, you can still use the dashboard to configure Bot Fight Mode, but API access may be restricted.

### Auto Minify Deprecation

Cloudflare is deprecating Auto Minify in favor of Compression Rules. Consider using Compression Rules for new configurations.

## License

MIT
