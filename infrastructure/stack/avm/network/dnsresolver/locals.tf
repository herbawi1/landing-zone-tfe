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

  resource_group_name = coalesce(var.resource_group_name, var.resource_group.name)
  name = coalesce(var.name, "${local.resources_names_prefix}-dnsResolver")
  location = coalesce(var.location, var.resource_group.resource.location)
  virtual_network_resource_id = coalesce(var.virtual_network_resource_id, var.virtual_network.resource.id)

  inbound_endpoints ={
    inbound_endpoints = {
      subnet_name = data.azurerm_subnet.inboundDnsResolverSubnet.name
      private_ip_allocation_method = "Dynamic"
      merge_with_module_tags = true
    }
  }
  outbound_endpoints = {
    outbound_endpoints = {
      subnet_name = data.azurerm_subnet.outboundDnsResolverSubnet.name
      private_ip_allocation_method = "Dynamic"
      merge_with_module_tags = true
    }
  }
  role_assignments   = {}
  lock               = var.lock
}
