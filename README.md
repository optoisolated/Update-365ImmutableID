# Update-365ImmutableID
A powershell command that updates an Office365 Immutable ID for a nominated user from their corresponding AD User GUID

Usage:
> Update-365ImmutableID -Username adusername -FQDN domain.com

Requires:
* Active Directory Powershell Module
* Microsoft Online Powershell Module (MSOL)

This script assumes, as is best practice for AD/365 Syncing, that the UPN of the Office365 User is the same as the AD user.

It's also possible to get input from a CSV file to process multiple users. 

Example 1:
* Connect-MSOLService
* Import-CSV C:\path\UserFile.CSV | ForEach { C:\path\Update-365ImmutableID.ps1 -Username $__.Username -FQDN "domain.com"}

or Example 2:
* Connect-MSOLService
* Import-CSV C:\path\UserFile.CSV | ForEach { C:\path\Update-365ImmutableID.ps1 -Username $__.Username -FQDN $__.FQDN}

Note: the script will need to have the Get-Credential command Remmed out.

* For the first example, the CSV file will be just a list of SAMAccountNames. eg. username 
* For the second example, the CSV file will be a list of SAMAccountNames, and FQDNs. eg. username, FQDN
