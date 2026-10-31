# Records the refactor from flat resources into module.foundation.
# Terraform renames these entries in state; nothing in Azure changes.
moved {
  from = azurerm_resource_group.main
  to   = module.foundation.azurerm_resource_group.main
}

moved {
  from = azurerm_storage_account.data
  to   = module.foundation.azurerm_storage_account.data
}
