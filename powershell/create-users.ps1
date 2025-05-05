# Opprett OU-struktur og grupper i AD
Import-Module ActiveDirectory

# OU-struktur
New-ADOrganizationalUnit -Name "UllandTech" -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name "Administrasjon" -Path "OU=UllandTech,DC=ullandtech,DC=local"
New-ADOrganizationalUnit -Name "Konsulenttjenester" -Path "OU=UllandTech,DC=ullandtech,DC=local"
New-ADOrganizationalUnit -Name "IKT-Drift" -Path "OU=UllandTech,DC=ullandtech,DC=local"

# Grupper
New-ADGroup -Name "Administrasjon" -GroupScope Global -Path "OU=Administrasjon,OU=UllandTech,DC=ullandtech,DC=local"
New-ADGroup -Name "Konsulenttjenester" -GroupScope Global -Path "OU=Konsulenttjenester,OU=UllandTech,DC=ullandtech,DC=local"
New-ADGroup -Name "IKT-Drift" -GroupScope Global -Path "OU=IKT-Drift,OU=UllandTech,DC=ullandtech,DC=local"

# Brukere
1..3 | ForEach-Object {
    New-ADUser -Name "AdminBruker$_" -SamAccountName "admin$_" -UserPrincipalName "admin$_@ullandtech.local" -Path "OU=Administrasjon,OU=UllandTech,DC=ullandtech,DC=local" -AccountPassword (ConvertTo-SecureString "Start1234!" -AsPlainText -Force) -Enabled $true
    Add-ADGroupMember -Identity "Administrasjon" -Members "admin$_"
}

1..10 | ForEach-Object {
    New-ADUser -Name "KonsulentBruker$_" -SamAccountName "konsulent$_" -UserPrincipalName "konsulent$_@ullandtech.local" -Path "OU=Konsulenttjenester,OU=UllandTech,DC=ullandtech,DC=local" -AccountPassword (ConvertTo-SecureString "Start1234!" -AsPlainText -Force) -Enabled $true
    Add-ADGroupMember -Identity "Konsulenttjenester" -Members "konsulent$_"
}

1..2 | ForEach-Object {
    New-ADUser -Name "DriftBruker$_" -SamAccountName "drift$_" -UserPrincipalName "drift$_@ullandtech.local" -Path "OU=IKT-Drift,OU=UllandTech,DC=ullandtech,DC=local" -AccountPassword (ConvertTo-SecureString "Start1234!" -AsPlainText -Force) -Enabled $true
    Add-ADGroupMember -Identity "IKT-Drift" -Members "drift$_"
}


