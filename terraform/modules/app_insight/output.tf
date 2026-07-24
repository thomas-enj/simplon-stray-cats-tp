output "log_analytics_workspace_id" {
  description = "Identifiant du Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.main.id
}

output "log_analytics_workspace_name" {
  description = "Nom du Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.main.name
}

output "application_insights_id" {
  description = "Identifiant de la ressource Application Insights"
  value       = azurerm_application_insights.main.id
}

output "application_insights_connection_string" {
  description = "Chaîne de connexion Application Insights"
  value       = azurerm_application_insights.main.connection_string
  sensitive   = true
}