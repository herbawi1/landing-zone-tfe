locals {
  resources_names_prefix = format(
    "%s-%s-%s-%s",
    trimspace(coalesce(var.customer_name, "")),
    trimspace(coalesce(var.project_name, "")),
    trimspace(coalesce(var.project_env, "")),
    trimspace(coalesce(var.project_region, "")),
  )
  # Merge user-provided tags with module-specific tags (user-provided overrides defaults)
  tags = merge(
    var.default_tags,
    {}
  )

  location            = coalesce(var.location, var.resource_group.resource.location)
  resource_group_name = coalesce(var.resource_group_name, var.resource_group.resource.name)

  # Firewall Policy Rule Collection Group settings
  firewall_policy_rule_collection_group_name     = trimspace(coalesce(var.firewall_policy_rule_collection_group_name, "${local.resources_names_prefix}-fwrcg"))
  firewall_policy_rule_collection_group_priority = coalesce(var.firewall_policy_rule_collection_group_priority)

  firewall_policy_rule_collection_group_application_rule_collection = var.firewall_policy_rule_collection_group_application_rule_collection
  firewall_policy_rule_collection_group_network_rule_collection = var.firewall_policy_rule_collection_group_network_rule_collection
  firewall_policy_rule_collection_group_nat_rule_collection = var.firewall_policy_rule_collection_group_nat_rule_collection


}
