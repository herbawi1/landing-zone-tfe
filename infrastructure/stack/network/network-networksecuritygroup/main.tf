module "avm_network_security_group" {
  for_each = local.filtered_subnets

  source = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-res-network-networksecuritygroup.git?ref=v0.5.0"

  enable_telemetry = var.enable_telemetry
  tags             = local.tags

  # Resource group and location
  location            = local.location
  resource_group_name = local.resource_group_name

  # Network security group configuration
  name = trimspace(coalesce(var.name, "${local.resources_names_prefix}-${each.key}-NSG"))
  security_rules     = local.security_rules
  diagnostic_settings = local.diagnostic_settings

  # Optional configurations
  lock             = local.lock
  role_assignments = local.role_assignments
}
