# Installer DHCP Server
Install-WindowsFeature -Name DHCP -IncludeManagementTools

# Autoriser DHCP-serveren i AD
Add-DhcpServerInDC -DnsName "ullandtech-dc.ullandtech.local" -IPAddress 10.0.1.4

# Lag DHCP scope
Add-DhcpServerv4Scope -Name "UllandTech-scope" -StartRange 10.0.1.50 -EndRange 10.0.1.150 -SubnetMask 255.255.255.0 -State Active

# Sett DNS- og gateway-opsjoner
Set-DhcpServerv4OptionValue -ScopeId 10.0.1.0 -DnsServer 10.0.1.4 -DnsDomain "ullandtech.local" -Router 10.0.1.1
