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
