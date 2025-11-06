# Data source for subnet lookup by name if names provided in subnets variable
data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network.resource.name
  resource_group_name = var.resource_group.resource.name
}

data "azurerm_subnet" "subnets" {
  for_each             = toset(data.azurerm_virtual_network.vnet.subnets)
  name                 = each.value
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name

}
