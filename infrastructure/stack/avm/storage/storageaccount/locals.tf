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

  # Core settings  # Don't Change
  location            = coalesce(var.location, var.resource_group.resource.location)
  resource_group_name = coalesce(var.resource_group_name, var.resource_group.resource.name)
  name                = trimspace(coalesce(var.name, "${local.resources_names_prefix}-SA"))



  lock = var.lock_kind != null ? {
    kind = var.lock_kind
    name = var.lock_name != "" ? var.lock_name : "${local.resources_names_prefix}-st-lock"
  } : null
  role_assignments = var.role_assignments
}
