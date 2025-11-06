#----------------------------------------------
# Project-wide Variables
#----------------------------------------------
variable "tenant_id" {
  description = "The Azure tenant ID."
  type        = string
  default     = ""
}
variable "subscription_id" {
  description = "The Azure subscription ID."
  type        = string
  default     = ""
}
#----------------------------------------------
# Project Metadata Variables
#----------------------------------------------
variable "project_name" {
  description = "The name of the project, used as a prefix for resources."
  type        = string
  default     = ""
}
variable "customer_name" {
  description = "The name of the customer, used as a prefix for resources."
  type        = string
  default     = ""
}
variable "project_region" {
  description = "The region for the project resources."
  type        = string
  default     = ""
}
variable "project_env" {
  description = "The environment for the project (e.g., dev, prd)."
  type        = string
  default     = ""
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
variable "resource_group" {
  description = "The name of the resource group to create. If an existing resource group ID is provided, this will be ignored."
  type        = any
  default     = null
}

#----------------------------------------------
# Virtual Network Variables
#----------------------------------------------
variable "enabled" {
  description = "Enable the creation of the DDoS Protection Plan."
  type        = bool
  default     = false
}

variable "name" {
  description = ""
  type        = string
  default     = ""
}
variable "resource_group_name" {
  description = ""
  type        = string
  default     = ""
}
variable "location" {
  description = ""
  type        = string
  default     = ""
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
  default     = ""
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
variable "tags" {
  description = "A map of tags to apply to the DDoS Protection Plan."
  type        = map(string)
  default     = {}
}



