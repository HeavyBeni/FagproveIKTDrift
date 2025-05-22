
//Ressursgruppe i AZ
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

// Subnett og nettverksstruktur
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}


resource "azurerm_subnet" "server_subnet" {
  name                 = "server-subnet"
  
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.server_subnet_prefix]
}

resource "azurerm_subnet" "client_subnet" {
  name                 = "client-subnet"
  
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.client_subnet_prefix]
}

resource "azurerm_subnet" "guest_subnet" {
  name                 = "guest-subnet"
  
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.guest_subnet_prefix]
}

//RDP-tilgang kun fra gitt IP
resource "azurerm_network_security_group" "rdp_nsg" {
  name                = "rdp-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow-rdp-from-benjamin"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "152.94.11.211"
    destination_address_prefix = "*"
}
}

// Domenekontroller
resource "azurerm_network_interface" "dc_nic" {
  name                = "dc-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.server_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.dc_public_ip.id
  }
}

resource "azurerm_public_ip" "dc_public_ip" {
  name                = "dc-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Basic"
  }


resource "azurerm_network_interface_security_group_association" "dc_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.dc_nic.id
  network_security_group_id = azurerm_network_security_group.rdp_nsg.id
}

//Disk for filserver
resource "azurerm_managed_disk" "dc_data_disk" {
name                = "dc-data-disk"
location            = var.location
resource_group_name = azurerm_resource_group.rg.name
storage_account_type = "Standard_LRS"
create_option        = "Empty"
disk_size_gb         = 100
}

resource "azurerm_windows_virtual_machine" "domain_controller" {
  name                  = var.domain_controller
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  size                  = "Standard_B2ms"
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.dc_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
    }


  tags = {
  Environment = "EduTech"
  Owner       = "Benjamin Csaplar"
  Purpose     = "Fagprøve"
}
}

//Kobler ekstra disk til dc
resource "azurerm_virtual_machine_data_disk_attachment" "dc_data_disk_attach" {
  managed_disk_id     = azurerm_managed_disk.dc_data_disk.id
  virtual_machine_id  = azurerm_windows_virtual_machine.domain_controller.id
  lun                 = 0
  caching             = "None"
}

//4 Klienter (VM for testing)

locals {
clients = ["admin", "sales", "consulting", "ikt"]
}

resource "azurerm_windows_virtual_machine" "clients" {
count                 = length(local.clients)
name                  = "client-${local.clients[count.index]}"
computer_name         = "client${count.index}"
resource_group_name   = azurerm_resource_group.rg.name
location              = var.location
size                  = "Standard_B2s"
admin_username       = var.admin_username
admin_password       = var.admin_password
network_interface_ids = [azurerm_network_interface.clients[count.index].id]

os_disk {
caching              = "ReadWrite"
storage_account_type = "Standard_LRS"
}

source_image_reference {
publisher = "MicrosoftWindowsDesktop"
offer     = "windows-11"
sku       = "win11-23h2-pro"
version   = "latest"
}
}

resource "azurerm_network_interface" "clients" {
count               = length(local.clients)
name                = "client-${local.clients[count.index]}-nic"
location            = var.location
resource_group_name = azurerm_resource_group.rg.name

ip_configuration {
name                          = "internal"
subnet_id                     = azurerm_subnet.client_subnet.id
private_ip_address_allocation = "Dynamic"
# No public IP for clients
}
}

