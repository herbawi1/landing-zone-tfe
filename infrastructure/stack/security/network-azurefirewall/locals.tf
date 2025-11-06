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
    var.tags, {}
  )


  # Resource group and location
  name                = trimspace(coalesce(var.name, "${local.resources_names_prefix}-azurefirewall"))
  location            = coalesce(var.location, var.resource_group.resource.location)
  resource_group_name = coalesce(var.resource_group_name, var.resource_group.resource.name)

  # Firewall naming

  # Firewall configuration
  firewall_sku_name = var.firewall_sku_name
  firewall_sku_tier = var.firewall_sku_tier

  # Public IP counts
  num_fw_public_ips = var.num_fw_public_ips # current value is 2

  # IP configurations
  ip_configurations = coalesce(var.ip_configurations, {
    for i in range(local.num_fw_public_ips) : "fw_pip_${i + 1}" => merge(
      {
        name                 = "${local.resources_names_prefix}_fw_pip_${i + 1}"
        public_ip_address_id = module.fw_public_ip[i].public_ip_id
      },
      i == 0 ? { subnet_id = data.azurerm_subnet.firewall_sub.id } : {}
    )
  })

  firewall_management_ip_configuration = coalesce(var.firewall_management_ip_configuration, {
    name                 = "${local.resources_names_prefix}_fw_mgm_pip"
    public_ip_address_id = module.fw_management_public_ip.public_ip_id
    subnet_id            = data.azurerm_subnet.firewall_management_sub.id
  })

  # Firewall settings
  firewall_private_ip_ranges = var.firewall_private_ip_ranges
  firewall_policy_id         = var.firewall_policy_id
  diagnostic_settings        = var.diagnostic_settings
  role_assignments           = var.role_assignments
  lock                       = var.lock
  firewall_timeouts          = var.firewall_timeouts
  firewall_zones             = var.firewall_zones
  firewall_virtual_hub       = var.firewall_virtual_hub
  firewall_ip_configuration  = null
  enable_telemetry           = var.enable_telemetry
}
