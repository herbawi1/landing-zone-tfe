# Firewall Policy outputs (matching AVM module outputs)
output "resource" {
  description = "This is the full output for Firewall Policy resource. This is the default output for the module following AVM standards. Review the examples below for the correct output to use in your module."
  value       = module.avm_res_network_firewallpolicy["enabled"].resource
}

output "resource_id" {
  description = "The resource id of the firewall policy"
  value       = module.avm_res_network_firewallpolicy["enabled"].resource_id
}
