#!/usr/bin/env powershell

Function Set-LinuxComputerDomainPrefs{
  <#
    .SYNOPSIS
    Describe purpose of "Set-LinuxComputerDomainPrefs" in 1-2 sentences.

    .DESCRIPTION
    Add a more complete description of what the function does.

    .PARAMETER DomainName
    Describe parameter -DomainName.

    .PARAMETER ADgroup
    Describe parameter -ADgroup.

    .PARAMETER DomainAlias
    Describe parameter -DomainAlias.

    .EXAMPLE
    Set-LinuxComputerDomainPrefs -DomainName Value -ADgroup Value -DomainAlias Value
    Describe what this call does

    .NOTES
    Place additional notes here.

    .LINK
    URLs to related sites
    The first link is opened by Get-Help -Online Set-LinuxComputerDomainPrefs

    .INPUTS
    List of input types that are accepted by this function.

    .OUTPUTS
    List of output types produced by this function.
  #>


    [CmdletBinding()]
    Param (

        [string]$DomainName,

        [string[]]$ADgroup,

        [string]$DomainAlias

    )

    Begin {}

    Process {

        if ($islinux) {

            #Edit /opt/pbis/bin/config - basic settings for AD user experience PowerBroker ID Services
            /opt/pbis/bin/config UserDomainPrefix $DomainName

            /opt/pbis/bin/config AssumeDefaultDomain True

            /opt/pbis/bin/config HomeDirTemplate %H/%D/%U

            #Add AD groups to Sudoers
            foreach ($group in $ADgroup) {

                #Add-Content -Path '/etc/sudoers' -Value "%$DomainAlias\\$group ALL=(ALL) ALL" -append

                "%$DomainAlias\\$group ALL=(ALL) ALL" | Out-File -path '/etc/sudoers' -Append

            }

        }

    }

    End {}

}