resource "azurerm_virtual_network" "virtual_network" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.value.subnetname
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.name
  address_prefixes     = each.value.address_space

  depends_on = [azurerm_virtual_network.virtual_network]
}

# output "name" {
#   value = azurerm_virtual_network.virtual_network.name
# }

output "id" {
  value = azurerm_virtual_network.virtual_network.id
}