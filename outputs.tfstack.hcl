output "resourcegroup" {
  type        = any
  description = "Azure resource group"
  value       = component.resourcegroup.resource_group
}

output "network" {
  type        = any
  description = "Azure network"
  value       = component.network.virtual_network
}