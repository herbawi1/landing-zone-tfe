module "avm_ptn_network_routeserver" {
  source = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-ptn-network-routeserver.git?ref=v0.1.5"
  
  for_each         = var.enabled ? { "enabled" = true } : {}
  
  # Basic configuration
  enable_telemetry = var.enable_telemetry

  # Resource group and location
  location = local.location
  name     = local.name
  # Route Server configuration
  resource_group_name             = local.resource_group_name
  resource_group_resource_id      = local.resource_group_resource_id
  route_server_subnet_resource_id = local.route_server_subnet_resource_id


  # Optional configurations
  bgp_connections              = local.bgp_connections
  enable_branch_to_branch      = local.enable_branch_to_branch
  hub_routing_preference       = local.hub_routing_preference
  private_ip_allocation_method = local.private_ip_allocation_method
  private_ip_address           = local.private_ip_address
  routeserver_public_ip_config = local.routeserver_public_ip_config
  role_assignments             = local.role_assignments

  # Tags
  tags = local.tags
}
