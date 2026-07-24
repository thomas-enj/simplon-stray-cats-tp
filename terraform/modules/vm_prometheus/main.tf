
resource "azurerm_public_ip" "pip_prometheus" {
  name                = "pip-prometheus"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Standard"
}

data "azurerm_resource_group" "data" {
  name = var.resource_group_name
}

resource "azurerm_network_interface" "nic-prometheus" {
  name                = "nic-prometheus"
  location            = data.azurerm_resource_group.data.location
  resource_group_name = data.azurerm_resource_group.data.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id_prometheus
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_prometheus.id
  }
}


resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-prometheus"
  resource_group_name = data.azurerm_resource_group.data.name
  location            = data.azurerm_resource_group.data.location
  size                = "Standard_B2s"
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.nic-prometheus.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}


