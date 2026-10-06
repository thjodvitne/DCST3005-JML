output "nic_id" {
  description = "ID til nettverkskortet i app-subnettet."
  value       = azurerm_network_interface.app.id
}

output "nic_private_ip" {
  description = "Privat IP-adresse tildelt nettverkskortet."
  value       = azurerm_network_interface.app.private_ip_address
}
