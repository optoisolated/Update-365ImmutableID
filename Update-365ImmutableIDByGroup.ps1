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
      #Generate the ImmutableID
      $ImmutableID = [System.Convert]::ToBase64String($ADGUID.ToByteArray())
      Write-Host "Updating Immutable ID for O365 User '$365User' with the Immutable ID '$ImmutableID'"
      
      #Update the Immutable ID in O365
      Set-MsolUser -UserPrincipalName "$365User" -ImmutableID $ImmutableID
      
      # Wait a few seconds to wait for things to update in the cloud
      Start-Sleep -s 2
      
      #Check that the Immutable ID updated successfully.
      $IID = Get-MsolUser -UserPrincipalName $365User | Select ImmutableID
      if ($IID.ImmutableID -eq $ImmutableID) {
        Write-Host "O365 User '$365User' Immutable ID Updated Successfully."
      } Else { 
        Write-Host "O365 User '$365User' Immutable ID Update Failed!"
      }
  } Else {
      Write-Host "Error generating Immutable ID. Office365 has not been updated."
  }
}
