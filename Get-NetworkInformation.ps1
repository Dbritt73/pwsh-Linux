#!/usr/bin/env powershell

Function Get-NetworkInformation {

    Try {

        if ($IsLinux) {

            (ip a)

        }

        if ($IsWindows) {

            Get-NetIPConfiguration

        }

        if ($IsMacOS) {

            ifconfig

        }

    } Catch {}

}