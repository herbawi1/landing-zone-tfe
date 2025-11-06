output "names" {
  description = "Map of route table names keyed by subnet name."
  value       = { for k, v in module.avm_route_table : k => v.name }
}

output "resources" {
  description = "Map of route table resource objects keyed by subnet name."
  value       = { for k, v in module.avm_route_table : k => v.resource }
}

output "resource_ids" {
  description = "Map of route table resource IDs keyed by subnet name."
  value       = { for k, v in module.avm_route_table : k => v.resource_id }
}

output "routes" {
  description = "Map of route table routes keyed by subnet name."
  value       = { for k, v in module.avm_route_table : k => v.routes }
}
