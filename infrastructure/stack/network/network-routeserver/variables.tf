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
# Azure Route Server Variables
#----------------------------------------------
variable "enabled" {
  type        = bool
  description = "(Optional) Specifies whether the Route Server is enabled."
  default     = true
}

variable "name" {
  type        = string
  description = "(Required) The name which should be used for this Route Server. Changing this forces a new Route Server to be created."
  default     = null
}
variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the Route Server should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "route_server_subnet_resource_id" {
  type        = string
  description = "The Azure resource ID for the route server subnet where this route server will be deployed."
  default     = null
}

variable "bgp_connections" {
  description = "A map of BGP connections to make on each route server."
  type = map(object({
    name     = string
    peer_asn = string
    peer_ip  = string
  }))
  default = {}
}

variable "enable_branch_to_branch" {
  type        = bool
  description = "Should the branch to branch feature be enabled. Defaults to false."
  default     = false
}

variable "hub_routing_preference" {
  type        = string
  description = "The routing preference for this route server. Valid values are 'ASPath', 'ExpressRoute', or 'VpnGateway'. Defaults to 'ExpressRoute'."
  default     = "ExpressRoute"

  validation {
    condition     = contains(["ASPath", "ExpressRoute", "VpnGateway"], var.hub_routing_preference)
    error_message = "Valid values are 'ASPath', 'ExpressRoute', or 'VpnGateway'."
  }
}

variable "private_ip_address" {
  type        = string
  description = "The private IP address to use for the route server IP configuration if private_ip_allocation_method is set to 'Static'."
  default     = null
}

variable "private_ip_allocation_method" {
  type        = string
  description = "The private IP Address allocation method. Valid values are 'Static' or 'Dynamic'. Defaults to 'Dynamic'."
  default     = "Dynamic"

  validation {
    condition     = contains(["Static", "Dynamic"], var.private_ip_allocation_method)
    error_message = "Valid values are 'Static' or 'Dynamic'."
  }
}

variable "routeserver_public_ip_config" {
  description = "Configuration for the Route Server's public IP."
  type = object({
    allocation_method                = optional(string, "Static")
    ddos_protection_mode             = optional(string, "VirtualNetworkInherited")
    ddos_protection_plan_resource_id = optional(string, null)
    idle_timeout_in_minutes          = optional(number, 4)
    ip_tags                          = optional(map(string), {})
    ip_version                       = optional(string, "IPv4")
    name                             = optional(string, null)
    public_ip_prefix_resource_id     = optional(string, null)
    sku                              = optional(string, "Standard")
    sku_tier                         = optional(string, "Regional")
    zones                            = optional(list(string), ["1", "2", "3"])
  })
  default = {
    allocation_method = "Static"
    ip_version        = "IPv4"
    sku               = "Standard"
    sku_tier          = "Regional"
    zones             = ["1", "2", "3"]
  }
}

variable "role_assignments" {
  description = "A map of role assignments to create on the route server."
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
