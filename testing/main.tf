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
}


resource "azurerm_resource_group" "my-not-conform-group" {
  name     = "rg-name"
  location = var.LOCATION
}


output "group-name" {
  value       = azurerm_resource_group.my-not-conform-group.name
  description = "Name of the resource group where the validation fails"
  precondition {
    condition     = azurerm_resource_group.my-not-conform-group.name == "rg-correct-name"
    error_message = "The resource group does not have a correct name to it"
  }
}
