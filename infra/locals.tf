locals {
  # rg-basiclab-ksa
  resource_group_name = "rg-${var.app_name}-${var.name_suffix}"

  # stbasiclabksa01 - storage names allow only lowercase letters and digits
  storage_account_name = lower(replace("st${var.app_name}${var.name_suffix}01", "-", ""))

  # Standard tags on every resource; caller's extra tags merged in
  common_tags = merge(var.tags, {
    app         = var.app_name
    environment = var.environment
    managed_by  = "terraform"
  })
}
