module "avm_res_network_ddosprotectionplan" {
  source = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-res-network-ddosprotectionplan.git?ref=v0.3.0"

  for_each = var.enabled ? { "enabled" = true } : {}

  enable_telemetry = var.enable_telemetry
  tags             = local.tags

  name                = local.name
  resource_group_name = local.resource_group_name
  location            = local.location

  role_assignments = local.role_assignments
  lock             = local.lock
}