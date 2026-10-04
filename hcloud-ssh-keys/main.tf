locals {
  keys_from_directory = (
    var.keys_dir != "" ?
    {
      for k in fileset(var.keys_dir, "*.pub") :
      trim(k, ".pub") => chomp(file("${var.keys_dir}/${k}"))
    } : {}
  )
}

resource "hcloud_ssh_key" "this" {
  for_each = local.keys_from_directory

  name       = each.key
  public_key = each.value
}
