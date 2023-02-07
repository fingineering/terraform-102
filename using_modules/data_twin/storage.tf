resource "azurerm_storage_account" "demo_storage" {
  resource_group_name = var.config.resource_group.name
  location = var.config.resource_group.location
  name = "${var.config.data_twin_name}storage"
  account_tier = "Standard"
  account_replication_type = "LRS"
  default_to_oauth_authentication = true
}

resource "azurerm_storage_container" {
  name = "${var.config.data_twin_name}data"
  storage_account_name = azurerm_storage_account.demo_storage.name
  container_access_type = "private"
}

resource "azurerm_role_assignment" "databaseToStorage" {
  scope = azurerm_mssql_server.data_twin_server.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id = azurerm_mssql_server.data_twin_server.identity[0].principal_id
}
