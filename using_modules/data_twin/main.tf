/*
 * Data Twin
 * =========
 *
 * A module to create a data twin on azure, abstract construct, for production use system specific twins.
 * Creates a data twin in the same region as the resource group
 * 
 * The data twin in this example consits of:
 * - an Azure SQL Database
 * - a Blob Storage Container
 * - a Container Instance to host an API
 */

resource "azurerm_mssql_server" "data_twin_server" {
  name                          = "${var.config.data_twin_name}-server"
  resource_group_name           = var.config.resource_group.name
  location                      = var.config.resource_group.location
  version                       = "12.0"
  minimum_tls_version           = "1.2"
  public_network_access_enabled = true

  azuread_administrator {
    login_username              = var.data_twin_admin.user_principal
    object_id                   = var.data_twin_admin.object_id
    tenant_id                   = var.data_twin_admin.tenant_id
    azuread_authentication_only = true
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_mssql_database" "data_twin_database" {
  name                 = "db-${var.config.data_twin_name}"
  server_id            = azurerm_mssql_server.data_twin_server.id
  collation            = "SQL_Latin1_General_CP1_CI_AS"
  sku_name             = "Basic"
  zone_redundant       = false
  storage_account_type = "Zone"
}



