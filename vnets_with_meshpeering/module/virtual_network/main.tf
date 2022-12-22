resource "azurerm_virtual_network" "virtual_network" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

output "name" {
  value = azurerm_virtual_network.virtual_network.name
}

output "id" {
  value = azurerm_virtual_network.virtual_network.id
}