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
  description = "Tags to apply to the route table and related resources. Module-specific tags will be added automatically."
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
# Azure Route Table Variables
#----------------------------------------------
variable "location" {
  type        = string
  description = "The location of the route table and related resources. Defaults to resource group location."
  default     = null
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created."
  default     = null
}

variable "name" {
  type        = string
  description = "The name of the route table. If not provided, will auto-generate based on naming convention."
  default     = null
}

variable "bgp_route_propagation_enabled" {
  type        = bool
  description = "Boolean flag which controls propagation of routes learned by BGP on that route table."
  default     = true
}

variable "lock" {
  type = object({
    kind = string
    name = optional(string, null)
  })
  description = "Controls the Resource Lock configuration for this resource. The following properties can be specified: kind (Required): The type of lock. Possible values are 'CanNotDelete' and 'ReadOnly'. name (Optional): The name of the lock. If not specified, a name will be generated based on the kind value."
  default     = null
}

variable "routes" {
  description = "A map of routes to create in the route table."
  type = map(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string, null)
  }))
  default = {}
}

variable "subnets" {
  description = "A list of subnet objects or IDs to associate with the route table."
  type = list(object({
    id   = optional(string, null)
    name = optional(string, null)
  }))
  default = []
}

variable "role_assignments" {
  description = "A map of role assignments to create on the route table."
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

variable "subnet_resource_ids" {
  type        = map(string)
  default     = {}
  description = <<DESCRIPTION
    (Optional) A map of string subnet ID's to associate the route table to.
    Each value in the map must be supplied in the form of an Azure resource ID:
```yaml annotate
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}/subnets/{subnetName}
```
Example Input:
```terraform
subnet_resource_ids = {
    subnet1 = azurerm_subnet.this.id,
    subnet2 = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}/subnets/{subnetName}"
}
```
DESCRIPTION
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) Tags of the resource."
}