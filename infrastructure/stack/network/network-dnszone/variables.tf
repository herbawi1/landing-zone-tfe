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
# Location override (optional)
#----------------------------------------------
variable "location" {
    description = "(Optional) The Azure Region where the Firewall Policy should exist. Changing this forces a new Firewall Policy to be created. If not specified, will use the resource group's location."
    type        = string
    default     = null
}



variable "name" {
    type        = string
    description = "The name of the this resource."
    nullable    = false
}

variable "resource_group_name" {
    type        = string
    description = "The resource group where the resources will be deployed."
    default = ""
}

variable "a_records" {
    type = map(object({
        name                = string
        resource_group_name = string
        zone_name           = string
        ttl                 = number
        records             = optional(list(string))
        target_resource_id  = optional(string)
        tags                = optional(map(string), null)
    }))
    default     = {}
    description = "A map of objects where each object contains information to create a A record."
}

variable "aaaa_records" {
    type = map(object({
        name                = string
        resource_group_name = string
        zone_name           = string
        ttl                 = number
        records             = optional(list(string))
        target_resource_id  = optional(string)
        tags                = optional(map(string), null)
    }))
    default     = {}
    description = "A map of objects where each object contains information to create a AAAA record."
}

variable "caa_records" {
    type = map(object({
        name                = string
        resource_group_name = string
        zone_name           = string
        ttl                 = number
        record = map(object({
            flags = string
            tag   = string
            value = string
        }))
        tags = optional(map(string), null)
    }))
    default     = {}
    description = "A map of objects where each object contains information to create a CAA record."
}

variable "cname_records" {
    type = map(object({
        name                = string
        resource_group_name = string
        zone_name           = string
        ttl                 = number
        record              = string
        tags                = optional(map(string), null)
        target_resource_id  = optional(string)
    }))
    default     = {}
    description = "A map of objects where each object contains information to create a CNAME record."
}

variable "mx_records" {
    type = map(object({
        name                = optional(string, "@")
        resource_group_name = string
        zone_name           = string
        ttl                 = number
        records = map(object({
            preference = number
            exchange   = string
        }))
        tags = optional(map(string), null)
    }))
    default     = {}
    description = "A map of objects where each object contains information to create a MX record."
}

variable "ns_records" {
    type = map(object({
        name                = string
        resource_group_name = string
        zone_name           = string
        ttl                 = number
        records             = list(string)
        tags                = optional(map(string), null)
    }))
    default     = {}
    description = "A map of objects where each object contains information to create a NS record."
}

variable "ptr_records" {
    type = map(object({
        name                = string
        resource_group_name = string
        zone_name           = string
        ttl                 = number
        records             = list(string)
        tags                = optional(map(string), null)
    }))
    default     = {}
    description = "A map of objects where each object contains information to create a PTR record."
}

variable "srv_records" {
    type = map(object({
        name                = string
        resource_group_name = string
        zone_name           = string
        ttl                 = number
        records = map(object({
            priority = number
            weight   = number
            port     = number
            target   = string
        }))
        tags = optional(map(string), null)
    }))
    default     = {}
    description = "A map of objects where each object contains information to create a SRV record."
}

variable "tags" {
    type        = map(string)
    default     = null
    description = "(Optional) Tags of the resource."
}

variable "txt_records" {
    type = map(object({
        name                = string
        resource_group_name = string
        zone_name           = string
        ttl                 = number
        records = map(object({
            value = string
        }))
        tags = optional(map(string), null)
    }))
    default     = {}
    description = "A map of objects where each object contains information to create a TXT record."
}
