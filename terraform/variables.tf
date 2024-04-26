variable "team_name" {
  type = string
  validation {
    condition     = length(var.team_name) > 0 && length(var.team_name) < 10 && can(regex("^[a-zA-Z0-9]*$", var.team_name))
    error_message = "Team name must be at least 2 characters and less than 10 and contain only alphanumeric characters"
  }
}


variable "locations" {
  description = "Map of locations where the key is the 'short' name and the value is the Azure region"
  type        = map(string)
  default = {
    eu = "westeurope"
    us = "eastus"
  }
}

variable "hub_location" {
  type    = string
  default = "swedencentral"
}
