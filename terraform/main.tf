# ==========================================
# MODULE APPLICATION INSIGHTS
# ==========================================

module "app_insight" {
  source = "./modules/app_insight"

  resource_group_name          = var.resource_group_name
  location                     = var.location
  environment                  = var.environment
  team                         = var.team
  log_analytics_workspace_name = var.log_analytics_workspace_name
  application_insights_name    = var.application_insights_name
  tags                         = var.tags
}


# ==========================================
# MODULE RÉSEAU
# ==========================================

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


