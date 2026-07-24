output "action_group_id" {
  description = "Identifiant de l'Action Group Azure Monitor"
  value       = azurerm_monitor_action_group.main.id
}

output "kql_alert_id" {
  description = "Identifiant de l'alerte KQL sur les erreurs HTTP"
  value       = azurerm_monitor_scheduled_query_rules_alert_v2.http_errors.id
}

output "prometheus_rule_group_id" {
  description = "Identifiant du groupe de règles Prometheus"
  value       = azurerm_monitor_alert_prometheus_rule_group.custom_metric.id
}