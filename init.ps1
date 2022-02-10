### init.ps1 -- PowerShell bootstrap

################################################################################
## Prerequisites
################################################################################

## Use PowerShell 7 and above
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "PowerShell is old. Please use version 7 or above"
    return
}

$global:rice = @{
    home_dir = $PSScriptRoot
    is_root = if ($IsWindows) {
        ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
    } else {
        (id -u) -eq 0
    }
}

function rice_include {
    param ($file)
    $file = Join-Path $rice.home_dir $file
    if (Test-Path -PathType Leaf $file) {
        . $file @args
    }
}

## PATH
$env:PATH += [IO.Path]::PathSeparator + (Join-Path $rice.home_dir scripts)

################################################################################
## Load other files
################################################################################

## A workaround to source files from a function call
. rice_include pwsh/init-env.ps1
. rice_include pwsh/init-aliases.ps1
. rice_include pwsh/init-aliases-win.ps1
. rice_include pwsh/plugin-zlua.ps1
. rice_include pwsh/theme-my-pwsh.ps1
. rice_include local.ps1
