#----------------------------------------------
# Project-wide Variables
#----------------------------------------------
variable "tenant_id" {
  description = "The Azure tenant ID."
  type        = string
  default     = null
}
variable "subscription_id" {
  description = "The Azure subscription ID."
  type        = string
  default     = null
}
#----------------------------------------------
# Project Metadata Variables
#----------------------------------------------
variable "project_name" {
  description = "The name of the project, used as a prefix for resources."
  type        = string
  default     = null
}
variable "customer_name" {
  description = "The name of the customer, used as a prefix for resources."
  type        = string
  default     = null
}
variable "project_region" {
  description = "The region for the project resources."
  type        = string
  default     = null
}
variable "project_env" {
  description = "The environment for the project (e.g., dev, prd)."
  type        = string
  default     = null
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

variable "lock" {
  description = "Enable a lock on the resource group to prevent accidental deletion."
  type = object({
    kind = string
    name = optional(string, null)
  })
  default = null
}
variable "lock_kind" {
  description = "The type of lock to apply. Possible values are 'CanNotDelete' and 'ReadOnly' "
  type        = string
  default     = null
}

variable "lock_name" {
  description = "The name of the lock. If not provided, a default name will be generated."
  type        = string
  default     = null
}

variable "role_assignments" {
  description = "A map of role assignments for the resource group."
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
  default = {}
}
