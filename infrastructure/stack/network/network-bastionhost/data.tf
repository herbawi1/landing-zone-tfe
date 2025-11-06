data "azurerm_subnet" "this" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = var.virtual_network.name
}
