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
# Virtual Network Bastion Host Variables
#----------------------------------------------
variable "resource_group_name" {
  description = "(Optional) The name of the Resource Group where the Firewall Policy should exist. Changing this forces a new Firewall Policy to be created. If not specified, will use the resource group object's name."
  type        = string
  default     = null
}

variable "location" {
  type        = string
  description = "The location of the Azure Bastion Host and related resources."
  default     = ""
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Specifies whether to create the Azure Bastion Host resources."
}
variable "name" {
  type        = string
  description = "The name of the Azure Bastion Host."
  default     = ""
}

variable "copy_paste_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether copy-paste functionality is enabled for the Azure Bastion Host."
}

variable "file_copy_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether file copy functionality is enabled for the Azure Bastion Host."
}

variable "ip_configuration" {
  type = object({
    name                             = optional(string)
    subnet_id                        = string
    create_public_ip                 = optional(bool, true)
    public_ip_tags                   = optional(map(string), null)
    public_ip_merge_with_module_tags = optional(bool, true)
    public_ip_address_name           = optional(string, null)
    public_ip_address_id             = optional(string, null)
  })
  default     = null
  description = <<DESCRIPTION
The IP configuration for the Azure Bastion Host.
- `name` - The name of the IP configuration.
- `subnet_id` - The ID of the subnet where the Azure Bastion Host will be deployed.
- `create_public_ip` - Specifies whether a public IP address should be created by the module.
- `public_ip_tags` - A map of tags to apply to the public IP address.
- `public_ip_merge_with_module_tags` - If set to true, the public IP tags will be merged with the module's tags. If set to false, only the `public_ip_tags` will be applied to the public IP address.
- `public_ip_address_name` - The Name of the public IP address to create. Will be ignored if `public_ip_address_id` is set.
- `public_ip_address_id` - The ID of the public IP address associated with the Azure Bastion Host. If Set, create_public_ip must be set to false.
DESCRIPTION

}

variable "ip_connect_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether IP connect functionality is enabled for the Azure Bastion Host."
}

variable "kerberos_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether Kerberos authentication is enabled for the Azure Bastion Host."

}

variable "private_only_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether the Azure Bastion Host is configured to be private only. This is a premium SKU feature."
}

variable "scale_units" {
  type        = number
  default     = 2
  description = "The number of scale units for the Azure Bastion Host."
}

variable "session_recording_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether session recording functionality is enabled for the Azure Bastion Host."

}

variable "shareable_link_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether shareable link functionality is enabled for the Azure Bastion Host."
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = <<DESCRIPTION
The SKU of the Azure Bastion Host.
Valid values are 'Basic', 'Standard', 'Developer' or 'Premium'.
DESCRIPTION

}

variable "tunneling_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether tunneling functionality is enabled for the Azure Bastion Host. (Native client support for SSH and RDP tunneling)"
}


variable "zones" {
  type        = set(string)
  default     = ["1", "2", "3"]
  description = "The availability zones where the Azure Bastion Host is deployed."
}

variable "tags" {
    description = "A map of tags to apply to all resources."
    type        = map(string)
    default     = {}
}
