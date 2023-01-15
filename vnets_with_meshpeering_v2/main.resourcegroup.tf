# locals {
#   resource_group_name = "${var.env_prefix}-rg"
# }

data "azurecaf_name" "mainrg" {
  name          = "main"
  resource_type = "azurerm_resource_group"
  prefixes      = ["tft"]
  #  suffixes = ["dev"]
  #  random_length = 5
  clean_input = true
}

resource "azurerm_resource_group" "mainrg" {
  name = data.azurecaf_name.mainrg.result
  #  name     = local.resource_group_name
  location = var.location
}

output "resource_group_mainrg_out" {
  value = azurerm_resource_group.mainrg
}
