resource "azurerm_virtual_network" "spoke1" {
  name                = "vnet-${var.team_name}-dev-${var.spoke1.location_short}"
  location            = var.spoke1.location
  resource_group_name = var.spoke1.resource_group_name
  address_space       = ["10.0.4.0/22"]
}

resource "azurerm_virtual_network" "spoke2" {
  name                = "vnet-${var.team_name}-dev-${var.spoke2.location_short}"
  location            = var.spoke2.location
  resource_group_name = var.spoke2.resource_group_name
  address_space       = ["10.0.8.0/22"]
}
