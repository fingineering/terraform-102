terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.40.0"
    }
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = var.SUBSCRIPTION
}


resource "azurerm_resource_group" "my-demo-group" {
  name     = "not-a-valid-group-name"
  location = var.LOCATION
}

