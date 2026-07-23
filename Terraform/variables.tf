# ==========================================
# 1. PARAMÈTRES DU SOCLE AZURE
# ==========================================

variable "location" {
  description = "Région Azure principale pour le déploiement"
  type        = string
  default     = "francecentral"
}

variable "environment" {
  description = "Environnement de déploiement (dev, test, prod)"
  type        = string
  default     = "dev"
}


variable "team" {
  description = "Team name"
  type        = string
  default     = "stray-cats"
}

variable "owner" {
  description = "owner name"
  type        = string
}

variable "resource_group_name" {
  description = "Nom du Resource Group dans lequel déployer la stack"
  type        = string
}



variable "subscription" {
  description = "Simplon OCC"
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
