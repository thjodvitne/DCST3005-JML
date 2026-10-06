output "resource_group_name" {
  description = "Resource group nettverket ligger i."
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "Region nettverket er rullet ut i."
  value       = azurerm_resource_group.this.location
}

output "vnet_id" {
  description = "ID til virtual network."
  value       = module.network.vnet_id
}

output "subnet_ids" {
  description = "Map fra subnettnøkkel (web/app/data) til subnet-ID."
  value       = module.network.subnet_ids
}
