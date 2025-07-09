provider "azurerm" {
  features {}

  subscription_id =  "1744cbdb-aa0a-44e7-93c7-8f603b704af3"
}


# Variables


# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# virtual network
resource "azurerm_virtual_network" "vnet" {
  name = "tangoe-vnet"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space = [var.address_space]
  }

resource "azurerm_subnet" "dmz" {
  name                 = "tangoe-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefixes
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.nic_name}-ipconfig"
    subnet_id                     = azurerm_subnet.dmz.id
    private_ip_address            = var.private_ip_address
    public_ip_address_id          = var.public_ip_address_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

# Virtual Machine
resource "azurerm_virtual_machine" "vm" {
  name                  = var.vm.name
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vm.size

  storage_os_disk {
    name              = "${var.vm.name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = var.vm.image_publisher
    offer     = var.vm.image_offer
    sku       = var.vm.image_sku
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vm.name
    admin_username = var.vm.admin_username
    admin_password = var.vm.admin_password
  }
  
}






