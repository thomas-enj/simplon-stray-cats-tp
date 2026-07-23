

data "azurerm_resource_group" "data" {
  name = var.resource_group_name
}


resource "azurerm_service_plan" "service_plan_stray_cat" {
  name                = "service_plan-{$var.team}-tf"
  resource_group_name = data.azurerm_resource_group.data.name
  location            = data.azurerm_resource_group.data.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}


resource "azurerm_linux_web_app" "webapp" {
  name                = "app-${var.team}-tf"
  resource_group_name = data.azurerm_resource_group.data.name
  location            = azurerm_service_plan.service_plan_adrien.location
  service_plan_id     = azurerm_service_plan.service_plan_adrien.id

  site_config {}
}


resource "azurerm_virtual_network" "virtualnetwork_straycat" {
  name                = "vnet-${var.team}-tf"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.data.location
  resource_group_name = data.azurerm_resource_group.data.name
}

resource "azurerm_subnet" "subnet-frontend" {
  name                 = "subnet-${var.team}-frontend-tf"
  resource_group_name  = data.azurerm_resource_group.data.name
  virtual_network_name = azurerm_virtual_network.virtualnetwork_straycat.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_subnet" "subnet-backend" {
  name                 = "subnet-${var.team}-backend-tf"
  resource_group_name  = data.azurerm_resource_group.data.name
  virtual_network_name = azurerm_virtual_network.virtualnetwork_straycat.name
  address_prefixes     = ["10.0.2.0/24"]

}

resource "azurerm_network_security_group" "SecurityGroup" {
  name                = "SecurityGroupSubnetStorage"
  location            = data.azurerm_resource_group.data.location
  resource_group_name = data.azurerm_resource_group.data.name
}

resource "azurerm_network_security_rule" "NSG-RuleSSH" {
  name                        = "SSH-access"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.data.name
  network_security_group_name = azurerm_network_security_group.SecurityGroup.name
}
