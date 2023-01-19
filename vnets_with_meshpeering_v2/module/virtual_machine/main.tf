# data "azurerm_subnet" "vmsubnet" {
#   name                 = var.virtual_machine.network.subnet_name
#   virtual_network_name = var.virtual_machine.network.virtual_network_name
#   resource_group_name  = var.virtual_machine.network.resource_group_name
# }

# output ""vmsubnet" {
#   value = data.azurerm_subnet.vmsubnet
# }

resource "azurerm_network_interface" "windowsvm" {
  name                = "${var.virtual_machine.name}-nic"
  location            = var.virtual_machine.location
  resource_group_name = var.virtual_machine.resource_group_name

  ip_configuration {
    name = "ipconfig1"
    #    subnet_id = data.azurerm_subnet.vmsubnet.id
    subnet_id                     = var.virtual_networks[var.virtual_machine.network.virtual_network_key].subnet[var.virtual_machine.network.subnet_key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "windowsvm" {
  name                  = var.virtual_machine.name
  location              = var.virtual_machine.location
  resource_group_name   = var.virtual_machine.resource_group_name
  network_interface_ids = [azurerm_network_interface.windowsvm.id]
  vm_size               = var.virtual_machine.vm_size
  storage_image_reference {
    publisher = var.virtual_machine.storage_image_reference.publisher
    offer     = var.virtual_machine.storage_image_reference.offer
    sku       = var.virtual_machine.storage_image_reference.sku
    version   = var.virtual_machine.storage_image_reference.version
  }
  storage_os_disk {
    name              = "${var.virtual_machine.name}-osdisk"
    caching           = try(var.virtual_machine.storage_os_disk.caching, "ReadWrite")
    create_option     = try(var.virtual_machine.storage_os_disk.create_option, "FromImage")
    managed_disk_type = try(var.virtual_machine.storage_os_disk.managed_disk_type, "Standard_LRS")
  }
  os_profile {
    computer_name  = var.virtual_machine.name
    admin_username = var.virtual_machine.localadmin.username
    admin_password = var.virtual_machine.localadmin.password
  }
  os_profile_windows_config {
    timezone = "SE Asia Standard Time"
  }
}