module "avm-res-storage-storageaccount" {
  source = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-res-storage-storageaccount.git?ref=v0.6.4"

  enable_telemetry = var.enable_telemetry
  tags             = local.tags

  name                = local.name
  resource_group_name = local.resource_group_name
  location            = local.location

  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type
  account_tier             = var.account_tier

  access_tier = var.access_tier

  allow_nested_items_to_be_public         = var.allow_nested_items_to_be_public
  azure_files_authentication              = var.azure_files_authentication
  blob_properties                         = var.blob_properties
  containers                              = var.containers
  cors_rules                              = var.cors_rules
  cross_tenant_replication_enabled        = var.cross_tenant_replication_enabled
  custom_domain                           = var.custom_domain
  customer_managed_key                    = var.customer_managed_key
  default_to_oauth_authentication         = var.default_to_oauth_authentication
  diagnostic_settings_blob                = var.diagnostic_settings_blob
  diagnostic_settings_file                = var.diagnostic_settings_file
  diagnostic_settings_queue               = var.diagnostic_settings_queue
  diagnostic_settings_storage_account     = var.diagnostic_settings_storage_account
  diagnostic_settings_table               = var.diagnostic_settings_table
  edge_zone                               = var.edge_zone
  https_traffic_only_enabled              = var.https_traffic_only_enabled
  immutability_policy                     = var.immutability_policy
  infrastructure_encryption_enabled       = var.infrastructure_encryption_enabled
  is_hns_enabled                          = var.is_hns_enabled
  large_file_share_enabled                = var.large_file_share_enabled
  local_user                              = var.local_user
  local_user_enabled                      = var.local_user_enabled
  min_tls_version                         = var.min_tls_version
  network_rules                           = var.network_rules
  nfsv3_enabled                           = var.nfsv3_enabled
  private_endpoints                       = var.private_endpoints
  private_endpoints_manage_dns_zone_group = var.private_endpoints_manage_dns_zone_group
  public_network_access_enabled           = var.public_network_access_enabled
  queue_encryption_key_type               = var.queue_encryption_key_type
  queue_properties                        = var.queue_properties
  queues                                  = var.queues
  routing                                 = var.routing
  sas_policy                              = var.sas_policy
  share_properties                        = var.share_properties
  shares                                  = var.shares
  shared_access_key_enabled               = var.shared_access_key_enabled
  static_website                          = var.static_website
  storage_data_lake_gen2_filesystems      = var.storage_data_lake_gen2_filesystems
  storage_management_policy_rule          = var.storage_management_policy_rule
  storage_management_policy_timeouts      = var.storage_management_policy_timeouts
  table_encryption_key_type               = var.table_encryption_key_type
  tables                                  = var.tables
  timeouts                                = var.timeouts

  lock               = local.lock
  role_assignments   = local.role_assignments
  managed_identities = var.managed_identities
}
