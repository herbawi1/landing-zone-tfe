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

  location  = coalesce(var.location, var.resource_group.resource.location)
  parent_id = coalesce(var.parent_id, var.resource_group.resource_id)

  # Private DNS Zone Configuration
  resolution_policy                      = !can(regex("privatelink\\.azurewebsites\\.net", local.private_dns_zone_domain_name)) ? "Default" : "NxDomainRedirect"
  private_dns_zone_supports_private_link = !can(regex("privatelink\\.azurewebsites\\.net", local.private_dns_zone_domain_name))

  private_dns_zone_domain_name = var.domain_name != null ? var.domain_name : "${local.resources_names_prefix}.local"

  virtual_network_links = merge(
    {
      vnet_link = {
        virtual_network_id = var.virtual_network.resource.id
        name               = "link-dns-${var.virtual_network.resource.name}"
        autoregistration   = false
      }
    },
    var.virtual_network_links
  )
}
