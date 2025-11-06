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
# Location override (optional)
#----------------------------------------------
variable "location" {
  description = "(Optional) The Azure Region where the Firewall Policy should exist. Changing this forces a new Firewall Policy to be created. If not specified, will use the resource group's location."
  type        = string
  default     = null
}
#----------------------------------------------
# Private DNS Zone Configuration Variables
#----------------------------------------------

# Domain Name
variable "domain_name" {
  description = "(Optional) The name of the private dns zone. If not specified, will use a default pattern."
  type        = string
  default     = null
}
variable "enabled" {
  type        = bool
  default     = false
  description = "Specifies whether to create the Azure Bastion Host resources."
}
variable "parent_id" {
  type        = string
  description = "The ID of the parent resource. This is typically the ID of the resource group or a virtual network where the DNS zone will be created."
  default     = ""
}

# DNS Records
variable "a_records" {
  description = "(Optional) A map of objects where each object contains information to create a A record."
  type = map(object({
    name         = string
    ttl          = number
    records      = optional(list(string))
    ip_addresses = optional(set(string), null)
  }))
  default = {}
}

variable "aaaa_records" {
  description = "(Optional) A map of objects where each object contains information to create a AAAA record."
  type = map(object({
    name         = string
    ttl          = number
    records      = optional(list(string))
    ip_addresses = optional(set(string), null)
  }))
  default = {}
}

variable "cname_records" {
  description = "(Optional) A map of objects where each object contains information to create a CNAME record."
  type = map(object({
    name   = string
    ttl    = number
    record = optional(string, null)
    cname  = optional(string, null)
  }))
  default = {}
}

variable "mx_records" {
  description = "(Optional) A map of objects where each object contains information to create a MX record."
  type = map(object({
    name = optional(string, "@")
    ttl  = number
    records = map(object({
      preference = number
      exchange   = string
    }))
  }))
  default = {}
}

variable "ptr_records" {
  description = "(Optional) A map of objects where each object contains information to create a PTR record."
  type = map(object({
    name         = string
    ttl          = number
    records      = optional(list(string), null)
    domain_names = optional(set(string), null)
  }))
  default = {}
}

variable "soa_record" {
  description = "(Optional) Optional soa_record variable, if included only email is required, rest are optional. Email must use username.corp.com and not username@corp.com"
  type = object({
    email        = string
    name         = optional(string, "@")
    expire_time  = optional(number, 2419200)
    minimum_ttl  = optional(number, 10)
    refresh_time = optional(number, 3600)
    retry_time   = optional(number, 300)
    ttl          = optional(number, 3600)
  })
  default = null
}

variable "srv_records" {
  description = "(Optional) A map of objects where each object contains information to create a SRV record."
  type = map(object({
    name = string
    ttl  = number
    records = map(object({
      priority = number
      weight   = number
      port     = number
      target   = string
    }))
  }))
  default = {}
}

variable "txt_records" {
  description = "(Optional) A map of objects where each object contains information to create a TXT record."
  type = map(object({
    name = string
    ttl  = number
    records = map(object({
      value = list(string)
    }))
  }))
  default = {}
}

# Virtual Network Links
variable "virtual_network_links" {
  description = "(Optional) A map of objects where each object contains information to create a virtual network link. Either 'name' or 'vnetlinkname' must be provided, and either 'virtual_network_id' or 'vnetid' must be provided."
  type = map(object({
    vnetlinkname                           = optional(string, null)
    name                                   = optional(string, null)
    vnetid                                 = optional(string, null)
    virtual_network_id                     = optional(string, null)
    autoregistration                       = optional(bool, false)
    private_dns_zone_supports_private_link = optional(bool, false)
    registration_enabled                   = optional(bool, null)
    resolution_policy                      = optional(string, "Default")
    tags                                   = optional(map(string), null)
  }))
  default = {}
}

# Management
variable "role_assignments" {
  description = "(Optional) A map of role assignments to create on the private DNS zone. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time."
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

# Timeouts
variable "timeouts" {
  description = "(Optional) A map of timeouts objects, per resource type, to apply to the creation and destruction of resources the following resources: DNS Zones, Virtual Network Links."
  type = object({
    dns_zones = optional(object({
      create = optional(string, "30m")
      delete = optional(string, "30m")
      update = optional(string, "30m")
      read   = optional(string, "5m")
      }), {}
    )
    vnet_links = optional(object({
      create = optional(string, "30m")
      delete = optional(string, "30m")
      update = optional(string, "30m")
      read   = optional(string, "5m")
      }), {}
    )
  })
  default = {}
}

# Retry Configuration
variable "retry" {
  description = "(Optional) Retry configuration for the resource operations"
  type = object({
    error_message_regex  = optional(list(string), ["ReferencedResourceNotProvisioned", "CannotDeleteResource"])
    interval_seconds     = optional(number, 10)
    max_interval_seconds = optional(number, 180)
    multiplier           = optional(number, 1.5)
    randomization_factor = optional(number, 0.5)
  })
  default = {}
}

# Tags
variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = null
}
