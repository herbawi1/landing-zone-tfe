module "avm_res_network_natgateway" {
  source = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-res-network-natgateway.git?ref=v0.2.1"
  
  for_each         = var.enabled ? { "enabled" = true } : {}
  enable_telemetry = var.enable_telemetry
  tags             = local.tags

  name                = local.name
  location            = local.location
  resource_group_name = local.resource_group_name

  subnet_associations = local.subnet_associations

  sku_name                = local.sku_name
  idle_timeout_in_minutes = local.idle_timeout_in_minutes
  
  zones                   = local.zones

  public_ips              = local.public_ips
  public_ip_configuration = local.public_ip_configuration
  public_ip_prefix_length = local.public_ip_prefix_length

  lock             = local.lock
  timeouts         = local.timeouts
  role_assignments = local.role_assignments
}
