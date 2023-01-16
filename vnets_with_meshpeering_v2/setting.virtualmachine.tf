data "azurecaf_name" "windowsvm" {
  name          = "windows"
  resource_type = "azurerm_virtual_machine"
  prefixes      = ["tft"]
  suffixes      = ["dev"]
  random_length = 4
  clean_input   = true
}

data "azurecaf_name" "linuxvm" {
  name          = "linux"
  resource_type = "azurerm_virtual_machine"
  prefixes      = ["tft"]
  suffixes      = ["dev"]
  random_length = 4
  clean_input   = true
}

locals {
  virtual_machine = {
    name                = "${data.azurecaf_name.windowsvm.result}"
    location            = azurerm_resource_group.mainrg.location
    resource_group_name = azurerm_resource_group.mainrg.name
    vm_size             = "Standard_DS1_v2"
    network = {
      resource_group_name = azurerm_resource_group.mainrg.name
      #virtual_network    = "virtual_network_aus"
      virtual_network_name = "vnet-aus"
      subnet_name          = "subnet01"
    }
    storage_image_reference = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-Datacenter"
      version   = "latest"
    }
    storage_os_disk = {
      # name              = "${data.azurecaf_name.windowsvm.result}-osdisk"
      # caching           = "ReadWrite"
      # create_option     = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
    localadmin = {
      username = "talapo"
      password = "talapo1234!"
    }
  }
}