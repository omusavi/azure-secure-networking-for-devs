variable "team_name" {
  type = string
  validation {
    condition     = length(var.team_name) > 0 && length(var.team_name) < 10 && can(regex("^[a-zA-Z0-9]*$", var.team_name))
    error_message = "Team name must be at least 2 characters and less than 10 and contain only alphanumeric characters"
  }
}

variable "location1" {
  type    = string
  default = "westeurope"
}

variable "location1_short" {
  type    = string
  default = "eu"
}

variable "location2" {
  type    = string
  default = "eastus"
}

variable "location2_short" {
  type    = string
  default = "us"
}

variable "hub_location" {
  type    = string
  default = "swedencentral"
}
