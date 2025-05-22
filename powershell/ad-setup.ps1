
# Installer AD DS-rollen med verktøy
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Konfigurer nytt domene (erstatt med ønsket domenenavn og trygt passord)
Install-ADDSForest `
    -DomainName "EduTech.local" `
    -DomainNetbiosName "EDTECH" `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "SterktPassord123!" -AsPlainText -Force) `
    -InstallDns `
    -Force