# resource "azurerm_virtual_network" "vnet" {
#     name                = "${var.hub_prefix}-vnet"
#     location            = azurerm_resource_group.testrg.location
#     resource_group_name = azurerm_resource_group.testrg.name
#     address_space       = ["10.0.0.0/16"]
# }

module "virtual_network" {
  source              = "./module/virtual_network"
  for_each            = var.virtual_networks
  name                = each.value.vnetname
  location            = each.value.location
  resource_group_name = azurerm_resource_group.testrg.name
  address_space       = each.value.address_space
}

output "virtual_network_out" {
  value = module.virtual_network
}