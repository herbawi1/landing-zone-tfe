module "virtual_network_gateway" {
  source = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-ptn-alz-connectivity-hub-and-spoke-vnet.git//modules/virtual-network-gateway?ref=v0.14.1"

  for_each = var.enabled ? { "enabled" = true } : {}
  # Core settings
  enable_telemetry = var.enable_telemetry
  name             = local.name

  parent_id = local.parent_id
  location  = local.location

  # Subnet info injected
  virtual_network_gateway_subnet_id = local.virtual_network_gateway_subnet_id
  subnet_creation_enabled           = var.subnet_creation_enabled #false
  subnet_address_prefix             = var.subnet_address_prefix   #null
  virtual_network_id                = var.virtual_network_id      #null

  # ER | VPN
  type = local.type
  sku  = local.sku

  express_route_circuits                    = local.express_route_circuits
  express_route_remote_vnet_traffic_enabled = local.express_route_remote_vnet_traffic_enabled
  express_route_virtual_wan_traffic_enabled = local.express_route_virtual_wan_traffic_enabled
  hosted_on_behalf_of_public_ip_enabled     = local.hosted_on_behalf_of_public_ip_enabled
  ip_configurations                         = local.ip_configurations


  vpn_generation    = local.vpn_generation # Generation1 | Generation2
  vpn_type          = local.vpn_type       # RouteBased
  vpn_point_to_site = local.vpn_point_to_site

  vpn_private_ip_address_enabled       = local.vpn_private_ip_address_enabled       #Auto
  vpn_active_active_enabled            = local.vpn_active_active_enabled            # false
  vpn_ip_sec_replay_protection_enabled = local.vpn_ip_sec_replay_protection_enabled # true
  vpn_dns_forwarding_enabled           = local.vpn_dns_forwarding_enabled

  route_table_creation_enabled              = var.route_table_creation_enabled
  route_table_bgp_route_propagation_enabled = var.route_table_bgp_route_propagation_enabled
  route_table_resource_group_name           = var.route_table_resource_group_name
  route_table_name                          = var.route_table_name
  route_table_tags                          = var.tags

  local_network_gateways               = var.local_network_gateways               # or
  vpn_default_local_network_gateway_id = var.vpn_default_local_network_gateway_id # null
  vpn_policy_groups                    = local.vpn_policy_groups

  vpn_bgp_enabled                           = var.vpn_bgp_enabled # false
  vpn_bgp_route_translation_for_nat_enabled = var.vpn_bgp_route_translation_for_nat_enabled
  vpn_bgp_settings                          = var.vpn_bgp_settings
  vpn_custom_route                          = local.vpn_custom_route # null

  edge_zone = var.edge_zone # null

  timeouts = var.timeouts
  retry    = var.retry
  tags     = local.tags
}
