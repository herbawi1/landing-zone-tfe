module "avm_res_network_firewallpolicy" {
  source  = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-res-network-firewallpolicy.git?ref=v0.3.3"
  
  for_each         = var.enabled ? { "enabled" = true } : {}
  enable_telemetry = var.enable_telemetry
  tags             = local.tags

  location            = local.location
  resource_group_name = local.resource_group_name
  name                = local.name

  firewall_policy_sku = local.firewall_policy_sku

  # Firewall Policy Features
  firewall_policy_base_policy_id = local.firewall_policy_base_policy_id

  firewall_policy_private_ip_ranges                 = local.firewall_policy_private_ip_ranges
  firewall_policy_auto_learn_private_ranges_enabled = local.firewall_policy_auto_learn_private_ranges_enabled

  firewall_policy_identity             = local.firewall_policy_identity
  firewall_policy_insights             = local.firewall_policy_insights
  firewall_policy_sql_redirect_allowed = local.firewall_policy_sql_redirect_allowed

  /*if Enable; FW will foreword the DNS query to DNS server or AZURE*/
  firewall_policy_dns = local.firewall_policy_dns
  /*protect from known malicious IP addresses and domains; Threat intelligence mode Alert and Deny,; You can Allow Spic: ip or FQDN */
  firewall_policy_threat_intelligence_mode      = local.firewall_policy_threat_intelligence_mode
  firewall_policy_threat_intelligence_allowlist = local.firewall_policy_threat_intelligence_allowlist

  firewall_policy_tls_certificate     = local.firewall_policy_tls_certificate
  firewall_policy_intrusion_detection = local.firewall_policy_intrusion_detection

  firewall_policy_explicit_proxy = local.firewall_policy_explicit_proxy # Proxy autoconfiguration


  # Management
  role_assignments         = local.role_assignments
  diagnostic_settings      = local.diagnostic_settings
  lock                     = local.lock
  firewall_policy_timeouts = local.firewall_policy_timeouts
}
