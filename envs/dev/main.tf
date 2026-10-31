module "foundation" {
  source = "../../modules/app-foundation"

  app_name         = "basiclab"
  environment      = "dev"
  name_suffix      = "ksa"
  replication_type = "LRS"

  tags = {
    owner = "shoukat"
    stage = "sandbox"
    lab   = "azure-platform-basic-lab"
  }
}
