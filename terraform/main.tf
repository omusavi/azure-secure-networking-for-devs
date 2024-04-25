terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
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

module "spoke1" {
  source         = "./modules/spoke"
  team_name      = var.team_name
  location       = var.location1
  location_short = var.location1_short
}

module "spoke2" {
  source         = "./modules/spoke"
  team_name      = var.team_name
  location       = var.location2
  location_short = var.location2_short
}
