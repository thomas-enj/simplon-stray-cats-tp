# ==========================================
# 1. PARAMÈTRES DU SOCLE AZURE
# ==========================================

variable "location" {
  description = "Région Azure principale pour le déploiement"
  type        = string
  default     = "francecentral"
}

variable "team" {
  description = "Nom de l'équipe"
  type        = string
  default     = "stray-cats"
}

variable "storage_account_container_name" {
  description = "Nom du conteneur du Storage Account"
  type        = string
}

variable "owner" {
  description = "Nom du propriétaire du projet"
  type        = string
}

variable "resource_group_name" {
  description = "Nom du Resource Group dans lequel déployer la stack"
  type        = string
}

variable "subscription" {
  description = "Identifiant de l'abonnement Azure Simplon OCC"
  type        = string
  default     = "5e683e0f-b00c-48d6-9769-5aaf598de8f1"
}

variable "environment" {
  description = "Environnement de déploiement"
  type        = string
}

# ==========================================
# 2. TAGS DE GOUVERNANCE
# ==========================================

variable "tags" {
  description = "Tags obligatoires appliqués sur l'ensemble des ressources"
  type        = map(string)

  default = {
    Project   = "Observability-Stack"
    ManagedBy = "Terraform"
  }
}

# ==========================================
# 3. LOG ANALYTICS ET APPLICATION INSIGHTS
# ==========================================

variable "log_analytics_workspace_name" {
  description = "Nom du Log Analytics Workspace"
  type        = string
  default     = "law-stray-cats-dev"
}

variable "application_insights_name" {
  description = "Nom de la ressource Application Insights"
  type        = string
  default     = "appi-stray-cats-dev"
}

variable "azure_monitor_workspace_name" {
  description = "Nom de l'Azure Monitor Workspace existant"
  type        = string
  default     = "amw-stray-cats-prod"
}

# ==========================================
# 4. ALERTES AZURE MONITOR
# ==========================================

variable "action_group_name" {
  description = "Nom de l'Action Group"
  type        = string
  default     = "ag-stray-cats-prod"
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
  description = "Nom de l'alerte KQL"
  type        = string
  default     = "alert-http-errors-prod"
}

variable "http_error_threshold" {
  description = "Nombre d'erreurs HTTP déclenchant l'alerte"
  type        = number
  default     = 5
}