module "avm_res_network_bastionhost" {
  source = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-res-network-bastionhost.git?ref=v0.8.1"

  for_each         = var.enabled ? { "enabled" = true } : {}
  enable_telemetry = var.enable_telemetry

  # resource group info
  resource_group_name = local.resource_group_name
  location            = local.location

  name = local.name

  sku         = local.sku
  scale_units = local.scale_units

  private_only_enabled = local.private_only_enabled
  ip_configuration     = local.ip_configuration

  copy_paste_enabled        = var.copy_paste_enabled
  file_copy_enabled         = var.file_copy_enabled
  ip_connect_enabled        = var.ip_connect_enabled
  shareable_link_enabled    = var.shareable_link_enabled
  kerberos_enabled          = var.kerberos_enabled
  tunneling_enabled         = var.tunneling_enabled
  session_recording_enabled = var.session_recording_enabled

  tags = local.tags
}