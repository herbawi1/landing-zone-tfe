module "avm_route_table" {
  for_each = local.filtered_subnets

  source = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-res-network-routetable.git?ref=0.4.1"

  enable_telemetry = var.enable_telemetry
  tags             = local.tags

  # Resource group and location
  location            = local.location
  resource_group_name = local.resource_group_name

  # Route table configuration
  name = trimspace(coalesce(var.name, "${local.resources_names_prefix}-${each.key}-RT"))
  subnet_resource_ids = {
    (each.key) = each.value.id
  }
  routes                        = local.routes
  bgp_route_propagation_enabled = local.bgp_route_propagation_enabled

  # Optional configurations
  lock             = local.lock
  role_assignments = local.role_assignments
}
