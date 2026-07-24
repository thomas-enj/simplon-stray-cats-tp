output "subnet_id_prometheus" {
  value       = azurerm_subnet.subnet-prometheus.id
  description = "ID du sous-réseau transmis aux autres modules"
}

output "vnet_id" {
  value       = azurerm_virtual_network.virtualnetwork_straycat.id
  description = "ID du réseau virtuel"
}

output "nsg_id" {
  value       = azurerm_network_security_group.SecurityGroup.id
  description = "ID du groupe de sécurité réseau"
}
