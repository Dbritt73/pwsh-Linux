#!/usr/bin/env powershell

Function Rename-LinuxComputer {
    [CmdletBinding()]
    Param (

        [parameter(Mandatory = $true)]
        [string]$NewName

    )

    Begin {}

    Process {

        if ($isLinux) {

            $Hostname = & hostname

            $Hosts = Get-Content /etc/hosts -Raw

            $Hosts -replace $Hostname, $NewName | Set-content $Hosts

            $Hosts = Get-Content /etc/hostname -Raw

            $Hosts -replace $Hostname, $NewName | Set-Content $Hosts

        }


    }

    End {}

}