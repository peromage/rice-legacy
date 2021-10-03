<###
.SYNOPSIS
init.ps1
PowerShell bootstrap
###>

<#------------------------------------------------------------------------------
Pwsh minimal version required
------------------------------------------------------------------------------#>

if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "PowerShell is old. Please use version 7 or above"
    return
}
## No nested loading
if ($rice.loaded) { return }

<#------------------------------------------------------------------------------
Environment initialization
------------------------------------------------------------------------------#>

$global:rice = @{}
$rice.loaded = $true
$rice.home_dir = $PSScriptRoot
$rice.scripts_dir = Join-Path $rice.home_dir scripts
$rice.local_file = Join-Path $rice.home_dir local.ps1
$rice.root_user = if ($IsWindows) {
    ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
} else {
    (id -u) -eq 0
}
$env:PATH += [IO.Path]::PathSeparator + $rice.scripts_dir

function rice_inc {
    param ($source)
    . "$(Join-Path $rice.home_dir pwsh $source).ps1" @args
}

<#------------------------------------------------------------------------------
Bootstrap
------------------------------------------------------------------------------#>

. rice_inc init-base
. rice_inc init-aliases
. rice_inc init-lib-windows
. rice_inc theme-my-pwsh
. rice_inc plugin-zlua

<#------------------------------------------------------------------------------
Wrapup
------------------------------------------------------------------------------#>

if (Test-Path $rice.local_file) {
    . $rice.local_file
}
