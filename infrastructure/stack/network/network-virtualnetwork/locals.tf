locals {
  # Consistent, readable naming convention for composed resource names
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

  name      = trimspace(coalesce(var.name, "${local.resources_names_prefix}-vnet"))
  location  = coalesce(var.location, var.resource_group.resource.location)
  parent_id = coalesce(var.parent_id, var.resource_group.resource_id)


  address_space = var.address_space

  subnets_data     = var.subnets_json
  new_bits_list    = [for subnet in local.subnets_data : subnet["new_bits"]]
  calculated_cidrs = cidrsubnets(local.address_space[0], local.new_bits_list...)

  subnets = {
    for idx, subnet in local.subnets_data :
    subnet["name"] => {
      name                            = subnet["name"]
      address_prefixes                = [local.calculated_cidrs[idx]]
      description                     = try(subnet["description"], "")
      default_outbound_access_enabled = try(subnet["default_outbound_access_enabled"], false)
      service_endpoints_with_location = try([for s in subnet["service_endpoints_with_location_service"] : { service = s }], null)
      # private_endpoint_network_policies = try(subnet[private_endpoint_network_policies],"Enabled")
      delegations = try(subnet["delegations"], null)
    } if try(subnet["create_subnet"], false) == true
  }





  ddos_protection_plan = var.ddos_protection_plan_id != "" ? {
    enable = true
    id     = var.ddos_protection_plan_id
  } : null



  dns_servers = var.dns_servers_list != null ? { dns_servers = var.dns_servers_list } : null # HERE



  encryption = {
    enabled     = true
    enforcement = "AllowUnencrypted" #  'AllowUnencrypted', 'DropUnencrypted'
  }

  peerings          = var.peerings
  bgp_community     = var.bgp_community
  extended_location = var.extended_location

  diagnostic_settings     = var.diagnostic_settings
  flow_timeout_in_minutes = var.flow_timeout_in_minutes

  role_assignments = var.role_assignments
  lock = var.lock != null ? var.lock : (
    var.lock_kind != null ? {
      kind = var.lock_kind
      name = trimspace(coalesce(var.lock_name, "${local.resources_names_prefix}-vnet-lock"))
    } : null
  )

  retry    = var.retry
  timeouts = var.timeouts
}

