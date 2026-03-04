# Shared locals for all files

locals {
  # Convert booleans to "on"/"off" strings for Cloudflare API
  bool_to_onoff = {
    true  = "on"
    false = "off"
  }
}
