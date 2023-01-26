variable "SUBSCRIPTION" {
  type = string
  sensitive = true
  description = "The subscription to build the defined infrastructure to"
}

variable "TENANT" {
  type = string
  sensitive = true
  description = "The home tenant id of the subscription to manipulate"
}

variable "LOCATION" {
  type = string
  default = "westeurope"
  description = "The location to build the infrastrucuture to. This is a single location project, hence it can be used as a default"
}