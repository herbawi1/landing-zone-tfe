data "azurerm_subnet" "firewall_sub" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group.resource.name
  virtual_network_name = var.virtual_network.resource.name
}
data "azurerm_subnet" "firewall_management_sub" {
  name                 = "AzureFirewallManagementSubnet"
  resource_group_name  = var.resource_group.resource.name
  virtual_network_name = var.virtual_network.resource.name
}
