terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.100.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "hub" {
  name     = "rg-${var.team_name}-dev-hub"
  location = var.hub_location
}

resource "azurerm_storage_account" "hub" {
  name                     = "st${var.team_name}devhub"
  resource_group_name      = azurerm_resource_group.hub.name
  location                 = azurerm_resource_group.hub.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_virtual_network" "hub" {
  name                = "vnet-${var.team_name}-dev-hub"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = ["10.0.0.0/22"]
}

resource "azurerm_subnet" "hub" {
  name                 = "snet-${var.team_name}-dev-hub"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.0.0.0/26"]
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]
}

module "spoke1" {
  source         = "./modules/spoke"
  team_name      = var.team_name
  location       = var.location1
  location_short = var.location1_short
  hub_storage_id = azurerm_storage_account.hub.id
}

module "spoke2" {
  source         = "./modules/spoke"
  team_name      = var.team_name
  location       = var.location2
  location_short = var.location2_short
  hub_storage_id = azurerm_storage_account.hub.id
}
