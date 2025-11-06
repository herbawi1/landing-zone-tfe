output "containers" {
  description = "Map of storage containers that are created."
  value       = module.avm-res-storage-storageaccount.containers
}
output "fqdn" {
  description = "Fqdns for storage services."
  value       = module.avm-res-storage-storageaccount.fqdn
}
output "name" {
  description = "The name of the storage account."
  value       = module.avm-res-storage-storageaccount.name
}
output "private_endpoints" {
  description = "A map of private endpoints. The map key is the supplied input to var.private_endpoints. The map value is the entire azurerm_private_endpoint resource."
  value       = module.avm-res-storage-storageaccount.private_endpoints
}
output "queues" {
  description = "Map of storage queues that are created."
  value       = module.avm-res-storage-storageaccount.queues
}
output "resource" {
  description = "This is the full resource output for the Storage Account resource."
  value       = module.avm-res-storage-storageaccount.resource
}
output "resource_id" {
  description = "The ID of the Storage Account."
  value       = module.avm-res-storage-storageaccount.resource_id
}
output "shares" {
  description = "Map of storage storage shares that are created."
  value       = module.avm-res-storage-storageaccount.shares
}
output "tables" {
  description = "Map of storage tables that are created."
  value       = module.avm-res-storage-storageaccount.tables
}
