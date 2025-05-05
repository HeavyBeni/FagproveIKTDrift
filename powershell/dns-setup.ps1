# Installer og konfigurer DNS Server (kjøres etter domenet er opprettet)
Install-WindowsFeature DNS -IncludeManagementTools

# Legg til en fremoversøkingssone for domenet (om ikke allerede opprettet av AD DS)
Add-DnsServerPrimaryZone -Name "ullandtech.local" -ZoneFile "ullandtech.local.dns" -DynamicUpdate Secure