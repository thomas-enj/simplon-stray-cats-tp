

## APPS 

module "mon_apm" {
  source = "./modules/app_insight"

}


module "network" {
  source = "./modules/network"

  resource_group_name            = var.resource_group_name
  storage_account_container_name = var.storage_account_container_name
  owner                          = var.owner
  team                           = var.team
  location                       = var.location
  tags                           = var.tags
}

module "vm_prometheus" {
  source = "./modules/vm_prometheus"

  resource_group_name            = var.resource_group_name
  storage_account_container_name = var.storage_account_container_name
  owner                          = var.owner

  subnet_id_prometheus = module.network.subnet_id_prometheus
  vnet_id              = module.network.vnet_id
  nsg_id               = module.network.nsg_id

}







