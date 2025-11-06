output "ddosprotectionplan" {
  description = "The ID of the DDoS Protection Plan"
  value       = try(module.avm_res_network_ddosprotectionplan["enabled"], null)
}
output "ddosprotectionplan_resource_id" {
  description = "The ID of the DDoS Protection Plan"
  value       = try(module.avm_res_network_ddosprotectionplan["enabled"].resource_id, null)
}
output "ddosprotectionplan_name" {
  description = "The ID of the DDoS Protection Plan"
  value       = try(module.avm_res_network_ddosprotectionplan["enabled"].name, null)
}