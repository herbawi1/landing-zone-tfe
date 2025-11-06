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
# Azure Resource Group Variables  { Inputs }
#----------------------------------------------
variable "resource_group" {
  description = "The name of the resource group to create. If an existing resource group ID is provided, this will be ignored."
  type        = any
  default     = null
}

#----------------------------------------------
# Virtual Network Variables
#----------------------------------------------
variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets_json" {
  default     = null
  type        = any
  description = "subnets configuration in JSON format."
}

variable "parent_id" {
  description = "The parent resource ID for the virtual network address."
  type        = string
  default     = null
}
variable "location" {
  description = "The location for the virtual network address."
  type        = string
  default     = null
}

variable "name" {
  type        = string
  default     = null
  description = <<DESCRIPTION
(Optional) The name of the virtual network to create.  If null, existing_virtual_network must be supplied.
DESCRIPTION
}

variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default     = null
  description = <<DESCRIPTION
Specifies an AzureNetwork DDoS Protection Plan.

- `id`: The ID of the DDoS Protection Plan. (Required)
- `enable`: Enables or disables the DDoS Protection Plan on the Virtual Network. (Required)
DESCRIPTION
}
variable "ddos_protection_plan_id" {
  description = "The ID of the DDoS protection plan to associate with the virtual network."
  default     = ""
  type        = string
}


variable "bgp_community" {
  type        = string
  default     = null
  description = <<DESCRIPTION
(Optional) The BGP community to send to the virtual network gateway.
DESCRIPTION
}

# HERE
variable "dns_servers" {
  type        = any
  default     = null
  description = <<DESCRIPTION
(Optional) Specifies a list of IP addresses representing DNS servers.

- `dns_servers`: Can be a single string or a set/list of strings.
DESCRIPTION
}
# HERE
variable "dns_servers_list" {
  type        = list(string)
  default     = null
  description = <<DESCRIPTION
(Optional) A list of IP addresses representing DNS servers.
DESCRIPTION
}




variable "encryption" {
  type = object({
    enabled     = bool
    enforcement = string
  })
  default     = null
  description = <<DESCRIPTION
(Optional) Specifies the encryption settings for the virtual network.

- `enabled`: Specifies whether encryption is enabled for the virtual network.
- `enforcement`: Specifies the enforcement mode for the virtual network. Possible values are `AllowUnencrypted` and `DropUnencrypted`.

Note: When using `DropUnencrypted` enforcement, the `AllowDropUnecryptedVnet` subscription feature must be registered first. See the `vnet-encryption-setup` example for details.
DESCRIPTION
}

variable "extended_location" {
  type = object({
    name = string
    type = string
  })
  default     = null
  description = <<DESCRIPTION
(Optional) Specifies the extended location of the virtual network.

- `name`: The name of the extended location.
- `type`: The type of the extended location.
DESCRIPTION
}

