#----------------------------------------------
# Project-wide Variables
#----------------------------------------------
variable "tenant_id" {
  description = "The Azure tenant ID."
  type        = string
  default     = ""
}
variable "subscription_id" {
  description = "The Azure subscription ID."
  type        = string
  default     = ""
}
#----------------------------------------------
# Project Metadata Variables
#----------------------------------------------
variable "project_name" {
  description = "The name of the project, used as a prefix for resources."
  type        = string
  default     = ""
}
variable "customer_name" {
  description = "The name of the customer, used as a prefix for resources."
  type        = string
  default     = ""
}
variable "project_region" {
  description = "The region for the project resources."
  type        = string
  default     = ""
}
variable "project_env" {
  description = "The environment for the project (e.g., dev, prd)."
  type        = string
  default     = ""
}
variable "default_tags" {
  description = "A map of default tags to apply to all resources."
  type        = map(string)
  default     = {}
}
variable "enable_telemetry" {
  description = "Enable telemetry for the module.  this sends anonymous data to Microsoft to help improve the module over time. Please see the module documentation for more details."
  type        = bool
  default     = false
}

#----------------------------------------------
# Resource Group Variables
#----------------------------------------------
variable "resource_group" {
  description = "The resource group object where the storage account will be created."
  type        = any
  default     = null
}



#----------------------------------------------
# Azure Storage Account Variables
#----------------------------------------------
variable "resource_group_name" {
  description = "The name of the resource group where the storage account will be created."
  type        = string
  default     = null
}

