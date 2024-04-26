variable "team_name" {
  type = string
}


variable "spoke1" {
  type = object({
    resource_group_name = string
    location            = string
    location_short      = string
  })
}

variable "spoke2" {
  type = object({
    resource_group_name = string
    location            = string
    location_short      = string
  })
}