variable "timeouts" {
  type = object({
    create = optional(string, "30m")
    read   = optional(string, "5m")
    update = optional(string, "30m")
    delete = optional(string, "30m")
  })
  default     = {}
  description = "Timeouts for the resource operations"
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
  default     = null
  description = <<DESCRIPTION
  A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

  - `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
  - `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
  - `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
  - `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
  - `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
  - `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
  - `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
  - `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
  - `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
  - `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.
  DESCRIPTION
}
variable "flow_timeout_in_minutes" {
  type        = number
  default     = null
  description = <<DESCRIPTION
(Optional) The flow timeout in minutes for the virtual network. Defaults to 4.
DESCRIPTION
}
variable "peerings" {
  type = map(object({
    name                               = string
    remote_virtual_network_resource_id = string
    allow_forwarded_traffic            = optional(bool, false)
    allow_gateway_transit              = optional(bool, false)
    allow_virtual_network_access       = optional(bool, true)
    do_not_verify_remote_gateways      = optional(bool, false)
    enable_only_ipv6_peering           = optional(bool, false)
    peer_complete_vnets                = optional(bool, true)
    local_peered_address_spaces = optional(list(object({
      address_prefix = string
    })))
    remote_peered_address_spaces = optional(list(object({
      address_prefix = string
    })))
    local_peered_subnets = optional(list(object({
      subnet_name = string
    })))
    remote_peered_subnets = optional(list(object({
      subnet_name = string
    })))
    use_remote_gateways                   = optional(bool, false)
    create_reverse_peering                = optional(bool, false)
    reverse_name                          = optional(string)
    reverse_allow_forwarded_traffic       = optional(bool, false)
    reverse_allow_gateway_transit         = optional(bool, false)
    reverse_allow_virtual_network_access  = optional(bool, true)
    reverse_do_not_verify_remote_gateways = optional(bool, false)
    reverse_enable_only_ipv6_peering      = optional(bool, false)
    reverse_peer_complete_vnets           = optional(bool, true)
    reverse_local_peered_address_spaces = optional(list(object({
      address_prefix = string
    })))
    reverse_remote_peered_address_spaces = optional(list(object({
      address_prefix = string
    })))
    reverse_local_peered_subnets = optional(list(object({
      subnet_name = string
    })))
    reverse_remote_peered_subnets = optional(list(object({
      subnet_name = string
    })))
    reverse_use_remote_gateways = optional(bool, false)
    timeouts = optional(object({
      create = optional(string, "30m")
      read   = optional(string, "5m")
      update = optional(string, "30m")
      delete = optional(string, "30m")
    }), {})
    retry = optional(object({
      error_message_regex  = optional(list(string), ["ReferencedResourceNotProvisioned"])
      interval_seconds     = optional(number, 10)
      max_interval_seconds = optional(number, 180)
    }), {})
  }))
  default     = null
  description = <<DESCRIPTION
(Optional) A map of virtual network peering configurations. Each entry specifies a remote virtual network by ID and includes settings for traffic forwarding, gateway transit, and remote gateways usage.

- `name`: The name of the virtual network peering configuration.
- `remote_virtual_network_resource_id`: The resource ID of the remote virtual network.
- `allow_forwarded_traffic`: (Optional) Enables forwarded traffic between the virtual networks. Defaults to false.
- `allow_gateway_transit`: (Optional) Enables gateway transit for the virtual networks. Defaults to false.
- `allow_virtual_network_access`: (Optional) Enables access from the local virtual network to the remote virtual network. Defaults to true.
- `do_not_verify_remote_gateways`: (Optional) Disables the verification of remote gateways for the virtual networks. Defaults to false.
- `enable_only_ipv6_peering`: (Optional) Enables only IPv6 peering for the virtual networks. Defaults to false.
- `peer_complete_vnets`: (Optional) Enables the peering of complete virtual networks for the virtual networks. Defaults to false.
- `local_peered_address_spaces`: (Optional) The address spaces to peer with the remote virtual network. Only used when `peer_complete_vnets` is set to true.
- `remote_peered_address_spaces`: (Optional) The address spaces to peer from the remote virtual network. Only used when `peer_complete_vnets` is set to true.
- `local_peered_subnets`: (Optional) The subnets to peer with the remote virtual network. Only used when `peer_complete_vnets` is set to true.
- `remote_peered_subnets`: (Optional) The subnets to peer from the remote virtual network. Only used when `peer_complete_vnets` is set to true.
- `use_remote_gateways`: (Optional) Enables the use of remote gateways for the virtual networks. Defaults to false.
- `create_reverse_peering`: (Optional) Creates the reverse peering to form a complete peering.
- `reverse_name`: (Optional) If you have selected `create_reverse_peering`, then this name will be used for the reverse peer.
- `reverse_allow_forwarded_traffic`: (Optional) If you have selected `create_reverse_peering`, enables forwarded traffic between the virtual networks. Defaults to false.
- `reverse_allow_gateway_transit`: (Optional) If you have selected `create_reverse_peering`, enables gateway transit for the virtual networks. Defaults to false.
- `reverse_allow_virtual_network_access`: (Optional) If you have selected `create_reverse_peering`, enables access from the local virtual network to the remote virtual network. Defaults to true.
- `reverse_do_not_verify_remote_gateways`: (Optional) If you have selected `create_reverse_peering`, disables the verification of remote gateways for the virtual networks. Defaults to false.
- `reverse_enable_only_ipv6_peering`: (Optional) If you have selected `create_reverse_peering`, enables only IPv6 peering for the virtual networks. Defaults to false.
- `reverse_peer_complete_vnets`: (Optional) If you have selected `create_reverse_peering`, enables the peering of complete virtual networks for the virtual networks. Defaults to false.
- `reverse_local_peered_address_spaces`: (Optional) If you have selected `create_reverse_peering`, the address spaces to peer with the remote virtual network. Only used when `reverse_peer_complete_vnets` is set to true.
- `reverse_remote_peered_address_spaces`: (Optional) If you have selected `create_reverse_peering`, the address spaces to peer from the remote virtual network. Only used when `reverse_peer_complete_vnets` is set to true.
- `reverse_local_peered_subnets`: (Optional) If you have selected `create_reverse_peering`, the subnets to peer with the remote virtual network. Only used when `reverse_peer_complete_vnets` is set to true.
- `reverse_remote_peered_subnets`: (Optional) If you have selected `create_reverse_peering`, the subnets to peer from the remote virtual network. Only used when `reverse_peer_complete_vnets` is set to true.
- `reverse_use_remote_gateways`: (Optional) If you have selected `create_reverse_peering`, enables the use of remote gateways for the virtual networks. Defaults to false.

 ---
 `timeouts` (Optional) supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the Subnet.
 - `delete` - (Defaults to 30 minutes) Used when deleting the Subnet.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Subnet.
 - `update` - (Defaults to 30 minutes) Used when updating the Subnet.

---
  `retry` (Optional) supports the following:
  - `error_message_regex` - (Optional) A list of regular expressions to match against the error message returned by the API. If any of these match, the retry will be triggered.
  - `interval_seconds` - (Optional) The number of seconds to wait between retries. Defaults to 10.
  - `max_interval_seconds` - (Optional) The maximum number of seconds to wait between retries. Defaults to 180.
  - `multiplier` - (Optional) The multiplier to apply to the interval between retries Defaults to 1.5.

DESCRIPTION
}
variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) Tags of the resource."
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

variable "retry" {
  type = object({
    error_message_regex  = optional(list(string), ["ReferencedResourceNotProvisioned"])
    interval_seconds     = optional(number, 10)
    max_interval_seconds = optional(number, 180)
  })
  default     = null
  description = "Retry configuration for the resource operations"
}
variable "role_assignments" {
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
  default     = null
  description = <<DESCRIPTION
  (Optional) A map of role assignments to create on the <RESOURCE>. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

  - `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
  - `principal_id` - The ID of the principal to assign the role to.
  - `description` - (Optional) The description of the role assignment.
  - `skip_service_principal_aad_check` - (Optional) If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
  - `condition` - (Optional) The condition which will be used to scope the role assignment.
  - `condition_version` - (Optional) The version of the condition syntax. Leave as `null` if you are not using a condition, if you are then valid values are '2.0'.
  - `delegated_managed_identity_resource_id` - (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created. This field is only used in cross-tenant scenario.
  - `principal_type` - (Optional) The type of the `principal_id`. Possible values are `User`, `Group` and `ServicePrincipal`. It is necessary to explicitly set this attribute when creating role assignments if the principal creating the assignment is constrained by ABAC rules that filters on the PrincipalType attribute.

  > Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.
  DESCRIPTION
}