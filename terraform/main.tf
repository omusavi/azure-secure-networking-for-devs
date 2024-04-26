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

locals {
  spoke1 = {
    location = var.locations[keys(var.locations)[0]]
    short    = keys(var.locations)[0]
  }
  spoke2 = {
    location = var.locations[keys(var.locations)[1]]
    short    = keys(var.locations)[1]
  }
}

module "hub" {
  source    = "./modules/hub"
  team_name = var.team_name
  location  = var.hub_location
}

module "spokes" {
  for_each = var.locations

  source         = "./modules/spoke"
  team_name      = var.team_name
  location       = each.value
  location_short = each.key
  hub_storage_id = module.hub.storage_id
}

module "vnets" {
  source    = "./modules/1-vnets"
  team_name = var.team_name
  spokes    = module.spokes
}
