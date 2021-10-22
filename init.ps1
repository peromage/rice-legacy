<#
.SYNOPSIS
init.ps1
PowerShell bootstrap
#>

<#------------------------------------------------------------------------------
Prerequisites
------------------------------------------------------------------------------#>

if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "PowerShell is old. Please use version 7 or above"
    return
}

<#------------------------------------------------------------------------------
Bootstrap
------------------------------------------------------------------------------#>

## Modules
. $PSScriptRoot/pwsh/init-base.ps1
. rice_include init-lib-windows
. rice_include theme-my-pwsh
. rice_include plugin-zlua

## PATH
$env:PATH += [IO.Path]::PathSeparator + $rice.scripts_dir

## Local config
. rice_source_if_exists (Join-Path $rice.home_dir aliases.ps1)
. rice_source_if_exists (Join-Path $rice.home_dir local.ps1)
