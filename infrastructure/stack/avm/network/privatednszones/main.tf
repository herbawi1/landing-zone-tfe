module "avm_res_network_privatednszone" {
  source  = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-res-network-privatednszone.git?ref=v0.4.2"

  for_each         = var.enabled ? { "enabled" = true } : {}
  enable_telemetry = var.enable_telemetry
  tags             = local.tags

  parent_id = local.parent_id

  domain_name           = local.private_dns_zone_domain_name
  virtual_network_links = local.virtual_network_links

  # DNS Records
  a_records     = var.a_records
  aaaa_records  = var.aaaa_records
  cname_records = var.cname_records
  mx_records    = var.mx_records
  ptr_records   = var.ptr_records
  soa_record    = var.soa_record
  srv_records   = var.srv_records
  txt_records   = var.txt_records

  # Management
  role_assignments = var.role_assignments
  retry            = var.retry
  timeouts         = var.timeouts
}
