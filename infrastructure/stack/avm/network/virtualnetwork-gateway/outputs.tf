output "resource_id" {
  description = "The ID of the Virtual Network Gateway."
  value       = module.virtual_network_gateway["enabled"].resource_id
}

output "virtual_network_gateway" {
  description = "A curated output of the Virtual Network Gateway created by this module."
  value       = module.virtual_network_gateway["enabled"].virtual_network_gateway
}

output "public_ip_addresses" {
  description = "A curated output of the Public IP Addresses created by this module."
  value       = module.virtual_network_gateway["enabled"].public_ip_addresses
}

output "local_network_gateways" {
  description = "A curated output of the Local Network Gateways created by this module."
  value       = module.virtual_network_gateway["enabled"].local_network_gateways
}

output "subnet" {
  description = "A curated output of the GatewaySubnet created by this module."
  value       = module.virtual_network_gateway["enabled"].subnet
}

output "route_table" {
  description = "A curated output of the Route Table created by this module."
  value       = module.virtual_network_gateway["enabled"].route_table
}

output "virtual_network_gateway_connections" {
  description = "A curated output of the Virtual Network Gateway Connections created by this module."
  value       = module.virtual_network_gateway["enabled"].virtual_network_gateway_connections
}
