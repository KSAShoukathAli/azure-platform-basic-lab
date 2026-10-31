resource "azurerm_resource_group" "main" {
  name     = "rg-basiclab-ksa"
  location = "canadacentral"

  tags = {
    managed_by = "terraform"
    lab        = "azure-platform-basic-lab"
    owner      = "shoukat"
  }
}
