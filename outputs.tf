output "resource_group_name" {
  value = var.resource_group_name
}

output "location" {
  value = var.location
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "server_subnet" {
  value = azurerm_subnet.server_subnet
}

output "client_subnet" {
  value = azurerm_subnet.client_subnet
}

output "guest_subnet" {
  value = azurerm_subnet.guest_subnet
}