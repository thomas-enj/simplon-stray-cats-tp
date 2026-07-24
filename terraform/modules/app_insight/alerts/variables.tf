variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type        = string
}

variable "location" {
  description = "Région Azure des ressources"
  type        = string
}

variable "environment" {
  description = "Environnement de déploiement"
  type        = string
}

variable "team" {
  description = "Nom de l'équipe responsable"
  type        = string
}

variable "action_group_name" {
  description = "Nom de l'Action Group"
  type        = string
}

variable "action_group_short_name" {
  description = "Nom court de l'Action Group"
  type        = string
  default     = "straycats"
}

variable "alert_email" {
  description = "Adresse email destinataire des alertes"
  type        = string
}

variable "kql_alert_name" {
  description = "Nom de la règle d'alerte KQL"
  type        = string
  default     = "alert-http-errors"
}

variable "log_analytics_workspace_id" {
  description = "Identifiant du Log Analytics Workspace"
  type        = string
}

variable "http_error_threshold" {
  description = "Nombre d'erreurs HTTP déclenchant l'alerte"
  type        = number
  default     = 5
}

variable "kql_alert_severity" {
  description = "Niveau de sévérité de l'alerte KQL"
  type        = number
  default     = 2
}

variable "enable_prometheus_alert" {
  description = "Active ou désactive l'alerte Prometheus"
  type        = bool
  default     = false
}

variable "prometheus_rule_group_name" {
  description = "Nom du groupe de règles Prometheus"
  type        = string
  default     = "prometheus-custom-alerts"
}

variable "azure_monitor_workspace_id" {
  description = "Identifiant de l'Azure Monitor Workspace utilisé par Managed Prometheus"
  type        = string
  default     = null
  nullable    = true
}

variable "cluster_name" {
  description = "Nom du cluster supervisé par Managed Prometheus"
  type        = string
  default     = null
  nullable    = true
}

variable "promql_expression" {
  description = "Expression PromQL utilisée pour l'alerte"
  type        = string
  default     = "custom_metric_total > 100"
}

variable "prometheus_alert_severity" {
  description = "Niveau de sévérité de l'alerte Prometheus"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags appliqués aux ressources"
  type        = map(string)
  default     = {}
}