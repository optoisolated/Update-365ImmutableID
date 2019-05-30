Param(
    [string]$Username = $(throw "-Username is required."),
    [string]$FQDN = $(throw "-FQDN is required.")
)

CLS

Import-Module ActiveDirectory

$Credential = Get-Credential -Message "Log into Office365 Admin Console"
Connect-MsolService -Credential $Credential

$ADUser = $Username
$365User = "$Username@$FQDN"

Write-Host "Generating GUID from AD User '$ADUser'"
[GUID]$ADGUID = (Get-ADUser $ADUser).ObjectGUID

If ($ADGUID -ne $null) {
    $ImmutableID = [System.Convert]::ToBase64String($ADGUID.ToByteArray())
    Write-Host "Updating Immutable ID for O365 User '$365User' with the Immutable ID '$ImmutableID'"
    Set-MsolUser -UserPrincipalName "$365User" -ImmutableID $ImmutableID
} Else {
    Write-Host "Error generating Immutable ID. Office365 has not been updated."
}
