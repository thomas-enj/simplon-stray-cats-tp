variable "resource_group_name" {
  description = "Nom du Resource Group"
  type        = string
}

variable "location" {
  description = "Région Azure"
  type        = string
}

variable "environment" {
  description = "Environnement de déploiement"
  type        = string
}

variable "team" {
  description = "Nom de l'équipe"
  type        = string
}

variable "tags" {
  description = "Tags appliqués aux ressources Azure"
  type        = map(string)
  default     = {}
}

variable "log_analytics_workspace_name" {
  description = "Nom du Log Analytics Workspace"
  type        = string
}

variable "application_insights_name" {
  description = "Nom de la ressource Application Insights"
  type        = string
}

variable "log_analytics_retention_days" {
  description = "Durée de conservation des journaux dans Log Analytics"
  type        = number
  default     = 30
}

variable "application_insights_type" {
  description = "Type de l'application supervisée par Application Insights"
  type        = string
  default     = "web"
}