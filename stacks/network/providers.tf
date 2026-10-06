terraform {
  required_version = ">= 1.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Autentisering og subscription kommer fra miljøet (az login / ARM_SUBSCRIPTION_ID).
provider "azurerm" {
  features {}
}
