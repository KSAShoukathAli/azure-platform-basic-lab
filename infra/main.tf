module "foundation" {
  source = "../modules/app-foundation"

  app_name    = var.app_name
  environment = var.environment
  name_suffix = var.name_suffix
  location    = var.location
  tags        = var.tags
}
