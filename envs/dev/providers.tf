# Target subscription is pinned here so it is visible in review.
# Authentication is NOT set here: locally azurerm uses az login,
# in the pipeline it uses ARM_USE_OIDC / ARM_CLIENT_ID from the workflow.
# Provider registration is off because pipeline identities are scoped to
# resource groups and cannot read subscription-level provider state.
provider "azurerm" {
  features {}

  subscription_id                 = "ce88c049-aaf2-4f55-a832-a41f1535453a"
  resource_provider_registrations = "none"
}
