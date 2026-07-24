
resource "azurerm_public_ip" "pip_prometheus" {
  name                = "pip-prometheus"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
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
  name                            = "vm-prometheus"
  resource_group_name             = data.azurerm_resource_group.data.name
  location                        = data.azurerm_resource_group.data.location
  size                            = "Standard_D2s_v3"
  admin_username                  = "azureuser"
  admin_password                  = "P@ssw0rdTemp1234!"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic-prometheus.id,
  ]

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

  custom_data = base64encode(<<-EOF
    #!/bin/bash
    # Version 3.12.0, PAS 2.53.0 : l'identitÃ© managÃ©e SYSTÃˆME (notre cas, client_id vide
    # dans prometheus.yml Ã  l'Ã©tape 5) nÃ©cessite Prometheus 3.50+ selon la doc Microsoft.
    # Avec une version plus ancienne, Prometheus plante au dÃ©marrage avec l'erreur "must
    # provide an Azure Managed Identity client_id in the Azure AD config".
    apt-get update
    apt-get install -y wget
    useradd --no-create-home --shell /bin/false prometheus
    wget https://github.com/prometheus/prometheus/releases/download/v3.12.0/prometheus-3.12.0.linux-amd64.tar.gz
    tar xvf prometheus-3.12.0.linux-amd64.tar.gz
    cp prometheus-3.12.0.linux-amd64/prometheus /usr/local/bin/
    mkdir -p /etc/prometheus
  EOF
  )
}


