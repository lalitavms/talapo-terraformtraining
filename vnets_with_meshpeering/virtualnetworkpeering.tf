module "virtual_network_peering" {
  source               = "./module/virtual_network_peering"
  for_each             = var.virtual_networks
  virtual_network_name = each.value.vnetname
  peerings             = each.value.peerings
  resource_group_name  = azurerm_resource_group.testrg.name
  virtual_networks     = module.virtual_network
}