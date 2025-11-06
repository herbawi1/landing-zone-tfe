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

#----------------------------------------------
# Azure Resource Group Variables  { Inputs }
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
# Location override (optional)
#----------------------------------------------
variable "location" {
    description = "Azure region where the resource should be deployed."
    type        = string
  default = null
}

variable "name" {
    description = "The name of the dns resolver."
    type        = string
    default = null
}

variable "resource_group_name" {
    description = "The resource group where the resources will be deployed."
    type        = string
    default = null
}

variable "virtual_network_resource_id" {
    description = "The ID of the virtual network to deploy the inbound and outbound endpoints into. The vnet should have appropriate subnets for the endpoints. For more information on how to configure subnets for inbound and outbound endpoints, see the modules readme."
    type        = string
    default = null
}
variable "enabled" {
    description = "A boolean to enable or disable the deployment of the module."
    type        = bool
    default     = false
}

variable "enable_telemetry" {
  description = "This variable controls whether or not telemetry is enabled for the module. For more information see https://aka.ms/avm/telemetryinfo. If it is set to false, then no telemetry will be collected."
  type        = bool
  default     = false
}

variable "inbound_endpoints" {
  description = "A map of inbound endpoints to create for this DNS resolver."
  type = map(object({
    name                         = optional(string)
    subnet_name                  = string
    private_ip_allocation_method = optional(string, "Dynamic")
    private_ip_address           = optional(string, null)
    tags                         = optional(map(string), null)
    merge_with_module_tags       = optional(bool, true)
  }))
  default = {}
}

variable "lock" {
  description = "Controls the Resource Lock configuration for this resource."
  type = object({
    kind = string
    name = optional(string, null)
  })
  default = null
}

variable "outbound_endpoints" {
  description = "A map of outbound endpoints to create for this DNS resolver."
  type = map(object({
    name                   = optional(string)
    tags                   = optional(map(string), null)
    merge_with_module_tags = optional(bool, true)
    subnet_name            = string
    forwarding_ruleset = optional(map(object({
      name                                                = optional(string)
      link_with_outbound_endpoint_virtual_network         = optional(bool, true)
      metadata_for_outbound_endpoint_virtual_network_link = optional(map(string), null)
      tags                                                = optional(map(string), null)
      merge_with_module_tags                              = optional(bool, true)
      additional_outbound_endpoint_link = optional(object({
        outbound_endpoint_key = optional(string)
      }), null)
      additional_virtual_network_links = optional(map(object({
        name     = optional(string)
        vnet_id  = string
        metadata = optional(map(string), null)
      })), {})
      rules = optional(map(object({
        name                     = optional(string)
        domain_name              = string
        destination_ip_addresses = map(string)
        enabled                  = optional(bool, true)
        metadata                 = optional(map(string), null)
      })))
    })))
  }))
  default = {}
}

variable "role_assignments" {
  description = "A map of role assignments to create on the resource."
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
    description = "(Optional) Tags of the resource."
    type        = map(string)
    default     = null
}
