module "foundation" {
  source = "../../modules/app-foundation"

  app_name         = "basiclab"
  environment      = "test"
  name_suffix      = "ksa"
  replication_type = "ZRS"

  tags = {
    owner = "shoukat"
    lab   = "azure-platform-basic-lab"
  }
}
