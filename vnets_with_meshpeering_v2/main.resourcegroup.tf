locals {
  resource_group_name = "${var.env_prefix}-rg"
}

resource "azurerm_resource_group" "testrg" {
  name     = local.resource_group_name
  location = var.location
}

output "resource_group_testrg_out" {
  value = azurerm_resource_group.testrg
}
