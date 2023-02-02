variable SUBSCRIPTION {
  type = string
  sensitive = true
}

variable TENANT {
type = string
sensitive = false
}

variable LOCATION {
  type = string
  default = "westeurope"
}
