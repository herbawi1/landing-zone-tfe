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

  name                = trimspace(coalesce(var.name, "${local.resources_names_prefix}-natgateway"))
  location            = coalesce(var.location, var.resource_group.resource.location)
  resource_group_name = coalesce(var.resource_group_name, var.resource_group.resource.name)


  sku_name                = var.sku_name                # Standard
  idle_timeout_in_minutes = var.idle_timeout_in_minutes # 4
  zones                   = var.zones                   # null

  subnet_associations = {
    NatSubnet = {
      resource_id = data.azurerm_subnet.this.id
    }
  }

  public_ip_prefix_length = var.public_ip_prefix_length
  public_ips = {
    for i in range(var.num_public_ip) : "natgateway_pip_${i + 1}" => {
      name = "${local.resources_names_prefix}-nat-gw-pip-${i + 1}"
    }
  }

  public_ip_configuration = var.public_ip_configuration

  lock             = var.lock
  timeouts         = var.timeouts
  role_assignments = var.role_assignments
}
