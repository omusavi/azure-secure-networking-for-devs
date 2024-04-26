output "resource_group_name" {
  value = azurerm_resource_group.spoke.name
}

output "location" {
  value = azurerm_resource_group.spoke.location
}

output "location_short" {
  value = var.location_short
}
