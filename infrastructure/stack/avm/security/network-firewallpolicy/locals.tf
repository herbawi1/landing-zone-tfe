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
  location            = coalesce(var.location, var.resource_group.resource.location)
  resource_group_name = coalesce(var.resource_group_name, var.resource_group.resource.name)
  name                = trimspace(coalesce(var.name, "${local.resources_names_prefix}-firewall-policy"))

  # Firewall Policy Configuration
  firewall_policy_sku = var.firewall_policy_sku # `Standard`, `Premium`, `Basic`

  # Diagnostic Settings

  # Firewall Policy Features
  firewall_policy_base_policy_id = var.firewall_policy_base_policy_id
  firewall_policy_identity       = var.firewall_policy_identity

  firewall_policy_private_ip_ranges                 = var.firewall_policy_private_ip_ranges
  firewall_policy_auto_learn_private_ranges_enabled = var.firewall_policy_auto_learn_private_ranges_enabled
  firewall_policy_sql_redirect_allowed              = var.firewall_policy_sql_redirect_allowed
  firewall_policy_dns                               = var.firewall_policy_dns

  firewall_policy_threat_intelligence_mode      = var.firewall_policy_threat_intelligence_mode
  firewall_policy_threat_intelligence_allowlist = var.firewall_policy_threat_intelligence_allowlist
  firewall_policy_intrusion_detection           = var.firewall_policy_intrusion_detection
  firewall_policy_tls_certificate               = var.firewall_policy_tls_certificate

  firewall_policy_insights       = var.firewall_policy_insights
  firewall_policy_explicit_proxy = var.firewall_policy_explicit_proxy

  firewall_policy_timeouts = var.firewall_policy_timeouts
  # Management
  lock                = var.lock
  role_assignments    = var.role_assignments
  diagnostic_settings = var.diagnostic_settings
}
