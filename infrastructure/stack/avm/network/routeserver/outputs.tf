output "route_server" {
  description = "The Route Server resource object."
  value       = module.avm_ptn_network_routeserver["enabled"].resource
}

output "route_server_resource_id" {
  description = "The Azure Resource ID for the Route Server."
  value       = module.avm_ptn_network_routeserver["enabled"].resource_id
}
