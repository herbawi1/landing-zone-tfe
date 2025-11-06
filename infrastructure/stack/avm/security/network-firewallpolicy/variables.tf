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
# Location override
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
# Firewall Policy Configuration Variables
#----------------------------------------------

variable "name" {
  type        = string
  description = "(Required) The name which should be used for this Firewall Policy. Changing this forces a new Firewall Policy to be created."
  default     = null
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Specifies whether to create the Azure Bastion Host resources."
}

# Firewall Policy - Auto Learn Private Ranges
variable "firewall_policy_auto_learn_private_ranges_enabled" {
  description = "(Optional) Whether enable auto learn private ip range."
  type        = bool
  default     = null
}

# Firewall Policy - Base Policy ID
variable "firewall_policy_base_policy_id" {
  description = "(Optional) The ID of the base Firewall Policy."
  type        = string
  default     = null
}

# Firewall Policy - DNS Settings
variable "firewall_policy_dns" {
  description = "DNS settings for the Firewall Policy."
  type = object({
    proxy_enabled = optional(bool)
    servers       = optional(list(string))
  })
  default = null
}

# Firewall Policy - Explicit Proxy
variable "firewall_policy_explicit_proxy" {
  description = "Explicit proxy settings for the Firewall Policy."
  type = object({
    enable_pac_file = optional(bool)
    enabled         = optional(bool)
    http_port       = optional(number)
    https_port      = optional(number)
    pac_file        = optional(string)
    pac_file_port   = optional(number)
  })
  default = null
}

# Firewall Policy - Identity
variable "firewall_policy_identity" {
  description = "Identity configuration for the Firewall Policy."
  type = object({
    identity_ids = optional(set(string))
    type         = string
  })
  default = null
}

# Firewall Policy - Insights
variable "firewall_policy_insights" {
  description = "Insights configuration for the Firewall Policy."
  type = object({
    default_log_analytics_workspace_id = string
    enabled                            = bool
    retention_in_days                  = optional(number)
    log_analytics_workspace = optional(list(object({
      firewall_location = string
      id                = string
    })))
  })
  default = null
}

# Firewall Policy - Intrusion Detection
variable "firewall_policy_intrusion_detection" {
  description = "Intrusion detection configuration for the Firewall Policy."
  type = object({
    mode           = optional(string)
    private_ranges = optional(list(string))
    signature_overrides = optional(list(object({
      id    = optional(string)
      state = optional(string)
    })))
    traffic_bypass = optional(list(object({
      description           = optional(string)
      destination_addresses = optional(set(string))
      destination_ip_groups = optional(set(string))
      destination_ports     = optional(set(string))
      name                  = string
      protocol              = string
      source_addresses      = optional(set(string))
      source_ip_groups      = optional(set(string))
    })))
  })
  default = null
}

# Firewall Policy - Private IP Ranges
variable "firewall_policy_private_ip_ranges" {
  description = "(Optional) A list of private IP ranges to which traffic will not be SNAT."
  type        = list(string)
  default     = null
}

# Firewall Policy - SKU
variable "firewall_policy_sku" {
  description = "(Optional) The SKU Tier of the Firewall Policy. Possible values are Standard, Premium and Basic. Changing this forces a new Firewall Policy to be created."
  type        = string
  default     = "Standard"
}

# Firewall Policy - SQL Redirect Allowed
variable "firewall_policy_sql_redirect_allowed" {
  description = "(Optional) Whether SQL Redirect traffic filtering is allowed. Enabling this flag requires no rule using ports between 11000-11999."
  type        = bool
  default     = null
}

# Firewall Policy - Threat Intelligence Allowlist
variable "firewall_policy_threat_intelligence_allowlist" {
  description = "Threat intelligence allowlist for the Firewall Policy."
  type = object({
    fqdns        = optional(set(string))
    ip_addresses = optional(set(string))
  })
  default = null
}

# Firewall Policy - Threat Intelligence Mode
variable "firewall_policy_threat_intelligence_mode" {
  description = "(Optional) The operation mode for Threat Intelligence. Possible values are Alert, Deny and Off. Defaults to Alert."
  type        = string
  default     = "Alert"
}

# Firewall Policy - Timeouts
variable "firewall_policy_timeouts" {
  description = "Timeout configuration for the Firewall Policy."
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default = null
}

# Firewall Policy - TLS Certificate
variable "firewall_policy_tls_certificate" {
  description = "TLS certificate configuration for the Firewall Policy."
  type = object({
    key_vault_secret_id = string
    name                = string
  })
  default = null
}

# Lock Configuration
variable "lock" {
  description = "Controls the Resource Lock configuration for this resource."
  type = object({
    kind = string
    name = optional(string, null)
  })
  default = null
}

# Role Assignments
variable "role_assignments" {
  description = "A map of role assignments to create on the Firewall Policy."
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

# Tags
variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = null
}
# Diagnostic Settings
variable "diagnostic_settings" {
  description = "A map of diagnostic settings to create on the Firewall Policy. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time."
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