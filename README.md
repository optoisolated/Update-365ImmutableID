# Update-365ImmutableID
A powershell command that updates an Office365 Immutable ID for a nominated user from their corresponding AD User GUID

Usage:
> Update-365ImmutableID -Username adusername -FQDN domain.com

Requires:
* Active Directory Powershell Module
* Microsoft Online Powershell Module (MSOL)

This script assumes, as is best practice for AD/365 Syncing, that the UPN of the Office365 User is the same as the AD user.
