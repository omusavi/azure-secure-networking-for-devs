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



module "hub" {
  source    = "./modules/hub"
  team_name = var.team_name
  location  = var.hub_location
}

module "spoke1" {
  source         = "./modules/spoke"
  team_name      = var.team_name
  location       = var.location1
  location_short = var.location1_short
  hub_storage_id = module.hub.storage_id
}

module "spoke2" {
  source         = "./modules/spoke"
  team_name      = var.team_name
  location       = var.location2
  location_short = var.location2_short
  hub_storage_id = module.hub.storage_id
}
