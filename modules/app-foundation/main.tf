resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_storage_account" "data" {
  name                            = local.storage_account_name
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  tags                            = local.common_tags

  lifecycle {
    precondition {
      condition     = can(regex("^[a-z0-9]{3,24}$", local.storage_account_name))
      error_message = "Built storage account name is invalid: must be 3-24 lowercase letters or digits."
    }
  }
}
