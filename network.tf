resource "azurerm_virtual_network" "demofwvnet" {
  count               = length(var.vnets)
  name                = element(var.vnets, count.index)
  address_space       = element(var.segments, count.index)
  location            = azurerm_resource_group.demofwrg.location
  resource_group_name = azurerm_resource_group.demofwrg.name
}

resource "azurerm_subnet" "demofwsubnet" {
  count                = length(var.subnetnames)
  name                 = element(var.subnetnames, count.index)
  resource_group_name  = azurerm_resource_group.demofwrg.name
  virtual_network_name = azurerm_virtual_network.demofwvnet[0].name
  address_prefixes     = element(var.subnets, count.index)
}

resource "azurerm_public_ip" "demofwpip" {
  name                = var.fwpip
  location            = azurerm_resource_group.demofwrg.location
  resource_group_name = azurerm_resource_group.demofwrg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}