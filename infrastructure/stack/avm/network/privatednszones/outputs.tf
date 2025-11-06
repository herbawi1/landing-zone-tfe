# Private DNS Zone outputs (matching AVM module outputs)
output "resource" {
  description = "This is the full output for Private DNS Zone resource. This is the default output for the module following AVM standards."
  value       = module.avm_res_network_privatednszone["enabled"].resource
}

output "resource_id" {
  description = "The resource id of private DNS zone"
  value       = module.avm_res_network_privatednszone["enabled"].resource_id
}

output "name" {
  description = "The name of private DNS zone"
  value       = module.avm_res_network_privatednszone["enabled"].name
}

# DNS Record outputs
output "a_record_outputs" {
  description = "The a record output"
  value       = module.avm_res_network_privatednszone["enabled"].a_record_outputs
}

output "aaaa_record_outputs" {
  description = "The aaaa record output"
  value       = module.avm_res_network_privatednszone["enabled"].aaaa_record_outputs
}

output "cname_record_outputs" {
  description = "The cname record output"
  value       = module.avm_res_network_privatednszone["enabled"].cname_record_outputs
}

output "mx_record_outputs" {
  description = "The mx record output"
  value       = module.avm_res_network_privatednszone["enabled"].mx_record_outputs
}

output "ptr_record_outputs" {
  description = "The ptr record output"
  value       = module.avm_res_network_privatednszone["enabled"].ptr_record_outputs
}

output "soa_record_outputs" {
  description = "The soa record output"
  value       = module.avm_res_network_privatednszone["enabled"].soa_record_outputs
}

output "srv_record_outputs" {
  description = "The srv record output"
  value       = module.avm_res_network_privatednszone["enabled"].srv_record_outputs
}

output "txt_record_outputs" {
  description = "The txt record output"
  value       = module.avm_res_network_privatednszone["enabled"].txt_record_outputs
}

output "virtual_network_link_outputs" {
  description = "The virtual network link output"
  value       = module.avm_res_network_privatednszone["enabled"].virtual_network_link_outputs
}
