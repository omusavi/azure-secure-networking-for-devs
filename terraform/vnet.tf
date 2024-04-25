resource "azurerm_virtual_network" "hub" {
  name                = "vnet-${var.team_name}-dev-hub"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = ["10.0.0.0/22"]
}

resource "azurerm_subnet" "hub_default" {
  name                 = "snet-default-${var.team_name}-dev-hub"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.0.0.0/26"]
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]
}
