module "avm_res_network_dnsresolver" {
  source  = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-res-network-dnsresolver.git?ref=v0.8.0"

  for_each         = var.enabled ? { "enabled" = true } : {}
  enable_telemetry = var.enable_telemetry
  tags             = local.tags

  location                   = local.location
  resource_group_name        = local.resource_group_name
  name                       = local.name
  virtual_network_resource_id = local.virtual_network_resource_id

  inbound_endpoints          = local.inbound_endpoints
  outbound_endpoints         = local.outbound_endpoints
  role_assignments           = local.role_assignments
  lock                       = local.lock
}
