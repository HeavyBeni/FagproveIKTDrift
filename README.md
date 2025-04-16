# README.md
# UllandTech Terraform Startpakke

## Hva denne pakken gjør
- Oppretter ressursgruppe i Azure
- Setter opp kostnadsbudsjett med varsel
- Lager Virtual Network og Subnet
- Oppretter Windows Server 2022 som Domain Controller
- Oppretter én Windows 11 klientmaskin
- Strukturert for videre utvidelse (VM, brukere, nettverk, M365)

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
