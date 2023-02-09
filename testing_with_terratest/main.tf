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

data "azurerm_client_config" "current" {}
data "azurerm_subscription" "primary_sub" {}


resource "azurerm_resource_group" "my-conform-group" {
  name     = "rg-correct-name"
  location = var.LOCATION
}


resource "azurerm_mssql_server" "demo_server" {
  name                          = "fhjabfhjesabfe"
  resource_group_name           = azurerm_resource_group.my-conform-group.name
  location                      = var.LOCATION
  version                       = "12.0"
  minimum_tls_version           = "1.2"
  public_network_access_enabled = true

  azuread_administrator {
    login_username              = "Azure SQL Admin"
    object_id                   = data.azurerm_client_config.current.object_id
    tenant_id                   = data.azurerm_client_config.current.tenant_id
    azuread_authentication_only = true
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_mssql_database" "demo_database" {
  name                 = "demoDatabase"
  server_id            = azurerm_mssql_server.demo_server.id
  collation            = "SQL_Latin1_General_CP1_CI_AS"
  sku_name             = "Basic"
  zone_redundant       = false
  storage_account_type = "Zone"
}


output "group-name" {
  value       = azurerm_resource_group.my-conform-group.name
  description = "Name of the resource group where the validation fails"
  precondition {
    condition     = azurerm_resource_group.my-conform-group.name == "rg-correct-name"
    error_message = "The resource group does not have a correct name to it"
  }
}

output "sql-server-name" {
  value = azurerm_mssql_server.demo_server.name
  description = "The name of the newly created mssql server"
}
