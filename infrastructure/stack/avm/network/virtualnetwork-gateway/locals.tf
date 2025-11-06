locals {
  # Consistent, readable naming convention for composed resource names
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
    var.tags, {}
  )

  # Core settings  # Don't Change
  location  = coalesce(var.location, var.resource_group.resource.location)
  parent_id = coalesce(var.parent_id, var.resource_group.resource_id)

  type = var.type
  sku  = var.sku

  name                              = trimspace(coalesce(var.name, "${local.resources_names_prefix}-${local.type}"))
  virtual_network_gateway_subnet_id = data.azurerm_subnet.this.id

  # ExpressRoute configuration mapping

  express_route_circuits                    = var.express_route_circuits != {} ? var.express_route_circuits : var.express_route_config.circuits
  express_route_remote_vnet_traffic_enabled = var.express_route_remote_vnet_traffic_enabled
  express_route_virtual_wan_traffic_enabled = var.express_route_virtual_wan_traffic_enabled
  hosted_on_behalf_of_public_ip_enabled     = local.type == "ExpressRoute" ? true : false

  /* check if gateway_sku is contain `*AZ*` if yes;  vpn_private_ip_address_enabled = true else false */
  vpn_private_ip_address_enabled = strcontains(local.sku, "AZ")
  ip_configurations = local.type == "ExpressRoute" ? {} : (
    var.vpn_active_active_enabled ? {
      "ip-1" = { name = "${local.name}-ip-1" }
      "ip-2" = { name = "${local.name}-ip-2" }
      } : {
      "ip-1" = { name = "${local.name}-ip-1" }
    }
  )


  vpn_generation                       = var.vpn_generation
  vpn_type                             = var.vpn_type
  vpn_active_active_enabled            = var.vpn_active_active_enabled
  vpn_ip_sec_replay_protection_enabled = var.vpn_ip_sec_replay_protection_enabled
  vpn_dns_forwarding_enabled           = var.vpn_dns_forwarding_enabled # false
  vpn_point_to_site                    = var.vpn_point_to_site          # null


  vpn_policy_groups = var.vpn_policy_groups # {}
  vpn_custom_route = var.address_prefixes != null ? {
    address_prefixes = var.address_prefixes
  } : null

  /*create a route table*/
  route_table_creation_enabled              = var.route_table_creation_enabled # `true`, `false`
  route_table_resource_group_name           = var.route_table_resource_group_name
  route_table_name                          = trimspace(coalesce(var.route_table_name, "${local.resources_names_prefix}-${local.type}-route_table"))
  route_table_bgp_route_propagation_enabled = var.route_table_bgp_route_propagation_enabled



}
