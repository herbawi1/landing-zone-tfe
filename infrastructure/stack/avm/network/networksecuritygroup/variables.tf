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
  description = "Tags to apply to the network security group and related resources. Module-specific tags will be added automatically."
  type        = map(string)
  default     = {}
}
variable "enable_telemetry" {
  description = "Enable telemetry for the module. This sends anonymous data to Microsoft to help improve the module over time."
  type        = bool
  default     = true
}

#----------------------------------------------
# Azure Resource Group Variables { Inputs }
#----------------------------------------------
variable "resource_group" {
  description = "resource group object"
  type        = any
  default     = null
}

#----------------------------------------------
# Azure virtual network variables { Inputs }
#----------------------------------------------
variable "virtual_network" {
  description = "The virtual network resource object"
  type        = any
  default     = null
}

#----------------------------------------------
# Azure Network Security Group Variables
#----------------------------------------------
variable "location" {
  type        = string
  description = "The location of the network security group and related resources. Defaults to resource group location."
  default     = null
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created."
  default     = null
}

variable "name" {
  type        = string
  description = "The name of the network security group. If not provided, will auto-generate based on naming convention."
  default     = null
}

variable "security_rules" {
  description = "A map of security rules to create in the network security group."
  type = map(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = optional(string)
    source_port_ranges           = optional(list(string))
    destination_port_range       = optional(string)
    destination_port_ranges      = optional(list(string))
    source_address_prefix        = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefix   = optional(string)
    destination_address_prefixes = optional(list(string))
    description                  = optional(string)
  }))
  default = {}
}

variable "diagnostic_settings" {
  type = map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
  description = "(Optional) Object representing diagnostic settings sink for the network security group."
  default     = {}
}

variable "lock" {
  type = object({
    kind = string
    name = optional(string, null)
  })
  description = "Controls the Resource Lock configuration for this resource. The following properties can be specified: kind (Required): The type of lock. Possible values are 'CanNotDelete' and 'ReadOnly'. name (Optional): The name of the lock. If not specified, a name will be generated based on the kind value."
  default     = null
}

variable "role_assignments" {
  description = "A map of role assignments to create on the network security group."
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
  type        = map(string)
  default     = null
  description = "(Optional) Tags of the resource."
}
