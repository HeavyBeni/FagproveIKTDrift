Import-Module ActiveDirectory

# OU-struktur
New-ADOrganizationalUnit -Name "EduTech" -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name "b-Administrasjon" -Path "OU=EduTech,DC=Edutech,DC=local"
New-ADOrganizationalUnit -Name "b-Konsulenttjenester" -Path "OU=EduTech,DC=Edutech,DC=local"
New-ADOrganizationalUnit -Name "b-Salgsavdeling" -Path "OU=EduTech,DC=Edutech,DC=local"
New-ADOrganizationalUnit -Name "b-IKT-Service" -Path "OU=EduTech,DC=Edutech,DC=local"

# Sikkerhetsgrupper
New-ADGroup -Name "b-SG_Admin" -GroupScope Global -Path "OU=Administrasjon,OU=EduTech,DC=Edutech,DC=local"
New-ADGroup -Name "b-SG_Konsulent" -GroupScope Global -Path "OU=Konsulenttjenester,OU=EduTech,DC=Edutech,DC=local"
New-ADGroup -Name "b-SG_Salg" -GroupScope Global -Path "OU=Salgsavdeling,OU=EduTech,DC=Edutech,DC=local"
New-ADGroup -Name "b-SG_IKT" -GroupScope Global -Path "OU=IKT-Service,OU=EduTech,DC=Edutech,DC=local"
New-ADGroup -Name "b-SG_Felles" -GroupScope Global -Path "OU=EduTech,DC=Edutech,DC=local"
New-ADGroup -Name "b-SG_Ledelse" -GroupScope Global -Path "OU=EduTech,DC=Edutech,DC=local"

# Brukere
$root = "DC=Edutech,DC=local"

$users = @(
    @{ Name = "Daglig Leder"; UserName = "daglig.leder"; OU = "OU=Administrasjon,OU=EduTech,$root"; Group = "SG_Admin" },
    @{ Name = "Økonomiansvarlig"; UserName = "okonomi.ansvarlig"; OU = "OU=Administrasjon,OU=EduTech,$root"; Group = "SG_Admin" },
    @{ Name = "Salg- og Markedsansvarlig"; UserName = "salg.marked"; OU = "OU=Salgsavdeling,OU=EduTech,$root"; Group = "SG_Salg" },
    @{ Name = "Seniorkonsulent IKT"; UserName = "seniorkonsulent.ikt"; OU = "OU=Konsulenttjenester,OU=EduTech,$root"; Group = "SG_Konsulent" },
    @{ Name = "Konsulent IKT 1"; UserName = "konsulent1.ikt"; OU = "OU=Konsulenttjenester,OU=EduTech,$root"; Group = "SG_Konsulent" },
    @{ Name = "Konsulent IKT 2"; UserName = "konsulent2.ikt"; OU = "OU=Konsulenttjenester,OU=EduTech,$root"; Group = "SG_Konsulent" },
    @{ Name = "Key Account Manager"; UserName = "key.account"; OU = "OU=Salgsavdeling,OU=EduTech,$root"; Group = "SG_Salg" },
    @{ Name = "Selger 1"; UserName = "selger1"; OU = "OU=Salgsavdeling,OU=EduTech,$root"; Group = "SG_Salg" },
    @{ Name = "Selger 2"; UserName = "selger2"; OU = "OU=Salgsavdeling,OU=EduTech,$root"; Group = "SG_Salg" },
    @{ Name = "IKT-drift Ansvarlig"; UserName = "ikt.ansvarlig"; OU = "OU=IKT-Service,OU=EduTech,$root"; Group = "SG_IKT" },
    @{ Name = "IKT-drift Lærling"; UserName = "ikt.laerling"; OU = "OU=IKT-Service,OU=EduTech,$root"; Group = "SG_IKT" }
)

foreach ($u in $users) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$($u.UserName)'" -ErrorAction SilentlyContinue)) {
        New-ADUser -Name $u.Name -SamAccountName $u.UserName -UserPrincipalName "$($u.UserName)@edutech.local" `
            -Path $u.OU -AccountPassword (ConvertTo-SecureString "Start1234!" -AsPlainText -Force) -Enabled $true
        Add-ADGroupMember -Identity $u.Group -Members $u.UserName
    }
}
