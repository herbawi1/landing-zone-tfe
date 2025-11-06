data "azurerm_subnet" "inboundDnsResolverSubnet" {
  name                 = "inboundDnsResolverSubnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = var.virtual_network.name
}

data "azurerm_subnet" "outboundDnsResolverSubnet" {
  name                 = "outboundDnsResolverSubnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = var.virtual_network.name
}
