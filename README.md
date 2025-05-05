# README.md

# UllandTech Terraform Startpakke

## Hva denne pakken gjør

- Oppretter ressursgruppe i Azure
- Setter opp kostnadsbudsjett med varsel
- Lager Virtual Network og Subnet
- Oppretter Windows Server 2022 som Domain Controller
- Oppretter én Windows 11 klientmaskin
- Strukturert for videre utvidelse (VM, brukere, nettverk, M365)

## ☁️ Microsoft 365 og Exchange-oppsett

- Terraform konfigurerer sikkerhetsgrupper og eksempelbruker i Azure AD
- Brukere får tilgang til M365 når lisens legges til manuelt i admin.microsoft.com
- Fellespostkasser og Exchange-oppsett gjøres manuelt pga. manglende Terraform-provider

## Kom i gang

1. Opprett `terraform.tfvars` med:

```hcl
subscription_id = "<DIN_SUBS_ID>"
tenant_id       = "<DIN_TENANT_ID>"
```

2. Kjør:

```sh
terraform init
terraform plan
terraform apply
```

## Neste steg

- Legg inn nettverk i `networking/vnet.tf`
- Opprett servere i `compute/`
- Sett opp brukere og lisenser i `users/`
- Sett opp dokumentasjon i `m365/` og policyer i `security/`
