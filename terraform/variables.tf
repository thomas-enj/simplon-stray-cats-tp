# ==========================================
# 1. PARAMÈTRES DU SOCLE AZURE
# ==========================================

# variable "location" {
#   description = "Région Azure principale pour le déploiement"
#   type        = string
#   default     = "francecentral"
# }


# variable "team" {
#   description = "Team name"
#   type        = string
#   default     = "stray-cats"
# }

variable "storage_account_container_name" {
  description = "storage account name"
  type        = string

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
  default     = "5e683e0f-b00c-48d6-9769-5aaf598de8f1"
}
# ==========================================
# 2. TAGS DE GOUVERNANCE
# ==========================================

# variable "tags" {
#   description = "Tags obligatoires appliqués sur l'ensemble des ressources"
#   type        = map(string)
#   default = {
#     Project   = "Observability-Stack"
#     ManagedBy = "Terraform"
#   }
# }
