#----------------------------------------------
# Project-wide Variables
#----------------------------------------------
variable "tenant_id" {
  description = "The Azure tenant ID."
  type        = string
}
variable "subscription_id" {
  description = "The Azure subscription ID."
  type        = string
}
variable "client_id" {
  type        = string
  description = "ID token for provider authentication"
}
variable "client_secret" {
  type        = string
  description = "Secret token for provider authentication"
  ephemeral   = true
}

variable "identity_token" {
  type        = string
  description = "Identity token for provider authentication"
}
#----------------------------------------------
# Project Metadata Variables
#----------------------------------------------
variable "project_name" {
  description = "The name of the project, used as a prefix for resources."
  type        = string
}
variable "customer_name" {
  description = "The name of the customer, used as a prefix for resources."
  type        = string
}
variable "project_region" {
  description = "The region for the project resources."
  type        = string
}
variable "project_env" {
  description = "The environment for the project (e.g., dev, prd)."
  type        = string
}

variable "default_tags" {
  description = "A map of default tags to apply to all resources."
  type        = map(string)
  default     = {}
}
variable "enable_telemetry" {
  description = "Enable telemetry for the module.  this sends anonymous data to Microsoft to help improve the module over time. Please see the module documentation for more details."
  type        = bool
  default     = false
}
#----------------------------------------------
# Azure Resource Group Variables
#----------------------------------------------
variable "location" {
  description = "The Azure region where the resource group will be created."
  type        = string
  default     = null
}
variable "name" {
  description = "The name of the Azure resource group."
  type        = string
  default     = null
}
variable "tags" {
  description = "A map of tags to assign to the resource group."
  type        = map(string)
  default     = {}
}
variable "lock_kind" {
  description = "The type of lock to apply. Possible values are 'CanNotDelete' and 'ReadOnly' "
  type        = string
  default     = null
}