variable "location" {
  description = "The Azure region where the storage account will be created."
  type        = string
  default     = ""
}
variable "name" {
  description = "The name of the Azure storage account."
  type        = string
  default     = ""
}
variable "tags" {
  description = "A map of tags to assign to the storage account."
  type        = map(string)
  default     = {}
}
variable "lock" {
  description = "Enable a lock on the storage account to prevent accidental deletion."
  type = object({
    kind = string
    name = optional(string, null)
  })
  default = null
}
variable "lock_kind" {
  description = "The type of lock to apply. Possible values are 'CanNotDelete' and 'ReadOnly' "
  type        = string
  default     = null
}
variable "lock_name" {
  description = "The name of the lock. If not provided, a default name will be generated."
  type        = string
  default     = ""
}
variable "role_assignments" {
  description = "A map of role assignments for the storage account."
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
  default = {}
}
variable "account_kind" {
  description = "(Optional) Defines the Kind of account. Valid options are `BlobStorage`, `BlockBlobStorage`, `FileStorage`, `Storage` and `StorageV2`. Defaults to `StorageV2`."
  type        = string
  default     = "StorageV2"
}
variable "account_replication_type" {
  description = "(Required) Defines the type of replication to use for this storage account. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`.  Defaults to `ZRS`"
  type        = string
  default     = "ZRS"
}
variable "account_tier" {
  description = "(Required) Defines the Tier to use for this storage account. Valid options are `Standard` and `Premium`. For `BlockBlobStorage` and `FileStorage` accounts only `Premium` is valid. Changing this forces a new resource to be created."
  type        = string
  default     = "Standard"
}
variable "access_tier" {
  description = "(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot, Cool, Cold and Premium. Defaults to Hot."
  type        = string
  default     = "Hot"
}
variable "allow_nested_items_to_be_public" {
  description = "(Optional) Allow or disallow nested items within this Account to opt into being public. Defaults to `false`."
  type        = bool
  default     = false
}
variable "azure_files_authentication" {
  description = "- `directory_type` - (Required) Specifies the directory service used. Possible values are `AADDS`, `AD` and `AADKERB`.\n\n- `default_share_level_permission` - (Optional) Specifies the default share level permissions applied to all users. Possible values are StorageFileDataSmbShareReader, StorageFileDataSmbShareContributor, StorageFileDataSmbShareElevatedContributor, or None.\n\n`active_directory` block supports the following:\n\n- `domain_guid` - (Required) Specifies the domain GUID.\n- `domain_name` - (Required) Specifies the primary domain that the AD DNS server is authoritative for.\n- `domain_sid` - (Required) Specifies the security identifier (SID).\n- `forest_name` - (Required) Specifies the Active Directory forest.\n- `netbios_domain_name` - (Required) Specifies the NetBIOS domain name.\n- `storage_sid` - (Required) Specifies the security identifier (SID) for Azure Storage."
  type = object({
    directory_type                 = optional(string, "AADKERB")
    default_share_level_permission = optional(string)

    active_directory = optional(object({
      domain_guid         = string
      domain_name         = string
      domain_sid          = string
      forest_name         = string
      netbios_domain_name = string
      storage_sid         = string
    }))
  })
  default = null
}
variable "blob_properties" {
  description = "- `change_feed_enabled` - (Optional) Is the blob service properties for change feed events enabled? Default to `false`.\n\n- `change_feed_retention_in_days` - (Optional) The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years). Setting this to null (or omit this in the configuration file) indicates an infinite retention of the change feed.\n- `default_service_version` - (Optional) The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version.\n- `last_access_time_enabled` - (Optional) Is the last access time based tracking enabled? Default to `false`.\n- `versioning_enabled` - (Optional) Is versioning enabled? Default to `false`.\n\n---\n\n`container_delete_retention_policy` block supports the following:\n\n- `days` - (Optional) Specifies the number of days that the container should be retained, between `1` and `365` days. Defaults to `7`.\n\n---\n\n`cors_rule` block supports the following:\n\n- `allowed_headers` - (Required) A list of headers that are allowed to be a part of the cross-origin request.\n- `allowed_methods` - (Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are `DELETE`, `GET`, `HEAD`, `MERGE`, `POST`, `OPTIONS`, `PUT` or `PATCH`.\n- `allowed_origins` - (Required) A list of origin domains that will be allowed by CORS.\n- `exposed_headers` - (Required) A list of response headers that are exposed to CORS clients.\n- `max_age_in_seconds` - (Required) The number of seconds the client should cache a preflight response.\n\n---\n\n`delete_retention_policy` block supports the following:\n\n- `days` - (Optional) Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7`.\n\n---\n\n`diagnostic_settings` block supports the following:\n\n- `name` - (Optional) The name of the diagnostic setting. Defaults to `null`.\n- `log_categories` - (Optional) A set of log categories to enable. Defaults to an empty set.\n- `log_groups` - (Optional) A set of log groups to enable. Defaults to `[\"allLogs\"]`.\n- `metric_categories` - (Optional) A set of metric categories to enable. Defaults to `[\"AllMetrics\"]`.\n- `log_analytics_destination_type` - (Optional) The destination type for log analytics. Defaults to `\"Dedicated\"`.\n- `workspace_resource_id` - (Optional) The resource ID of the Log Analytics workspace. Defaults to `null`.\n- `resource_id` - (Optional) The resource ID of the target resource for diagnostics. Defaults to `null`.\n- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the Event Hub authorization rule. Defaults to `null`.\n- `event_hub_name` - (Optional) The name of the Event Hub. Defaults to `null`.\n- `marketplace_partner_resource_id` - (Optional) The resource ID of the marketplace partner. Defaults to `null`.\n\n---\n\n`restore_policy` block supports the following:\n\n- `days` - (Required) Specifies the number of days that the blob can be restored, between `1` and `365` days. This must be less than the `days` specified for `delete_retention_policy`."
  type = object({
    change_feed_enabled           = optional(bool)
    change_feed_retention_in_days = optional(number)
    default_service_version       = optional(string)
    last_access_time_enabled      = optional(bool)
    versioning_enabled            = optional(bool, true)
    container_delete_retention_policy = optional(object({
      days = optional(number, 7)

    }), { days = 7 })

    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))
    delete_retention_policy = optional(object({
      days = optional(number, 7)
    }), { days = 7 })
    diagnostic_settings = optional(map(object({
      name                                     = optional(string, null)
      log_categories                           = optional(set(string), [])
      log_groups                               = optional(set(string), ["allLogs"])
      metric_categories                        = optional(set(string), ["AllMetrics"])
      log_analytics_destination_type           = optional(string, "Dedicated")
      workspace_resource_id                    = optional(string, null)
      resource_id                              = optional(string, null)
      event_hub_authorization_rule_resource_id = optional(string, null)
      event_hub_name                           = optional(string, null)
      marketplace_partner_resource_id          = optional(string, null)
    })), {})
    restore_policy = optional(object({
      days = number
    }))
  })
  default = null
}
variable "containers" {
  description = "- `container_access_type` - (Optional) The Access Level configured for this Container. Possible values are `Blob`, `Container` or `None`. Defaults to `None`.\n\n- `metadata` - (Optional) A mapping of MetaData for this Container. All metadata keys should be lowercase.\n- `name` - (Required) The name of the Container which should be created within the Storage Account. Changing this forces a new resource to be created.\n\nSupply role assignments in the same way as for `var.role_assignments`.\n\n---\n\n`timeouts` block supports the following:\n\n- `create` - (Defaults to 30 minutes) Used when creating the Storage Container.\n- `delete` - (Defaults to 30 minutes) Used when deleting the Storage Container.\n- `read` - (Defaults to 5 minutes) Used when retrieving the Storage Container.\n- `update` - (Defaults to 30 minutes) Used when updating the Storage Container."
  type = map(object({
    public_access                  = optional(string, "None")
    metadata                       = optional(map(string))
    name                           = string
    default_encryption_scope       = optional(string)
    deny_encryption_scope_override = optional(bool)
    enable_nfs_v3_all_squash       = optional(bool)
    enable_nfs_v3_root_squash      = optional(bool)
    immutable_storage_with_versioning = optional(object({
      enabled = bool
    }))

    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
    })), {})

    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  default = {}
}
variable "cross_tenant_replication_enabled" {
  description = "(Optional) Should cross Tenant replication be enabled? Defaults to `false`."
  type        = bool
  default     = false
}
variable "custom_domain" {
  description = "- `name` - (Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.\n\n- `use_subdomain` - (Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?"
  type = object({
    name          = string
    use_subdomain = optional(bool)
  })
  default = null
}
variable "customer_managed_key" {
  description = "    Defines a customer managed key to use for encryption.\n\n    object({\n      key_vault_resource_id              = (Required) - The full Azure Resource ID of the key_vault where the customer managed key will be referenced from.\n      key_name                           = (Required) - The key name for the customer managed key in the key vault.\n      key_version                        = (Optional) - The version of the key to use\n      user_assigned_identity_resource_id = (Optional) - The user assigned identity to use when access the key vault\n    })\n    \n    Example Inputs:\n    ```terraform\n    customer_managed_key = {\n      key_vault_resource_id = \"/subscriptions/0000000-0000-0000-0000-000000000000/resourceGroups/test-resource-group/providers/Microsoft.KeyVault/vaults/example-key-vault\"\n      key_name              = \"sample-customer-key\"\n    }\n    ```"
  type = object({
    key_vault_resource_id = string
    key_name              = string
    key_version           = optional(string, null)
    user_assigned_identity = optional(object({
      resource_id = string
    }), null)
  })
  default = null
}
variable "default_to_oauth_authentication" {
  description = "(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is `false`"
  type        = bool
  default     = null
}
variable "diagnostic_settings_blob" {
  description = "A map of diagnostic settings to create on the Blob Storage within Storage Account. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.\n\n- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.\n- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.\n- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `[\"allLogs\"]`.\n- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `[\"AllMetrics\"]`.\n- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.\n- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.\n- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.\n- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.\n- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.\n- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs."
  type = map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
  default = {}
}
variable "diagnostic_settings_file" {
  description = "A map of diagnostic settings to create on the Azure Files Storage within Storage Account. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.\n\n- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.\n- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.\n- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `[\"allLogs\"]`.\n- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `[\"AllMetrics\"]`.\n- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.\n- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.\n- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.\n- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.\n- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.\n- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs."
  type = map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
  default = {}
}
variable "diagnostic_settings_queue" {
  description = "A map of diagnostic settings to create on the Queue Storage within Storage Account. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.\n\n- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.\n- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.\n- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `[\"allLogs\"]`.\n- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `[\"AllMetrics\"]`.\n- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.\n- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.\n- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.\n- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.\n- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.\n- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs."
  type = map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
  default = {}
}
variable "diagnostic_settings_storage_account" {
  description = "A map of diagnostic settings to create on the Storage Account. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.\n\n- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.\n- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.\n- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `[\"allLogs\"]`.\n- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `[\"AllMetrics\"]`.\n- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.\n- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.\n- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.\n- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.\n- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.\n- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs."
  type = map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
  default = {}
}
variable "diagnostic_settings_table" {
  description = "A map of diagnostic settings to create on the Table Storage within the Storage Account. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.\n\n- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.\n- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.\n- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `[\"allLogs\"]`.\n- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `[\"AllMetrics\"]`.\n- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.\n- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.\n- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.\n- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.\n- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.\n- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs."
  type = map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
  default = {}
}
variable "edge_zone" {
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created."
  type        = string
  default     = null
}
variable "https_traffic_only_enabled" {
  description = "(Optional) Boolean flag which forces HTTPS if enabled, see [here](https://docs.microsoft.com/azure/storage/storage-require-secure-transfer/) for more information. Defaults to `true`."
  type        = bool
  default     = true
}
variable "immutability_policy" {
  description = "- `allow_protected_append_writes` - (Required) When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted.\n\n- `period_since_creation_in_days` - (Required) The immutability period for the blobs in the container since the policy creation, in days.\n- `state` - (Required) Defines the mode of the policy. `Disabled` state disables the policy, `Unlocked` state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property, `Locked` state only allows the increase of the immutability retention time. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states. Only a policy in an Unlocked state can transition to a Locked state which cannot be reverted."
  type = object({
    allow_protected_append_writes = bool
    period_since_creation_in_days = number
    state                         = string
  })
  default = null
}
variable "infrastructure_encryption_enabled" {
  description = "(Optional) Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to `false`."
  type        = bool
  default     = false
}
variable "is_hns_enabled" {
  description = "(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 ([see here for more information](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-quickstart-create-account/)). Changing this forces a new resource to be created."
  type        = bool
  default     = null
}
variable "large_file_share_enabled" {
  description = "(Optional) Is Large File Share Enabled?"
  type        = bool
  default     = null
}
variable "local_user" {
  description = "- `home_directory` - (Optional) The home directory of the Storage Account Local User.\n\n- `name` - (Required) The name which should be used for this Storage Account Local User. Changing this forces a new Storage Account Local User to be created.\n- `ssh_key_enabled` - (Optional) Specifies whether SSH Key Authentication is enabled. Defaults to `false`.\n- `ssh_password_enabled` - (Optional) Specifies whether SSH Password Authentication is enabled. Defaults to `false`.\n\n---\n\n`permission_scope` block supports the following:\n\n- `resource_name` - (Required) The container name (when `service` is set to `blob`) or the file share name (when `service` is set to `file`), used by the Storage Account Local User.\n- `service` - (Required) The storage service used by this Storage Account Local User. Possible values are `blob` and `file`.\n\n---\n\n`permissions` block supports the following:\n\n- `create` - (Optional) Specifies if the Local User has the create permission for this scope. Defaults to `false`.\n- `delete` - (Optional) Specifies if the Local User has the delete permission for this scope. Defaults to `false`.\n- `list` - (Optional) Specifies if the Local User has the list permission for this scope. Defaults to `false`.\n- `read` - (Optional) Specifies if the Local User has the read permission for this scope. Defaults to `false`.\n- `write` - (Optional) Specifies if the Local User has the write permission for this scope. Defaults to `false`.\n\n---\n\n`ssh_authorized_key` block supports the following:\n\n- `description` - (Optional) The description of this SSH authorized key.\n- `key` - (Required) The public key value of this SSH authorized key.\n\n---\n\n`timeouts` block supports the following:\n\n- `create` - (Defaults to 30 minutes) Used when creating the Storage Account Local User.\n- `delete` - (Defaults to 30 minutes) Used when deleting the Storage Account Local User.\n- `read` - (Defaults to 5 minutes) Used when retrieving the Storage Account Local User.\n- `update` - (Defaults to 30 minutes) Used when updating the Storage Account Local User."
  type = map(object({
    home_directory       = optional(string)
    name                 = string
    ssh_key_enabled      = optional(bool)
    ssh_password_enabled = optional(bool)
    permission_scope = optional(list(object({
      resource_name = string
      service       = string
      permissions = object({
        create = optional(bool)
        delete = optional(bool)
        list   = optional(bool)
        read   = optional(bool)
        write  = optional(bool)
      })
    })))
    ssh_authorized_key = optional(list(object({
      description = optional(string)
      key         = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  default = {}
}
variable "local_user_enabled" {
  description = "(Optional) Should Storage Account Local Users be enabled? Defaults to `false`."
  type        = bool
  default     = false
}
variable "managed_identities" {
  description = "  Controls the Managed Identity configuration on this resource. The following properties can be specified:\n\n- `system_assigned` - (Optional) Specifies if the System Assigned Managed Identity should be enabled.\n- `user_assigned_resource_ids` - (Optional) Specifies a list of User Assigned Managed Identity resource IDs to be assigned to this resource."
  type = object({
    system_assigned            = optional(bool, false)
    user_assigned_resource_ids = optional(set(string), [])
  })
  default = {}
}
variable "min_tls_version" {
  description = "(Optional) The minimum supported TLS version for the storage account. Possible values are `TLS1_0`, `TLS1_1`, and `TLS1_2`. Defaults to `TLS1_2` for new storage accounts."
  type        = string
  default     = "TLS1_2"
}
variable "network_rules" {
  description = "> Note the default value for this variable will block all public access to the storage account. If you want to disable all network rules, set this value to `null`.\n\n- `bypass` - (Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of `Logging`, `Metrics`, `AzureServices`, or `None`.\n- `default_action` - (Required) Specifies the default action of allow or deny when no other rules match. Valid options are `Deny` or `Allow`.\n- `ip_rules` - (Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in [RFC 1918](https://tools.ietf.org/html/rfc1918#section-3)) are not allowed.\n- `storage_account_id` - (Required) Specifies the ID of the storage account. Changing this forces a new resource to be created.\n- `virtual_network_subnet_ids` - (Optional) A list of virtual network subnet ids to secure the storage account.\n\n---\n\n`private_link_access` block supports the following:\n\n- `endpoint_resource_id` - (Required) The resource id of the resource access rule to be granted access.\n- `endpoint_tenant_id` - (Optional) The tenant id of the resource of the resource access rule to be granted access. Defaults to the current tenant id.\n\n---\n\n`timeouts` block supports the following:\n\n- `create` - (Defaults to 60 minutes) Used when creating the  Network Rules for this Storage Account.\n- `delete` - (Defaults to 60 minutes) Used when deleting the Network Rules for this Storage Account.\n- `read` - (Defaults to 5 minutes) Used when retrieving the Network Rules for this Storage Account.\n- `update` - (Defaults to 60 minutes) Used when updating the Network Rules for this Storage Account."
  type = object({
    bypass                     = optional(set(string), ["AzureServices"])
    default_action             = optional(string, "Deny")
    ip_rules                   = optional(set(string), [])
    virtual_network_subnet_ids = optional(set(string), [])
    private_link_access = optional(list(object({
      endpoint_resource_id = string
      endpoint_tenant_id   = optional(string)
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  })
  default = {}
}
variable "nfsv3_enabled" {
  description = "(Optional) Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to `false`."
  type        = bool
  default     = false
}
variable "private_endpoints" {
  description = "A map of private endpoints to create on the resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.\n\n- `name` - (Optional) The name of the private endpoint. One will be generated if not set.\n- `role_assignments` - (Optional) A map of role assignments to create on the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time. See `var.role_assignments` for more information.\n- `lock` - (Optional) The lock level to apply to the private endpoint. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`.\n- `tags` - (Optional) A mapping of tags to assign to the private endpoint.\n- `subnet_resource_id` - The resource ID of the subnet to deploy the private endpoint in.\n- `subresource_name` - The service name of the private endpoint.  Possible value are `blob`, 'dfs', 'file', `queue`, `table`, and `web`.\n- `private_dns_zone_group_name` - (Optional) The name of the private DNS zone group. One will be generated if not set.\n- `private_dns_zone_resource_ids` - (Optional) A set of resource IDs of private DNS zones to associate with the private endpoint. If not set, no zone groups will be created and the private endpoint will not be associated with any private DNS zones. DNS records must be managed external to this module.\n- `application_security_group_resource_ids` - (Optional) A map of resource IDs of application security groups to associate with the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.\n- `private_service_connection_name` - (Optional) The name of the private service connection. One will be generated if not set.\n- `network_interface_name` - (Optional) The name of the network interface. One will be generated if not set.\n- `location` - (Optional) The Azure location where the resources will be deployed. Defaults to the location of the resource group.\n- `resource_group_name` - (Optional) The resource group where the resources will be deployed. Defaults to the resource group of the resource.\n- `ip_configurations` - (Optional) A map of IP configurations to create on the private endpoint. If not specified the platform will create one. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.\n  - `name` - The name of the IP configuration.\n  - `private_ip_address` - The private IP address of the IP configuration."
  type = map(object({
    name = optional(string, null)
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
      principal_type                         = optional(string, null)
    })), {})
    lock = optional(object({
      kind = string
      name = optional(string, null)
    }), null)
    tags                                    = optional(map(string), null)
    subnet_resource_id                      = string
    subresource_name                        = string
    private_dns_zone_group_name             = optional(string, "default")
    private_dns_zone_resource_ids           = optional(set(string), [])
    application_security_group_associations = optional(map(string), {})
    private_service_connection_name         = optional(string, null)
    network_interface_name                  = optional(string, null)
    location                                = optional(string, null)
    resource_group_name                     = optional(string, null)
    ip_configurations = optional(map(object({
      name               = string
      private_ip_address = string
    })), {})
  }))
  default = {}
}
variable "private_endpoints_manage_dns_zone_group" {
  description = "Whether to manage private DNS zone groups with this module. If set to false, you must manage private DNS zone groups externally, e.g. using Azure Policy."
  type        = bool
  default     = true
}
variable "public_network_access_enabled" {
  description = "(Optional) Whether the public network access is enabled? Defaults to `false`."
  type        = bool
  default     = false
}
variable "queue_encryption_key_type" {
  description = "(Optional) The encryption type of the queue service. Possible values are `Service` and `Account`. Changing this forces a new resource to be created. Default value is `Service`."
  type        = string
  default     = null
}
variable "queue_properties" {
  description = "Azure Queue Properties configuration."
  type = map(object({
    cors_rule = optional(map(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })), {})
    hour_metrics = optional(object({
      include_apis          = optional(bool)
      retention_policy_days = optional(number)
      version               = string
    }))
    logging = optional(object({
      delete                = bool
      read                  = bool
      retention_policy_days = optional(number)
      version               = string
      write                 = bool
    }))
    minute_metrics = optional(object({
      include_apis          = optional(bool)
      retention_policy_days = optional(number)
      version               = string
    }))
  }))
  default = {}
}
variable "queues" {
  description = "- `metadata` - (Optional) A mapping of MetaData which should be assigned to this Storage Queue.\n\n- `name` - (Required) The name of the Queue which should be created within the Storage Account. Must be unique within the storage account the queue is located. Changing this forces a new resource to be created.\n\nSupply role assignments in the same way as for `var.role_assignments`.\n\n---\n\n`timeouts` block supports the following:\n\n- `create` - (Defaults to 30 minutes) Used when creating the Storage Queue.\n- `delete` - (Defaults to 30 minutes) Used when deleting the Storage Queue.\n- `read` - (Defaults to 5 minutes) Used when retrieving the Storage Queue.\n- `update` - (Defaults to 30 minutes) Used when updating the Storage Queue."
  type = map(object({
    metadata = optional(map(string))
    name     = string
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
    })), {})
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  default = {}
}
variable "routing" {
  description = "- `choice` - (Optional) Specifies the kind of network routing opted by the user. Possible values are `InternetRouting` and `MicrosoftRouting`. Defaults to `MicrosoftRouting`.\n\n- `publish_internet_endpoints` - (Optional) Should internet routing storage endpoints be published? Defaults to `false`.\n- `publish_microsoft_endpoints` - (Optional) Should Microsoft routing storage endpoints be published? Defaults to `false`."
  type = object({
    choice                      = optional(string, "MicrosoftRouting")
    publish_internet_endpoints  = optional(bool, false)
    publish_microsoft_endpoints = optional(bool, false)
  })
  default = null
}
variable "sas_policy" {
  description = "- `expiration_action` - (Optional) The SAS expiration action. The only possible value is `Log` at this moment. Defaults to `Log`.\n\n- `expiration_period` - (Required) The SAS expiration period in format of `DD.HH:MM:SS`."
  type = object({
    expiration_action = optional(string, "Log")
    expiration_period = string
  })
  default = null
}
variable "share_properties" {
  description = "Azure File Share Properties configuration."
  type = object({
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))
    retention_policy = optional(object({
      days = optional(number)
    }))
    smb = optional(object({
      authentication_types            = optional(set(string))
      channel_encryption_type         = optional(set(string))
      kerberos_ticket_encryption_type = optional(set(string))
      multichannel_enabled            = optional(bool)
      versions                        = optional(set(string))
    }))
  })
  default = null
}
variable "shared_access_key_enabled" {
  description = "(Optional) Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is `false`."
  type        = bool
  default     = false
}
variable "static_website" {
  description = "- `error_404_document` - (Optional) The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.\n\n- `index_document` - (Optional) The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive."
  type = map(object({
    error_404_document = optional(string)
    index_document     = optional(string)
  }))
  default = null
}
variable "storage_data_lake_gen2_filesystems" {
  description = "- `default_encryption_scope` - (Optional) The default encryption scope to use for this filesystem. Changing this forces a new resource to be created.\n\n- `group` - (Optional) Specifies the Object ID of the Azure Active Directory Group to make the owning group of the root path (i.e. `/`). Possible values also include `$superuser`.\n- `name` - (Required) The name of the Data Lake Gen2 File System which should be created within the Storage Account. Must be unique within the storage account the queue is located. Changing this forces a new resource to be created.\n- `owner` - (Optional) Specifies the Object ID of the Azure Active Directory User to make the owning user of the root path (i.e. `/`). Possible values also include `$superuser`.\n- `properties` - (Optional) A mapping of Key to Base64-Encoded Values which should be assigned to this Data Lake Gen2 File System.\n\n---\n\n`ace` block supports the following:\n\n- `id` - (Optional) Specifies the Object ID of the Azure Active Directory User or Group that the entry relates to. Only valid for `user` or `group` entries.\n- `permissions` - (Required) Specifies the permissions for the entry in `rwx` form. For example, `rwx` gives full permissions but `r--` only gives read permissions.\n- `scope` - (Optional) Specifies whether the ACE represents an `access` entry or a `default` entry. Default value is `access`.\n- `type` - (Required) Specifies the type of entry. Can be `user`, `group`, `mask` or `other`.\n\n---\n\n`timeouts` block supports the following:\n\n- `create` - (Defaults to 30 minutes) Used when creating the Data Lake Gen2 File System.\n- `delete` - (Defaults to 30 minutes) Used when deleting the Data Lake Gen2 File System.\n- `read` - (Defaults to 5 minutes) Used when retrieving the Data Lake Gen2 File System.\n- `update` - (Defaults to 30 minutes) Used when updating the Data Lake Gen2 File System."
  type = map(object({
    default_encryption_scope = optional(string)
    group                    = optional(string)
    name                     = string
    owner                    = optional(string)
    properties               = optional(map(string))
    ace = optional(set(object({
      id          = optional(string)
      permissions = string
      scope       = optional(string)
      type        = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  default = {}
}
variable "storage_management_policy_rule" {
  description = "- `enabled` - (Required) Boolean to specify whether the rule is enabled.\n\n- `name` - (Required) The name of the rule. Rule name is case-sensitive. It must be unique within a policy.\n\n---\n\n`actions` block supports the following:\n\n---\n\n`base_blob` block supports the following:\n\n- `auto_tier_to_hot_from_cool_enabled` - (Optional) Whether a blob should automatically be tiered from cool back to hot if it's accessed again after being tiered to cool. Defaults to `false`.\n- `delete_after_days_since_creation_greater_than` - (Optional) The age in days after creation to delete the blob. Must be between `0` and `99999`. Defaults to `-1`.\n- `delete_after_days_since_last_access_time_greater_than` - (Optional) The age in days after last access time to delete the blob. Must be between `0` and `99999`. Defaults to `-1`.\n- `delete_after_days_since_modification_greater_than` - (Optional) The age in days after last modification to delete the blob. Must be between 0 and 99999. Defaults to `-1`.\n- `tier_to_archive_after_days_since_creation_greater_than` - (Optional) The age in days after creation to archive storage. Supports blob currently at Hot or Cool tier. Must be between `0` and`99999`. Defaults to `-1`.\n- `tier_to_archive_after_days_since_last_access_time_greater_than` - (Optional) The age in days after last access time to tier blobs to archive storage. Supports blob currently at Hot or Cool tier. Must be between `0` and`99999`. Defaults to `-1`.\n- `tier_to_archive_after_days_since_last_tier_change_greater_than` - (Optional) The age in days after last tier change to the blobs to skip to be archved. Must be between 0 and 99999. Defaults to `-1`.\n- `tier_to_archive_after_days_since_modification_greater_than` - (Optional) The age in days after last modification to tier blobs to archive storage. Supports blob currently at Hot or Cool tier. Must be between 0 and 99999. Defaults to `-1`.\n- `tier_to_cold_after_days_since_creation_greater_than` - (Optional) The age in days after creation to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`. Defaults to `-1`.\n- `tier_to_cold_after_days_since_last_access_time_greater_than` - (Optional) The age in days after last access time to tier blobs to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`. Defaults to `-1`.\n- `tier_to_cold_after_days_since_modification_greater_than` - (Optional) The age in days after last modification to tier blobs to cold storage. Supports blob currently at Hot tier. Must be between 0 and 99999. Defaults to `-1`.\n- `tier_to_cool_after_days_since_creation_greater_than` - (Optional) The age in days after creation to cool storage. Supports blob currently at Hot tier. Must be between `0` and `99999`. Defaults to `-1`.\n- `tier_to_cool_after_days_since_last_access_time_greater_than` - (Optional) The age in days after last access time to tier blobs to cool storage. Supports blob currently at Hot tier. Must be between `0` and `99999`. Defaults to `-1`.\n- `tier_to_cool_after_days_since_modification_greater_than` - (Optional) The age in days after last modification to tier blobs to cool storage. Supports blob currently at Hot tier. Must be between 0 and 99999. Defaults to `-1`.\n\n---\n\n`snapshot` block supports the following:\n\n- `change_tier_to_archive_after_days_since_creation` - (Optional) The age in days after creation to tier blob snapshot to archive storage. Must be between 0 and 99999. Defaults to `-1`.\n- `change_tier_to_cool_after_days_since_creation` - (Optional) The age in days after creation to tier blob snapshot to cool storage. Must be between 0 and 99999. Defaults to `-1`.\n- `delete_after_days_since_creation_greater_than` - (Optional) The age in days after creation to delete the blob snapshot. Must be between 0 and 99999. Defaults to `-1`.\n- `tier_to_archive_after_days_since_last_tier_change_greater_than` - (Optional) The age in days after last tier change to the blobs to skip to be archved. Must be between 0 and 99999. Defaults to `-1`.\n- `tier_to_cold_after_days_since_creation_greater_than` - (Optional) The age in days after creation to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`. Defaults to `-1`.\n\n---\n\n`version` block supports the following:\n\n- `change_tier_to_archive_after_days_since_creation` - (Optional) The age in days after creation to tier blob version to archive storage. Must be between 0 and 99999. Defaults to `-1`.\n- `change_tier_to_cool_after_days_since_creation` - (Optional) The age in days after creation to tier blob version to cool storage. Must be between 0 and 99999. Defaults to `-1`.\n- `delete_after_days_since_creation` - (Optional) The age in days after creation to delete the blob version. Must be between 0 and 99999. Defaults to `-1`.\n- `tier_to_archive_after_days_since_last_tier_change_greater_than` - (Optional) The age in days after last tier change to the blobs to skip to be archved. Must be between 0 and 99999. Defaults to `-1`.\n- `tier_to_cold_after_days_since_creation_greater_than` - (Optional) The age in days after creation to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`. Defaults to `-1`.\n\n---\n\n`filters` block supports the following:\n\n- `blob_types` - (Required) An array of predefined values. Valid options are `blockBlob` and `appendBlob`.\n- `prefix_match` - (Optional) An array of strings for prefixes to be matched.\n\n---\n\n`match_blob_index_tag` block supports the following:\n\n- `name` - (Required) The filter tag name used for tag based filtering for blob objects.\n- `operation` - (Optional) The comparison operator which is used for object comparison and filtering. Possible value is `==`. Defaults to `==`.\n- `value` - (Required) The filter tag value used for tag based filtering for blob objects."
  type = map(object({
    enabled = bool
    name    = string
    actions = object({
      base_blob = optional(object({
        auto_tier_to_hot_from_cool_enabled                             = optional(bool)
        delete_after_days_since_creation_greater_than                  = optional(number)
        delete_after_days_since_last_access_time_greater_than          = optional(number)
        delete_after_days_since_modification_greater_than              = optional(number)
        tier_to_archive_after_days_since_creation_greater_than         = optional(number)
        tier_to_archive_after_days_since_last_access_time_greater_than = optional(number)
        tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)
        tier_to_archive_after_days_since_modification_greater_than     = optional(number)
        tier_to_cold_after_days_since_creation_greater_than            = optional(number)
        tier_to_cold_after_days_since_last_access_time_greater_than    = optional(number)
        tier_to_cold_after_days_since_modification_greater_than        = optional(number)
        tier_to_cool_after_days_since_creation_greater_than            = optional(number)
        tier_to_cool_after_days_since_last_access_time_greater_than    = optional(number)
        tier_to_cool_after_days_since_modification_greater_than        = optional(number)
      }))
      snapshot = optional(object({
        change_tier_to_archive_after_days_since_creation               = optional(number)
        change_tier_to_cool_after_days_since_creation                  = optional(number)
        delete_after_days_since_creation_greater_than                  = optional(number)
        tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)
        tier_to_cold_after_days_since_creation_greater_than            = optional(number)
      }))
      version = optional(object({
        change_tier_to_archive_after_days_since_creation               = optional(number)
        change_tier_to_cool_after_days_since_creation                  = optional(number)
        delete_after_days_since_creation                               = optional(number)
        tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)
        tier_to_cold_after_days_since_creation_greater_than            = optional(number)
      }))
    })
    filters = object({
      blob_types   = set(string)
      prefix_match = optional(set(string))
      match_blob_index_tag = optional(set(object({
        name      = string
        operation = optional(string)
        value     = string
      })))
    })
  }))
  default = {}
}
variable "storage_management_policy_timeouts" {
  description = "- `create` - (Defaults to 30 minutes) Used when creating the Storage Account Management Policy.\n\n- `delete` - (Defaults to 30 minutes) Used when deleting the Storage Account Management Policy.\n\n- `read` - (Defaults to 5 minutes) Used when retrieving the Storage Account Management Policy.\n\n- `update` - (Defaults to 30 minutes) Used when updating the Storage Account Management Policy."
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default = null
}
variable "table_encryption_key_type" {
  description = "(Optional) The encryption type of the table service. Possible values are `Service` and `Account`. Changing this forces a new resource to be created. Default value is `Service`."
  type        = string
  default     = null
}
variable "tables" {
  description = "- `name` - (Required) The name of the storage table. Only Alphanumeric characters allowed, starting with a letter. Must be unique within the storage account the table is located. Changing this forces a new resource to be created.\n\n---\n\n`acl` block supports the following:\n\n- `id` - (Required) The ID which should be used for this Shared Identifier.\n\n---\n\n`access_policy` block supports the following:\n\n- `expiry` - (Required) The ISO8061 UTC time at which this Access Policy should be valid until.\n- `permissions` - (Required) The permissions which should associated with this Shared Identifier.\n- `start` - (Required) The ISO8061 UTC time at which this Access Policy should be valid from.\n\n---\n\n`timeouts` block supports the following:\n\n- `create` - (Defaults to 30 minutes) Used when creating the Storage Table.\n- `delete` - (Defaults to 30 minutes) Used when deleting the Storage Table.\n- `read` - (Defaults to 5 minutes) Used when retrieving the Storage Table.\n- `update` - (Defaults to 30 minutes) Used when updating the Storage Table.\n\nSupply role assignments in the same way as for `var.role_assignments`."
  type = map(object({
    name = string
    signed_identifiers = optional(list(object({
      id = string
      access_policy = optional(object({
        expiry_time = string
        permission  = string
        start_time  = string
      }))
    })))

    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
    })), {})

    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  default = {}
}
variable "timeouts" {
  description = "- `create` - (Defaults to 60 minutes) Used when creating the Storage Account.\n\n- `delete` - (Defaults to 60 minutes) Used when deleting the Storage Account.\n\n- `read` - (Defaults to 5 minutes) Used when retrieving the Storage Account.\n\n- `update` - (Defaults to 60 minutes) Used when updating the Storage Account."
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default = null
}
