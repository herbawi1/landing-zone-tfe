module "avm_res_network_virtualnetwork" {
  source = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-res-network-virtualnetwork.git?ref=v0.12.0"

  enable_telemetry = var.enable_telemetry
  tags             = local.tags

  # resource group info
  parent_id = local.parent_id
  location  = local.location

  name          = local.name
  address_space = local.address_space

  subnets    = local.subnets
  encryption = local.encryption

  ddos_protection_plan = local.ddos_protection_plan
  enable_vm_protection = null

  dns_servers = local.dns_servers # HERE

  peerings                = local.peerings
  bgp_community           = local.bgp_community
  flow_timeout_in_minutes = local.flow_timeout_in_minutes
  extended_location       = local.extended_location
  diagnostic_settings     = local.diagnostic_settings

  lock             = local.lock
  role_assignments = local.role_assignments

  retry    = local.retry
  timeouts = local.timeouts
}