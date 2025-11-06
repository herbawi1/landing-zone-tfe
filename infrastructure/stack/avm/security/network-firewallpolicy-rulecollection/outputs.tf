output "resource" {
  description = "This is the full output for the resource. This is the default output for the module following AVM standards."
  value       = module.firewall_policy_rule_collection_group["enabled"].resource
}

output "resource_id" {
  description = "This is the resource id for the rule collection group."
  value       = module.firewall_policy_rule_collection_group["enabled"].resource_id
}
