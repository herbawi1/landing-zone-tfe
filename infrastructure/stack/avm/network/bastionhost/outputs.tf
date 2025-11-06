output "bastion_host" {
  description = "The Azure Bastion resource"
  value       = module.avm_res_network_bastionhost["enabled"]
}

output "bastion_host_resource_id" {
  description = "The ID of the Azure Bastion resource"
  value       = module.avm_res_network_bastionhost["enabled"].resource_id
}

output "bastion_host_name" {
  description = "The name of the Azure Bastion resource"
  value       = module.avm_res_network_bastionhost["enabled"].name
}

output "bastion_host_dns_name" {
  description = "The FQDN of the Azure Bastion resource"
  value       = module.avm_res_network_bastionhost["enabled"].dns_name
}
