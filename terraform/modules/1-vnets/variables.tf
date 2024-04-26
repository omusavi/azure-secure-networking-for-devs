variable "team_name" {
  type = string
}


variable "spokes" {
  type = map(object({
    resource_group_name = string
    location            = string
    location_short      = string
  }))
}
