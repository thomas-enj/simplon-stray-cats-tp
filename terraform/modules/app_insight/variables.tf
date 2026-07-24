variable "location" {
  description = "Région Azure des ressources de supervision"
  type        = string
}

variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type        = string
}

variable "environment" {
  description = "Environnement de déploiement"
  type        = string
}

variable "team" {
  description = "Nom de l'équipe responsable des ressources"
  type        = string
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
  description = "Durée de conservation des logs en jours"
  type        = number
  default     = 30
}

variable "application_insights_type" {
  description = "Type d'application supervisée"
  type        = string
  default     = "web"
}

variable "tags" {
  description = "Tags appliqués aux ressources"
  type        = map(string)
  default     = {}
}