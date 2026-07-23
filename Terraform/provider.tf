terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.1.0"
    }
  }


  backend "azurerm" {
    resource_group_name  = "rg-monitoring-groupe1"
    storage_account_name = "ststatestraycats01"
    container_name       = "tfstate"
    key                  = "state_straycats.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
