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

variable "resource_group_name" {
  description = "(Optional) The name of the Resource Group where the Firewall Policy should exist. Changing this forces a new Firewall Policy to be created. If not specified, will use the resource group object's name."
  type        = string
  default     = null
}

#----------------------------------------------
variable "enabled" {
  type        = bool
  default     = true
  description = "Specifies whether to create the Azure Bastion Host resources."
}
variable "firewall_policy_rule_collection_group_firewall_policy_id" {
  type        = string
  description = "(Required) The ID of the Firewall Policy where the Firewall Policy Rule Collection Group should exist. Changing this forces a new Firewall Policy Rule Collection Group to be created."
  default     = null
}

variable "firewall_policy_rule_collection_group_name" {
  type        = string
  description = "(Required) The name which should be used for this Firewall Policy Rule Collection Group. Changing this forces a new Firewall Policy Rule Collection Group to be created."
  default     = null
}

variable "firewall_policy_rule_collection_group_priority" {
  type        = number
  description = "(Required) The priority of the Firewall Policy Rule Collection Group. The range is 100-65000."
  default     = 400
}

variable "firewall_policy_rule_collection_group_application_rule_collection" {
  type = list(object({
    action   = string
    name     = string
    priority = number
    rule = list(object({
      description           = optional(string)
      destination_addresses = optional(list(string), [])
      destination_fqdn_tags = optional(list(string), [])
      destination_fqdns     = optional(list(string), [])
      destination_urls      = optional(list(string), [])
      name                  = string
      source_addresses      = optional(list(string), [])
      source_ip_groups      = optional(list(string), [])
      terminate_tls         = optional(bool)
      web_categories        = optional(list(string), [])
      http_headers = optional(list(object({
        name  = string
        value = string
      })))
      protocols = optional(list(object({
        port = number
        type = string
      })))
    }))
  }))
  default     = null
  description = <<-EOT
- `action` - (Required) The action to take for the application rules in this collection. Possible values are `Allow` and `Deny`.
- `name` - (Required) The name which should be used for this application rule collection.
- `priority` - (Required) The priority of the application rule collection. The range is `100`

---
`rule` block supports the following:
- `description` -
- `destination_addresses` -
- `destination_fqdn_tags` -
- `destination_fqdns` -
- `destination_urls` -
- `name` - (Required) The name which should be used for this Firewall Policy Rule Collection Group. Changing this forces a new Firewall Policy Rule Collection Group to be created.
- `source_addresses` -
- `source_ip_groups` -
- `terminate_tls` -
- `web_categories` -

---
`http_headers` block supports the following:
- `name` - (Required) Specifies the name of the header.
- `value` - (Required) Specifies the value of the value.

---
`protocols` block supports the following:
- `port` - (Required) Port number of the protocol. Range is 0-64000.
- `type` - (Required) Protocol type. Possible values are `Http` and `Https`.
EOT
}

variable "firewall_policy_rule_collection_group_nat_rule_collection" {
  type = list(object({
    action   = string
    name     = string
    priority = number
    rule = list(object({
      description         = optional(string)
      destination_address = optional(string)
      destination_ports   = optional(list(string), [])
      name                = string
      protocols           = list(string)
      source_addresses    = optional(list(string), [])
      source_ip_groups    = optional(list(string), [])
      translated_address  = optional(string)
      translated_fqdn     = optional(string)
      translated_port     = number
    }))
  }))
  default     = null
  description = <<-EOT
- `action` - (Required) The action to take for the NAT rules in this collection. Currently, the only possible value is `Dnat`.
- `name` - (Required) The name which should be used for this NAT rule collection.
- `priority` - (Required) The priority of the NAT rule collection. The range is `100`

---
`rule` block supports the following:
- `description` -
- `destination_address` -
- `destination_ports` -
- `name` - (Required) The name which should be used for this Firewall Policy Rule Collection Group. Changing this forces a new Firewall Policy Rule Collection Group to be created.
- `protocols` -
- `source_addresses` -
- `source_ip_groups` -
- `translated_address` -
- `translated_fqdn` -
- `translated_port` -
EOT
}

variable "firewall_policy_rule_collection_group_network_rule_collection" {
  type = list(object({
    action   = string
    name     = string
    priority = number
    rule = list(object({
      description           = optional(string)
      destination_addresses = optional(list(string), [])
      destination_fqdns     = optional(list(string), [])
      destination_ip_groups = optional(list(string), [])
      destination_ports     = list(string)
      name                  = string
      protocols             = list(string)
      source_addresses      = optional(list(string), [])
      source_ip_groups      = optional(list(string), [])
    }))
  }))
  default     = null
  description = <<-EOT
- `action` - (Required) The action to take for the network rules in this collection. Possible values are `Allow` and `Deny`.
- `name` - (Required) The name which should be used for this network rule collection.
- `priority` - (Required) The priority of the network rule collection. The range is `100`

---
`rule` block supports the following:
- `description` -
- `destination_addresses` -
- `destination_fqdns` -
- `destination_ip_groups` -
- `destination_ports` -
- `name` - (Required) The name which should be used for this Firewall Policy Rule Collection Group. Changing this forces a new Firewall Policy Rule Collection Group to be created.
- `protocols` -
- `source_addresses` -
- `source_ip_groups` -
EOT
}

variable "firewall_policy_rule_collection_group_timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default     = null
  description = <<-EOT
 - `create` - (Defaults to 30 minutes) Used when creating the Firewall Policy Rule Collection Group.
 - `delete` - (Defaults to 30 minutes) Used when deleting the Firewall Policy Rule Collection Group.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Firewall Policy Rule Collection Group.
 - `update` - (Defaults to 30 minutes) Used when updating the Firewall Policy Rule Collection Group.
EOT
}
