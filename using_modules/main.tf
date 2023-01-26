terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.40.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.SUBSCRIPTION
  tenant_id       = var.TENANT
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
    // do not delete resource groups with manually created resources
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

data "azurerm_client_config" "current" {}
data "azurerm_subscription" "primary_sub" {}


// create a resource group to build the module to
resource "azurerm_resource_group" "my_data_twin" {
  name     = "rg-my-data-twin"
  location = var.LOCATION
}

// use the data twin module to create a data twin
module "datatwin" {
  source = "./data_twin"
  config = {
    data_twin_name = "my-demotwin"
    resource_group = azurerm_resource_group.my_data_twin
  }
  data_twin_admin = {
    object_id      = data.azurerm_client_config.current.object_id
    tenant_id      = data.azurerm_client_config.current.tenant_id
    user_principal = "Azure Adminitrator"
  }
}
