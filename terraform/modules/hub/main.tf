resource "azurerm_resource_group" "hub" {
  name     = "rg-${var.team_name}-dev-hub"
  location = var.location
}

resource "azurerm_storage_account" "hub" {
  name                     = "st${var.team_name}devhub"
  resource_group_name      = azurerm_resource_group.hub.name
  location                 = azurerm_resource_group.hub.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
