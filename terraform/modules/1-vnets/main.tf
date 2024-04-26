resource "azurerm_virtual_network" "spokes" {
  for_each = { for i, v in values(var.spokes) : v.location_short => merge({
    address_space = "10.0.${(i + 1) * 4}.0/22"
  }, v) }

  name                = "vnet-${var.team_name}-dev-${each.key}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = [each.value.address_space]
}
