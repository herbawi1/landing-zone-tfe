# DNS Resolver outputs (matching AVM module outputs)

output "forwarding_rulesets" {
  description = "The forwarding rulesets of the DNS resolver."
  value       = module.avm_res_network_dnsresolver["enabled"].forwarding_rulesets
}

output "inbound_endpoint_ips" {
  description = "The IP addresses of the inbound endpoints."
  value       = module.avm_res_network_dnsresolver["enabled"].inbound_endpoint_ips
}

output "inbound_endpoints" {
  description = "The inbound endpoints of the DNS resolver."
  value       = module.avm_res_network_dnsresolver["enabled"].inbound_endpoints
}

output "name" {
  description = "The name of the DNS resolver."
  value       = module.avm_res_network_dnsresolver["enabled"].name
}

output "outbound_endpoints" {
  description = "The outbound endpoints of the DNS resolver."
  value       = module.avm_res_network_dnsresolver["enabled"].outbound_endpoints
}

output "resource" {
  description = "This is the full output for the resource."
  value       = module.avm_res_network_dnsresolver["enabled"].resource
}

output "resource_id" {
  description = "The ID of the DNS resolver."
  value       = module.avm_res_network_dnsresolver["enabled"].resource_id
}
