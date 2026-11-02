terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-ksa"
    storage_account_name = "sttfstateksa01"
    container_name       = "tfstate-dev"
    key                  = "azure-platform-basic-lab/dev.tfstate"
    use_azuread_auth     = true
  }
}
