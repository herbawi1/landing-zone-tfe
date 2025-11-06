#----------------------------------------------
# Azure Firewall Outputs
#----------------------------------------------

output "resource" {
  description = "This is the full output for the resource. This is the default output for the module following AVM standards."
  value       = module.avm_res_network_azurefirewall["enabled"].resource
}

output "resource_id" {
  description = "This is the resource id for the firewall resource."
  value       = module.avm_res_network_azurefirewall["enabled"].resource_id
}

#----------------------------------------------
# Additional Firewall Outputs
#----------------------------------------------

output "firewall_name" {
  description = "The name of the Azure Firewall."
  value       = module.avm_res_network_azurefirewall["enabled"].resource.name
}

output "firewall_location" {
  description = "The location of the Azure Firewall."
  value       = module.avm_res_network_azurefirewall["enabled"].resource.location
}

output "firewall_sku_name" {
  description = "The SKU name of the Azure Firewall."
  value       = module.avm_res_network_azurefirewall["enabled"].resource.sku_name
}

output "firewall_sku_tier" {
  description = "The SKU tier of the Azure Firewall."
  value       = module.avm_res_network_azurefirewall["enabled"].resource.sku_tier
}

output "firewall_private_ip" {
  description = "The private IP address of the Azure Firewall."
  value       = try(module.avm_res_network_azurefirewall["enabled"].resource.ip_configuration, null)
}


output "firewall_ip_configurations" {
  description = "The IP configurations of the Azure Firewall."
  value       = module.avm_res_network_azurefirewall["enabled"].resource.ip_configuration
}

output "firewall_virtual_hub" {
  description = "The virtual hub configuration of the Azure Firewall."
  value       = module.avm_res_network_azurefirewall["enabled"].resource.virtual_hub
}

output "firewall_policy_id" {
  description = "The ID of the Firewall Policy applied to this Firewall."
  value       = module.avm_res_network_azurefirewall["enabled"].resource.firewall_policy_id
}

output "firewall_zones" {
  description = "The availability zones of the Azure Firewall."
  value       = module.avm_res_network_azurefirewall["enabled"].resource.zones
}

#----------------------------------------------
# Module Reference Outputs
#----------------------------------------------

output "module_reference" {
  description = "A reference to the Azure Firewall module for use in other modules."
  value = {
    id                  = module.avm_res_network_azurefirewall["enabled"].resource.id
    name                = module.avm_res_network_azurefirewall["enabled"].resource.name
    resource_group_name = module.avm_res_network_azurefirewall["enabled"].resource.resource_group_name
    location            = module.avm_res_network_azurefirewall["enabled"].resource.location
  }
}
