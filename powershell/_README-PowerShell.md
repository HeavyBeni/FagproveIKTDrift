# PowerShell-skript for manuell kjøring

Denne mappen inneholder skript som kjøres manuelt på virtuelle maskiner i prosjektet.

## `ad-setup.ps1`

Installerer AD DS og oppretter domenet `ullandtech.local`.

## `dns-setup.ps1`

Installerer og konfigurerer DNS-server på domenekontrolleren.

## `dhcp-setup.ps1`

Installerer og konfigurerer DHCP-server med scope for `10.0.1.0/24`.

## `join-domain.ps1`

Kjøres på klientmaskin for å bli med i domenet.

## `create-users.ps1`

Oppretter OU-struktur, grupper og brukere for alle ansatte.

> Alle skript skal ligge i `C:\scripts` på riktig VM, og kjøres med `powershell -ExecutionPolicy Bypass -File <filnavn>.ps1`
