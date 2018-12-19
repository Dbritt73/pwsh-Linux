#!/usr/bin/env powershell

Function Rename-LinuxComputer {
    [CmdletBinding()]
    Param (

        [parameter(Mandatory = $true)]
        [string]$NewName

    )

    Begin {}

    Process {

        $Hostname = & hostname

        $Hosts = (Get-Content /etc/hosts)

        $Hosts -replace $Hostname, $NewName

        $Hosts = (Get-Content /etc/hostname)

        $Hosts -replace $Hostname, $NewName

    }

    End {}

}