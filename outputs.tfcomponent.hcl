output "resourcegroup" {
  type        = object({})
  description = "Azure resource group"
  value       = component.resourcegroup.resource_group
}

output "network" {
  type        = object({})
  description = "Azure network"
  value       = component.network.virtual_network
}