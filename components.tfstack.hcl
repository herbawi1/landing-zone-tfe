component "resourcegroup" {
  source = "infrastructure/stack/avm/resources/resourcegroup"
  inputs = {
    tenant_id = var.tenant_id
    subscription_id = var.subscription_id

    customer_name = var.customer_name
    project_name = var.project_name
    project_env = var.project_env
    project_region = var.project_region

    default_tags = var.default_tags

    location = var.location
    name = var.name
    lock_kind = var.lock_kind
    tags = var.tags
  }
  providers = {
    azurerm = provider.azurerm.this
  }
}
# component "network" {
#   source = "infrastructure/stack/avm/network/virtualnetwork"
#   inputs = {
#     resource_group = output.resourcegroup
#
#   }
#   providers = {
#     azurerm = provider.azurerm.this
#   }
#   depens_on = [
#     comp
#   ]
# }