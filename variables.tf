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

variable "domain_controller" {
  description = "Navn på Windows Server#1"
  default = "EduTech"
}

variable "resource_group_name" {
  description = "Navn på ressursgruppe"
  default     = "EduTech-RG"
}

variable "project_name" {
  description = "Navn på prosjekt (for navngiving)"
  default     = "EduTech"
}

variable "vnet_name" {
  description = "Navn på Virtual Network"
  default     = "EduTech-vnet"
}

variable "address_space" {
  description = "Adresseområde for VNet"
  default     = ["192.168.0.0/16"]
}


variable "server_subnet_prefix" {
  description = "Adresseområde for subnet"
  default     = "192.168.10.0/24"
}

variable "client_subnet_prefix" {
  description = "Adresseområde for subnet"
  default     = "192.168.20.0/24"
}

variable "guest_subnet_prefix" {
  description = "Adresseområde for subnet"
  default     = "192.168.30.0/24"
}

variable "admin_username" {
  description = "Administrator brukernavn for VM"
  default     = "ETAdministrator"
}

variable "admin_password" {
  description = "Administrator passord for VM (bør hentes fra secrets)"
  type        = string
  sensitive   = true
}
