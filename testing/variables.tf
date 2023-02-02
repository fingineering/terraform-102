variable "SUBSCRIPTION" {
  type = string
  sensitive = true
  nullable = false
  validation {
    condition = length(var.SUBSCRIPTION) > 0
    error_message = "Not a valid uuid"
  }
}

variable "LOCATION" {
  type = string
  default = "westeurope"
}