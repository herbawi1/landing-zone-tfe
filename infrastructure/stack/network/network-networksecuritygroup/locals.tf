locals {
  resources_names_prefix = format(
    "%s-%s-%s-%s",
    trimspace(coalesce(var.customer_name, "")),
    trimspace(coalesce(var.project_name, "")),
    trimspace(coalesce(var.project_env, "")),
    trimspace(coalesce(var.project_region, "")),
  )
  tags = merge(var.default_tags, var.tags, {})

  # Resource group and location
  location            = coalesce(var.location, var.resource_group.resource.location)
  resource_group_name = coalesce(var.resource_group_name, var.resource_group.resource.name)

  subnets                       = data.azurerm_subnet.subnets

  # Filter out dedicated service subnets (AzureFirewallSubnet, AzureBastionSubnet, GatewaySubnet)
  filtered_subnets = {
    for k, v in local.subnets :
      k => v
      if !contains([
        "AzureFirewallSubnet",
        "AzureFirewallManagementSubnet",
        "GatewaySubnet",
      ], v.name)
  }

  security_rules    = var.security_rules
  diagnostic_settings = var.diagnostic_settings

  # Optional configurations
  role_assignments = var.role_assignments
  lock             = var.lock
}
