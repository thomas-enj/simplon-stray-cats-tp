output "public_ip" {
  value       = azurerm_public_ip.pip_prometheus.ip_address
  description = "IP publique de la VM Prometheus"
}
