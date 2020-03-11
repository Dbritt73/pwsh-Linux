#!/usr/bin/env powershell

Function Get-NetworkInformation {
  <#
    .SYNOPSIS
    Describe purpose of "Get-NetworkInformation" in 1-2 sentences.

    .DESCRIPTION
    Add a more complete description of what the function does.

    .EXAMPLE
    Get-NetworkInformation
    Describe what this call does

    .NOTES
    Place additional notes here.

    .LINK
    URLs to related sites
    The first link is opened by Get-Help -Online Get-NetworkInformation

    .INPUTS
    List of input types that are accepted by this function.

    .OUTPUTS
    List of output types produced by this function.
  #>
    [CmdletBinding()]
    Param ()

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

    } Catch {

        # get error record
        [Management.Automation.ErrorRecord]$e = $_

        # retrieve information about runtime error
        $info = [PSCustomObject]@{

            Exception = $e.Exception.Message
            Reason    = $e.CategoryInfo.Reason
            Target    = $e.CategoryInfo.TargetName
            Script    = $e.InvocationInfo.ScriptName
            Line      = $e.InvocationInfo.ScriptLineNumber
            Column    = $e.InvocationInfo.OffsetInLine

        }

        # output information. Post-process collected info, and log info (optional)
        Write-Output -InputObject $info

}

}