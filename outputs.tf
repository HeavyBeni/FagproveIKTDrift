output "resource_group_name" {
  value = var.resource_group_name
}

output "location" {
  value = var.location
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}