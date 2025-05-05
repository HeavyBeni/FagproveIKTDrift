terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.0"
    }
  }
  required_version = ">= 1.4"
}

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id

  features {}
}

provider "azuread" {
  tenant_id = var.tenant_id
}