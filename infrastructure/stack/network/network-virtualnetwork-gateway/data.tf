data "azurerm_subnet" "this" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group.resource.name
  virtual_network_name = var.virtual_network.resource.name
}
