#!/usr/bin/env powershell
Function Join-LinuxtoAD {
  <#
    .SYNOPSIS
    Describe purpose of "Join-LinuxtoAD" in 1-2 sentences.

    .DESCRIPTION
    Add a more complete description of what the function does.

    .PARAMETER DomainName
    Describe parameter -DomainName.

    .PARAMETER Username
    Describe parameter -Username.

    .EXAMPLE
    Join-LinuxtoAD -DomainName Value -Username Value
    Describe what this call does

    .NOTES
    Place additional notes here.

    .LINK
    URLs to related sites
    https://winsysblog.com/2018/01/join-linux-active-directory-powershell-core.html
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

                Write-Output -InputObject "Success - Joined to $DomainNamme"

            } else {

                Write-Error -Message "Did not successfully join $DomainName"

            }

        }

    }

    End {}

}