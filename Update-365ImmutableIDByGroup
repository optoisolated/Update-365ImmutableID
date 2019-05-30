Param(
    [string]$GroupName = $(throw "-GroupName is required.")
)

CLS

Import-Module ActiveDirectory
Connect-MsolService

$ADGroup = Get-ADGroupMember -Identity $GroupName

ForEach ($User in $ADGroup) {
  $UserInfo = Get-ADUser $($User.SamAccountName)
  $ADUser = $UserInfo.SamAccountName
  $365User =  $UserInfo.UserPrincipalName
  
  [GUID]$ADGUID = (Get-ADUser $ADUser).ObjectGUID

  If ($ADGUID -ne $null) {
      $ImmutableID = [System.Convert]::ToBase64String($ADGUID.ToByteArray())
      Write-Host "Updating Immutable ID for O365 User '$365User' with the Immutable ID '$ImmutableID'"
      Set-MsolUser -UserPrincipalName "$365User" -ImmutableID $ImmutableID
  } Else {
      Write-Host "Error generating Immutable ID. Office365 has not been updated."
  }
}
