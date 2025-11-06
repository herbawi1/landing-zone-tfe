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
    var.tags,
  )

  # Normalize and default name/location
  name     = trimspace(coalesce(var.name, "${local.resources_names_prefix}-rg"))
  location = trimspace(coalesce(var.location, var.project_region))

  # Lock precedence: explicit lock object wins; otherwise derive from kind/name variables; null if neither provided
  lock = var.lock != null ? var.lock : (
    var.lock_kind != null ? {
      kind = var.lock_kind
      name = trimspace(coalesce(var.lock_name, "${local.resources_names_prefix}-rg-lock"))
    } : null
  )

  role_assignments = var.role_assignments
}
