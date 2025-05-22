# Installer DNS-server og verktøy
Install-WindowsFeature DNS -IncludeManagementTools

# Opprett forward lookup zone hvis den ikke allerede finnes
if (-not (Get-DnsServerZone -Name "edutech.local" -ErrorAction SilentlyContinue)) {
    Add-DnsServerPrimaryZone -Name "edutech.local" -ZoneFile "edutech.local.dns" -DynamicUpdate Secure
} else {
    Write-Host "Zonen 'edutech.local' eksisterer allerede – hopper over opprettelse."
}
