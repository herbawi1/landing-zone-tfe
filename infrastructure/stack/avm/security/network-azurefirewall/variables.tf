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
# Azure Firewall Variables { Inputs }
#----------------------------------------------
variable "enabled" {
  type        = bool
  default     = true
  description = "Specifies whether to create the Azure Bastion Host resources."
}
variable "name" {
  description = "(Required) Specifies the name of the Firewall. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "resource_group_name" {
  type        = string
  default     = null
  description = "(Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created."
}

variable "firewall_sku_name" {
  description = "(Required) SKU name of the Firewall. Possible values are `AZFW_Hub` and `AZFW_VNet`. Changing this forces a new resource to be created."
  type        = string
  default     = "AZFW_VNet"
}

variable "firewall_sku_tier" {
  description = "(Required) SKU tier of the Firewall. Possible values are `Premium`, `Standard` and `Basic`."
  type        = string
  default     = "Standard"
}

variable "firewall_policy_id" {
  description = "(Optional) The ID of the Firewall Policy applied to this Firewall."
  type        = string
  default     = null
}

variable "firewall_private_ip_ranges" {
  description = "(Optional) A list of SNAT private CIDR IP ranges, or the special string `IANAPrivateRanges`, which indicates Azure Firewall does not SNAT when the destination IP address is a private range per IANA RFC 1918."
  type        = set(string)
  default     = null
}

variable "firewall_zones" {
  description = "(Required) Specifies a list of Availability Zones in which this Azure Firewall should be located. Changing this forces a new Azure Firewall to be created."
  type        = set(string)
  default     = ["1", "2", "3"]
}

variable "diagnostic_settings" {
  description = "A map of diagnostic settings to create on the Firewall. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time."
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
  default = {}
}

variable "firewall_ip_configuration" {
  description = "[DEPRECATED] Use `ip_configurations` instead. This variable is deprecated and will be removed in a future version."
  type = list(object({
    name                 = string
    public_ip_address_id = optional(string)
    subnet_id            = optional(string)
  }))
  default = null
}

variable "firewall_management_ip_configuration" {
  description = "Management IP configuration for the firewall."
  type = object({
    name                 = string
    public_ip_address_id = string
    subnet_id            = string
  })
  default = null
}

variable "firewall_virtual_hub" {
  description = "Virtual hub configuration for the firewall."
  type = object({
    public_ip_count = optional(number)
    virtual_hub_id  = string
  })
  default = null
}

variable "ip_configurations" {
  description = "This variable defines the IP configurations for the Azure Firewall. It is a map where each key is a unique identifier for the configuration."
  type = map(object({
    name                 = string
    public_ip_address_id = optional(string)
    subnet_id            = optional(string)
  }))
  default = null
}

variable "firewall_timeouts" {
  description = "Timeouts for firewall operations."
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default = null
}

variable "lock" {
  description = "Controls the Resource Lock configuration for this resource."
  type = object({
    kind = string
    name = optional(string, null)
  })
  default = null
}

variable "role_assignments" {
  description = "A map of role assignments to create on the Firewall."
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

variable "num_fw_public_ips" {
  type = number
  default = 1
  description = "The number of public IP addresses to create for the firewall."
}