variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Navn på ressursgruppe"
  default     = "UllandTech-RG"
}

variable "project_name" {
  description = "Navn på prosjekt (for navngiving)"
  default     = "UllandTech"
}

variable "vnet_name" {
  description = "Navn på Virtual Network"
  default     = "ullandtech-vnet"
}

variable "address_space" {
  description = "Adresseområde for VNet"
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Navn på subnet"
  default     = "ullandtech-subnet"
}

variable "subnet_prefix" {
  description = "Adresseområde for subnet"
  default     = "10.0.1.0/24"
}

variable "admin_username" {
  description = "Administrator brukernavn for VM"
  default     = "ullandadmin"
}

variable "admin_password" {
  description = "Administrator passord for VM (bør hentes fra secrets)"
  type        = string
  sensitive   = true
}

variable "my_public_ip" {
  description = "Din offentlige IP-adresse for RDP-tilgang"
  type        = string
}