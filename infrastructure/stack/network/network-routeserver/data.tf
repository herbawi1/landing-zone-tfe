# Data source for RouteServerSubnet lookup if not provided directly
data "azurerm_subnet" "routeserver" {
  name                 = "RouteServerSubnet"
  virtual_network_name = var.virtual_network.resource.name
  resource_group_name  = var.resource_group.resource.name
}
