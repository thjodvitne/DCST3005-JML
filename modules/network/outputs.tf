output "vnet_id" {
  description = "ID til virtual network."
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Navn på virtual network."
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "Map fra subnettnøkkel til subnet-ID."
  value       = { for k, s in azurerm_subnet.this : k => s.id }
}

output "nsg_ids" {
  description = "Map fra subnettnøkkel til NSG-ID."
  value       = { for k, n in azurerm_network_security_group.this : k => n.id }
}
