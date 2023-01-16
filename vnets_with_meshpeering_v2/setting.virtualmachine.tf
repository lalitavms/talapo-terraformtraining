data "azurecaf_name" "windowsvm" {
  name          = "windows"
  resource_type = "azurerm_virtual_machine"
  prefixes      = ["tft"]
  suffixes      = ["dev"]
  random_length = 4
  clean_input   = true
}

data "azurecaf_name" "linuxvm" {
  name          = "windows"
  resource_type = "azurerm_virtual_machine"
  prefixes      = ["tft"]
  suffixes      = ["dev"]
  random_length = 4
  clean_input   = true
}

# data "azurerm_subnet" "aus-subnet01" {
#   name = "subnet01"
#   virtual_network_name = "vnet-aus"
#   resource_group_name = azurerm_resource_group.mainrg.name
#   depends_on = [module.virtual_network]
# }

# output "aus-subnet01_id" {
#   value = data.azurerm_subnet.aus-subnet01.id
# }

output "aus-subnet01-test-id" {
  value = module.virtual_network["virtual_network_aus"].subnet["subnet01"].id
}

resource "azurerm_network_interface" "windowsvm-aus" {
  name                = "${data.azurecaf_name.windowsvm.result}-aus-nic"
  location            = azurerm_resource_group.mainrg.location
  resource_group_name = azurerm_resource_group.mainrg.name

  ip_configuration {
    name = "ipconfig1"
    #subnet_id = data.azurerm_subnet.aus-subnet01.id
    subnet_id                     = module.virtual_network["virtual_network_aus"].subnet["subnet01"].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "windowsvm-aus" {
  name                  = "${data.azurecaf_name.windowsvm.result}-aus"
  location              = azurerm_resource_group.mainrg.location
  resource_group_name   = azurerm_resource_group.mainrg.name
  network_interface_ids = [azurerm_network_interface.windowsvm-aus.id]
  vm_size               = "Standard_DS1_v2"
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${data.azurecaf_name.windowsvm.result}-aus-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = data.azurecaf_name.windowsvm.result
    admin_username = "talapo"
    admin_password = "talapo1234!"
  }
  os_profile_windows_config {
    timezone = "SE Asia Standard Time"
  }
}