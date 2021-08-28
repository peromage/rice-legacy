<###
.SYNOPSIS
init.ps1
PowerShell bootstrap
###>

## Pwsh minimal version required
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "PowerShell is old. Please use version 7 or above"
    return
}
## No nested loading
if ($rice.loaded) { return }

## Environment initialization
$global:rice = @{}
$rice.loaded = 1
$rice.home = $PSScriptRoot
$rice.scripts = Join-Path $rice.home scripts
$rice.local = Join-Path $rice.home local.ps1
$rice.rooted = if ($IsWindows) {
    ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
} else {
    (id -u) -eq 0
}
$env:PATH += [IO.Path]::PathSeparator + $rice.scripts
function rice_inc {
    param ($source)
    . "$(Join-Path $rice.home pwsh $source).ps1" @args
}

## Bootstrap
rice_inc init-env
rice_inc init-cmd
rice_inc init-windows
rice_inc theme-my-pwsh
rice_inc plugin-zlua

## Wrapup
if (Test-Path $rice.local) {
    . $rice.local
}
