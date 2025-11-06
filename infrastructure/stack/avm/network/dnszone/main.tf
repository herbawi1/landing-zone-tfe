module "avm_res_network_dnszone" {
  source  = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-res-network-dnszone.git?ref=v0.2.1"

  enable_telemetry = var.enable_telemetry
  tags             = local.tags
  
  resource_group_name = local.resource_group_name
  name           = local.name
  
  # DNS Records
  a_records     = local.a_records
  aaaa_records  = local.aaaa_records
  cname_records = local.cname_records
  mx_records    = local.mx_records
  ptr_records   = local.ptr_records
  srv_records   = local.srv_records
  txt_records   = local.txt_records
  caa_records = local.caa_records
  ns_records = local.ns_records
}
