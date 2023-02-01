variable "SUBSCRIPTION" {
  type        = string
  sensitive   = true
  description = "The ID of the Azure subscription to use"
}

variable "LOCATION" {
  type        = string
  default     = "westeurope"
  description = "Default location for resources"
}
