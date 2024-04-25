resource "azurerm_resource_group" "spoke" {
  name     = "rg-${var.team_name}-dev-${var.location_short}"
  location = var.location
}
