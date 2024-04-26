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

module "spokes" {
  for_each = var.locations

  source         = "./modules/spoke"
  team_name      = var.team_name
  location       = each.value
  location_short = each.key
  hub_storage_id = module.hub.storage_id
}
