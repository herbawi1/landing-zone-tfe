output "resource_group" {
  description = "The resource group object"
  value       = module.avm_res_resources_resourcegroup
}
output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.avm_res_resources_resourcegroup.name
}
output "resource_group_resource_id" {
  description = "The ID of the resource group"
  value       = module.avm_res_resources_resourcegroup.resource_id
}
