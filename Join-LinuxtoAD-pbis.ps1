#!/usr/bin/env powershell
Function Join-LinuxtoAD {
  <#
    .SYNOPSIS
    Join a Linux based computer to an Active Directory environment

    .DESCRIPTION
    Join-LinuxtoAD utilizes PowerBroker Identity Services Open to bind the machine to Active Directory for authentication.
    Ensures that the dependent packages are available and install prior to attempting the join to AD.

    .PARAMETER DomainName
    The name of your Active Directory Domain - example contoso.com

    .PARAMETER Username
    User name of account that has permissions to add computers objects to Active Directory

    .EXAMPLE
    Join-LinuxtoAD -DomainName your.domain.name -Username User1@your.domain.name

    creates a computer object with the current host name in the your.domain.name domain using the provided username and password

    .NOTES
    Place additional notes here.

    .LINK
    URLs to related sites
    https://winsysblog.com/2018/01/join-linux-active-directory-powershell-core.html
    https://github.com/BeyondTrust/pbis-open
    https://github.com/BeyondTrust/pbis-open/wiki/Documentation
  #>


    [CmdletBinding()]
    Param (

        [parameter()]
        [string]$DomainName,

        [parameter()]
        [string]$Username

    )

    Begin {}

    Process {

        if ($isLinux) {

            #Ensure you can lookup AD DNS
            nslookup $DomainName | Out-Null

            if ($lastexitcode -ne 0) {

                Write-Error -Message "Could not find $DomainName in DNS - Check settings"

            }

            #Ensure repos are added and up to date
            wget -O - http://repo.pbis.beyondtrust.com/apt/RPM-GPG-KEY-pbis|sudo apt-key add -
            wget -O /etc/apt/sources.list.d/pbiso.list http://repo.pbis.beyondtrust.com/apt/pbiso.list
            apt-get update

            #Ensure SSH is installed
            apt install ssh

            #Install PowerBroker Identity Services Open
            apt install pbis-open

            if ($lastexitcode -ne 0) {

                Write-Error -Message 'Could not install one or more dependencies'

            }

            #Join Active Directory
            domainjoin-cli join $DomainName $Username

            if ($lastexitcode -eq 0) {

                Write-Output -InputObject "Success - Joined to $DomainName"

            } else {

                Write-Error -Message "Did not successfully join $DomainName"

            }

        }

    }

    End {}

}