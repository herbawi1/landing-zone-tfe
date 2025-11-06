output "nat_gateway" {
  description = "The NAT Gateway resource object"
  value       = module.avm_res_network_natgateway["enabled"]
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = module.avm_res_network_natgateway["enabled"].resource_id
}

output "nat_gateway_name" {
  description = "The name of the NAT Gateway"
  value       = module.avm_res_network_natgateway["enabled"].resource.name
}

output "nat_gateway_location" {
  description = "The location of the NAT Gateway"
  value       = module.avm_res_network_natgateway["enabled"].resource.location
}

output "nat_gateway_public_ip_addresses" {
  description = "The public IP addresses of the NAT Gateway"
  value       = module.avm_res_network_natgateway["enabled"].public_ip_resource
}

output "nat_gateway_public_ip_prefix_value" {
  description = "The public IP addresses of the NAT Gateway"
  value       = module.avm_res_network_natgateway["enabled"].public_ip_prefix_value
}



