# Kjør på klientmaskin som skal kobles til domenet (erstatt med faktisk brukernavn/passord)
$domain = "ullandtech.local"
$username = "ullandadmin@ullandtech.local"
$password = ConvertTo-SecureString "SterktPassord123!" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

# Bli med i domenet
Add-Computer -DomainName $domain -Credential $credential -Restart