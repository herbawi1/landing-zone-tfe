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
    var.default_tags, var.tags, {}
  )
  # Resource group and location
  location            = coalesce(var.location, var.resource_group.resource.location)
  resource_group_name = coalesce(var.resource_group_name, var.resource_group.resource.name)

  # Bastion host name
  name = trimspace(coalesce(var.name, "${local.resources_names_prefix}-bastionhost"))

  # Bastion host configuration - Premium SKU for medium organization with scalability needs
  sku                  = var.sku # Primium , Standard, Basic, Developer
  scale_units          = var.scale_units
  private_only_enabled = var.private_only_enabled


  ip_configuration = var.private_only_enabled == true ? {
    name                 = "${local.name}-IP-Config"
    create_public_ip     = false
    subnet_id            = data.azurerm_subnet.this.id
    public_ip_address_id = null
    } : {
    name                             = "${local.name}-IP-Config"
    subnet_id                        = data.azurerm_subnet.this.id
    create_public_ip                 = true
    public_ip_address_name           = "${local.name}-Public-IP"
    public_ip_merge_with_module_tags = true
  }

}
