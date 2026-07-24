variable "resource_group_name" {
  description = "Nom du groupe de ressources Azure"
  type        = string
}

variable "owner" {
  description = "Learner identifier (firstname-lastname, lowercase, hyphens). Ex: john-doe"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]+[a-z0-9]$", var.owner))
    error_message = "owner must be lowercase, letters, digits and hyphens only."
  }
}

variable "team" {
  description = "The team in charge of the project"
  type        = string
  default     = "stray-cats"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "francecentral"
}

variable "shared_plan_name" {
  description = "Name of the shared App Service plan"
  type        = string
  default     = "plan-npr-prf2026"
}

variable "tags" {
  description = "Additional tags to merge with default tags"
  type        = map(string)
  default     = {}
}

variable "storage_account_container_name" {
  description = "Backend storage account container name for the Terraform state"
  type        = string
}
