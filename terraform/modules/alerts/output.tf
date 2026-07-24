output "action_group_id" {
  description = "Identifiant de l'Action Group"
  value       = azurerm_monitor_action_group.main.id
}

output "action_group_name" {
  description = "Nom de l'Action Group"
  value       = azurerm_monitor_action_group.main.name
}

output "kql_alert_id" {
  description = "Identifiant de la règle d'alerte KQL"
  value       = azurerm_monitor_scheduled_query_rules_alert_v2.http_errors.id
}

output "prometheus_rule_group_id" {
  description = "Identifiant du groupe de règles Prometheus"
  value = var.enable_prometheus_alert ? (
    azurerm_monitor_alert_prometheus_rule_group.custom_metric[0].id
  ) : null
}