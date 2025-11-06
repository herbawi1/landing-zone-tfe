output "names" {
  description = "Map of network security group names keyed by subnet name."
  value       = { for k, v in module.avm_network_security_group : k => v.name }
}

output "resources" {
  description = "Map of network security group resource objects keyed by subnet name."
  value       = { for k, v in module.avm_network_security_group : k => v.resource }
}

output "resource_ids" {
  description = "Map of network security group resource IDs keyed by subnet name."
  value       = { for k, v in module.avm_network_security_group : k => v.resource_id }
}
