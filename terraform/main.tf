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

# ==========================================
# MODULE ALERTES
# ==========================================

module "alerts" {
  source = "./modules/alerts"

  resource_group_name          = var.resource_group_name
  location                     = var.location
  environment                  = var.environment
  team                         = var.team
  tags                         = var.tags
  azure_monitor_workspace_name = var.azure_monitor_workspace_name

  action_group_name       = var.action_group_name
  action_group_short_name = var.action_group_short_name
  alert_email             = var.alert_email

  kql_alert_name             = var.kql_alert_name
  log_analytics_workspace_id = module.app_insight.log_analytics_workspace_id
  http_error_threshold       = var.http_error_threshold

  enable_prometheus_alert = false
}