
# Installer AD DS-rollen med verktøy
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Konfigurer nytt domene (erstatt med ønsket domenenavn og trygt passord)
Install-ADDSForest `
    -DomainName "ullandtech.local" `
    -DomainNetbiosName "ULLANDTECH" `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "SikkertAdminPassord123!" -AsPlainText -Force) `
    -InstallDns `
    -Force