# Opprett Microsoft 365-grupper for avdelinger
resource "azuread_group" "admin_group" {
  display_name     = "Administrasjon"
  security_enabled = true
  mail_enabled     = false
}

resource "azuread_group" "konsulent_group" {
  display_name     = "Konsulenttjenester"
  security_enabled = true
  mail_enabled     = false
}

resource "azuread_group" "drift_group" {
  display_name     = "IKT-Drift"
  security_enabled = true
  mail_enabled     = false
}

# Eksempelbruker for testing (du kan utvide med flere senere)
resource "azuread_user" "admin1" {
  user_principal_name    = "admin1@ullandtech.no"
  display_name           = "Admin Bruker 1"
  mail_nickname          = "admin1"
  password               = var.admin_password
  force_password_change  = false
}

resource "azuread_group_member" "admin1_member" {
  group_object_id  = azuread_group.admin_group.id
  member_object_id = azuread_user.admin1.id
}
