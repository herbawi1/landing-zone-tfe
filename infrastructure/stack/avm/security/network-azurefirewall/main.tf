module "fw_public_ip" {
  source  = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-res-network-publicipaddress.git?ref=v0.2.0"
  

  count    = local.num_fw_public_ips
  location = local.location
  # insert the 3 required variables here
  name                = "${local.resources_names_prefix}-FW-PIP-${count.index}"
  resource_group_name = local.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
  zones               = ["1", "2", "3"]
}

module "fw_management_public_ip" {
  source  = "Azure/avm-res-network-publicipaddress/azurerm"
  version = "0.1.2"

  location = local.location
  # insert the 3 required variables here
  name                = "${local.resources_names_prefix}-FW-MNGM-PIP"
  resource_group_name = local.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
  zones               = ["1", "2", "3"]
}

module "avm_res_network_azurefirewall" {
  source  = "Azure/avm-res-network-azurefirewall/azurerm"
  version = "0.4.0"
  
  for_each         = var.enabled ? { "enabled" = true } : {}
  name                = local.name
  location            = local.location
  resource_group_name = local.resource_group_name

  firewall_sku_name = local.firewall_sku_name
  firewall_sku_tier = local.firewall_sku_tier # deflate `Standard`; Allowed: `Premium`, `Standard`, `Basic`

  firewall_policy_id         = local.firewall_policy_id
  firewall_private_ip_ranges = local.firewall_private_ip_ranges
  role_assignments           = local.role_assignments
  diagnostic_settings        = local.diagnostic_settings

  # Auto generated IP configurations
  ip_configurations                    = local.ip_configurations
  firewall_management_ip_configuration = local.firewall_management_ip_configuration
  firewall_ip_configuration            = local.firewall_ip_configuration # null; use ip_configurations instead

  firewall_virtual_hub = local.firewall_virtual_hub

  lock              = local.lock
  firewall_zones    = local.firewall_zones
  tags              = local.tags
  firewall_timeouts = local.firewall_timeouts
  enable_telemetry  = local.enable_telemetry
}
