locals {
  resource_group_name  = "rg-${var.app_name}-${var.name_suffix}"
  storage_account_name = lower(replace("st${var.app_name}${var.name_suffix}01", "-", ""))

  common_tags = merge(var.tags, {
    app         = var.app_name
    environment = var.environment
    managed_by  = "terraform"
  })
}
