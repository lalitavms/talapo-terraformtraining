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