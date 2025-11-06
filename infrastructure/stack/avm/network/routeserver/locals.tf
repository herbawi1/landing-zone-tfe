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
    {
      module        = "network-routeserver"
      region        = var.project_region
      environment   = var.project_env
      project_name  = var.project_name
      customer_name = var.customer_name
    }
  )
  
  # Resource group and location
  name = trimspace(coalesce(var.name, "${local.resources_names_prefix}-routeserver"))
  route_server_subnet_resource_id = coalesce(var.route_server_subnet_resource_id, data.azurerm_subnet.routeserver.id)
  location = coalesce(var.location, var.resource_group.resource.location)
  resource_group_name = var.resource_group.resource.name
  resource_group_resource_id = var.resource_group.resource.id


  # Optional configurations
  bgp_connections = var.bgp_connections
  enable_branch_to_branch = var.enable_branch_to_branch
  hub_routing_preference = var.hub_routing_preference
  private_ip_address = var.private_ip_address
  private_ip_allocation_method = var.private_ip_allocation_method
  routeserver_public_ip_config = var.routeserver_public_ip_config
  role_assignments = var.role_assignments
}
