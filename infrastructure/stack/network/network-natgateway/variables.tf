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
  description = "The name of the resource group to create. If an existing resource group ID is provided, this will be ignored."
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
# NAT Gateway Variables
#----------------------------------------------
variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the NAT Gateway should exist. Changing this forces a new resource to be created."
  default     = null
}
variable "enabled" {
  type        = bool
  default     = false
  description = "Specifies whether to create the Azure Bastion Host resources."
}
variable "name" {
  description = "The name of the NAT Gateway."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "The name of the resource group for the NAT Gateway."
  type        = string
  default     = null
}

variable "sku_name" {
  description = "The SKU name of the NAT Gateway. Possible values are Standard and Basic."
  type        = string
  default     = "Standard"
}

variable "idle_timeout_in_minutes" {
  description = "The idle timeout in minutes for the NAT Gateway."
  type        = number
  default     = 4
}

variable "zones" {
  description = "A list of availability zones for the NAT Gateway."
  type        = list(string)
  default     = null
}

variable "num_public_ip" {
  type        = number
  default     = 1
  description = "number of Public IP"
}
variable "public_ip_prefix_length" {
  type        = number
  default     = 0
  description = "(Optional) Public IP-prefix CIDR mask to use. Set to 0 to disable."
}

variable "public_ips" {
  type = map(object({
    name = string
  }))
  default     = {}
  description = <<PUBLIC_IPS
This map will define between 1 and 16 public IP's to assign to this NAT Gateway. The `public_ip_configuration` is used to configure common elements across all public IPs."

- `<map key>` - (Required) - The unique arbitrary map key is used by terraform to plan the number of public IP's to create
  - `name` - The name to use for this public IP resource

Example Input:

```hcl
public_ips = {
  ip_1 = {
    name = "nat_gw_pip_1"
  }
}
```
PUBLIC_IPS
}

variable "public_ip_configuration" {
  type = object({
    allocation_method       = optional(string, "Static")
    ddos_protection_mode    = optional(string, "VirtualNetworkInherited")
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    idle_timeout_in_minutes = optional(number, 30)
    inherit_tags            = optional(bool, false)
    ip_version              = optional(string, "IPv4")
    lock_level              = optional(string, null)
    sku                     = optional(string, "Standard")
    sku_tier                = optional(string, "Regional")
    tags                    = optional(map(string), null)
    zones                   = optional(list(string), ["1", "2", "3"])
  })
  default     = null
  description = "refer : https://github.com/Azure/terraform-azurerm-avm-res-network-natgateway/blob/main/variables.tf"
}

variable "lock" {
  description = "Lock configuration for the NAT Gateway."
  type = object({
    kind = string
    name = optional(string, null)
  })
  default = null
}

variable "timeouts" {
  description = "Timeout configuration for the NAT Gateway."
  type = object({
    create = optional(string, "60m")
    delete = optional(string, "60m")
    read   = optional(string, "5m")
    update = optional(string, "60m")
  })
  default = {}
}

variable "role_assignments" {
  description = "A map of role assignments for the NAT Gateway."
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

variable "subnet_associations" {
  type = map(object({
    resource_id = string
    }
  ))
  default     = {}
  description = <<SUBNET_ASSOCIATIONS
This map will define any subnet associations for this nat gateway. The

- `<map key>` - (Required) - The unique arbitrary map key is used by terraform to plan the number of subnet associations to create
  - `resource_id` - (Required) - The Azure Resource ID for the subnet to be associated to this NAT Gateway

Example Input:

```hcl
subnet_associations = {
  subnet_1 = {
    resource_id = azurerm_subnet.example.id
  }
}
```
SUBNET_ASSOCIATIONS
}
variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) Tags of the resource."
}

