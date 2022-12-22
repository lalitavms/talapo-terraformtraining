resource "azurerm_virtual_network_peering" "virtual_network_peering" {
  for_each                  = var.peerings
  name                      = each.value.peeringname
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.virtual_network_name
  remote_virtual_network_id = var.virtual_networks[each.key].id
}
