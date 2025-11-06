module "firewall_policy_rule_collection_group" {
  source = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-res-network-firewallpolicy.git//modules/rule_collection_groups?ref=v0.3.3"
  
  for_each         = var.enabled ? { "enabled" = true } : {}
  firewall_policy_rule_collection_group_firewall_policy_id = var.firewall_policy_rule_collection_group_firewall_policy_id

  firewall_policy_rule_collection_group_name     = local.firewall_policy_rule_collection_group_name
  firewall_policy_rule_collection_group_priority = local.firewall_policy_rule_collection_group_priority

  firewall_policy_rule_collection_group_application_rule_collection = local.firewall_policy_rule_collection_group_application_rule_collection
  firewall_policy_rule_collection_group_nat_rule_collection         = local.firewall_policy_rule_collection_group_nat_rule_collection
  firewall_policy_rule_collection_group_network_rule_collection     = local.firewall_policy_rule_collection_group_network_rule_collection

  firewall_policy_rule_collection_group_timeouts = var.firewall_policy_rule_collection_group_timeouts
}
