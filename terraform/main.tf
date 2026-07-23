

## APPS 

module "mon_apm" {
  source = "./modules/app_insight"
}

module "network" {
  source = "./modules/network"

  resource_group_name            = var.resource_group_name
  storage_account_container_name = var.storage_account_container_name
  owner                          = var.owner

}



