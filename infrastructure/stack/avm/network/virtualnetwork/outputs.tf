output "virtual_network" {
  description = "The virtual network resource"
  value       = module.avm_res_network_virtualnetwork
}
output "virtual_network_id" {
  description = "The ID of the virtual network"
  value       = module.avm_res_network_virtualnetwork.resource_id
}
output "virtual_network_name" {
  description = "The name of the virtual network"
  value       = module.avm_res_network_virtualnetwork.name
}
output "virtual_network_subnet_ids" {
  description = "The IDs of the subnets"
  value       = module.avm_res_network_virtualnetwork.subnets
}
output "virtual_network_peerings" {
  value = module.avm_res_network_virtualnetwork.peerings
}