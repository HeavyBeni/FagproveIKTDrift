
# Setter ip adresse på serveren før dhcp installasjon
New-NetIPAddress -InterfaceAlias "Ethernet" `
  -IPAddress 192.168.10.10 `
  -PrefixLength 24 `
  -DefaultGateway 192.168.10.1

Set-DnsClientServerAddress -InterfaceAlias "Ethernet" `
  -ServerAddresses 192.168.10.10





# Installer DHCP Server
Install-WindowsFeature -Name DHCP -IncludeManagementTools

# Autoriser DHCP-serveren i AD
Add-DhcpServerInDC -DnsName "edutech-dc.edutech.local" -IPAddress 192.168.10.10

# Lag scope for VLAN 20 – Klienter
Add-DhcpServerv4Scope -Name "VLAN20-Klienter" -StartRange 192.168.10.100 -EndRange 192.168.10.120 -SubnetMask 255.255.255.0 -State Active

# DHCP-alternativer for VLAN 20
Set-DhcpServerv4OptionValue -ScopeId 192.168.10.0 `
    -DnsServer 192.168.10.10 `
    -DnsDomain "edutech.local" `
    -Router 192.168.10.1
