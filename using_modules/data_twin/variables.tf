// configuration for the data twin parameters
variable "config" {
  type = object({
    resource_group = object({
      name     = string,
      location = string,
    })
    data_twin_name = string
  })
  description = "The basic configuration of the data twin"
}

variable "data_twin_admin" {
  type = object({
    user_principal = string
    object_id      = string
    tenant_id      = string
  })
  default = {
    user_principal = ""
    object_id = null
    tenant_id = null
  }
  sensitive   = true
  description = "Data Twins only use AAD authentification, hence a admin needs to be specified as an AAD object"
}
