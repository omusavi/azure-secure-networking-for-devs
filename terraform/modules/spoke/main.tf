resource "azurerm_resource_group" "spoke" {
  name     = "rg-${var.team_name}-dev-${var.location_short}"
  location = var.location
}

resource "azurerm_storage_account" "spoke" {
  name                     = "st${var.team_name}dev${var.location_short}"
  resource_group_name      = azurerm_resource_group.spoke.name
  location                 = azurerm_resource_group.spoke.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
