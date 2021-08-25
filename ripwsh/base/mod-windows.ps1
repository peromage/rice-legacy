<###############################################################################

.SYNOPSIS
Utilities for Windows Only

Created by peromage 2021/02/24
Last modified 2021/02/24

###############################################################################>

<#------------------------------------------------------------------------------
Admin related
------------------------------------------------------------------------------#>
function testAdmin {
    return ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
        [Security.Principal.WindowsBuiltinRole]::Administrator)
}

function runasAdmin {
    if (testAdmin) {
        Write-Output "You are admin already!"
    } else {
        if ($args.Length -eq 0) {
            Write-Output "Usage: runasAdmin <command> [arguments]"
        } elseif ($args.Length -ge 1) {
            $commands = "-noexit -command cd $pwd;" + ($args -join ' ')
            $proc = New-Object -TypeName System.Diagnostics.Process
            $proc.StartInfo.FileName = "pwsh.exe"
            $proc.StartInfo.Arguments = $commands
            $proc.StartInfo.UseShellExecute = $true
            $proc.StartInfo.Verb = "runas"
            $proc.Start() | Out-Null
        }
    }
}

function evaltoAdmin {
    if (testAdmin) {
        Write-Output "You are admin already!"
    } else {
        $commands = "-noexit -command cd $pwd;"
        $proc = New-Object -TypeName System.Diagnostics.Process
        $proc.StartInfo.FileName = "pwsh.exe"
        $proc.StartInfo.Arguments = $commands
        $proc.StartInfo.UseShellExecute = $true
        $proc.StartInfo.Verb = "runas"
        $proc.Start() | Out-Null
    }
}

<#------------------------------------------------------------------------------
Operation of path
------------------------------------------------------------------------------#>
function getEnvUserPath {
    $path = [Environment]::GetEnvironmentVariable(
        "Path", [EnvironmentVariableTarget]::User)
    if ($null -eq $path) {
        return ""
    }
    return $path
}

function updateSessionPath {
    $env:Path = @(
        [Environment]::GetEnvironmentVariable(
            "Path", [EnvironmentVariableTarget]::Machine),
        [Environment]::GetEnvironmentVariable(
            "Path", [EnvironmentVariableTarget]::User)) -join ";"
}

function setEnvUserPath {
    param([string]$path)
    if (-not $path.EndsWith(";")) {
        $path = $path + ";"
    }
    [Environment]::SetEnvironmentVariable(
        "Path", $path, [EnvironmentVariableTarget]::User)
    updateSessionPath
}

function testEnvUserPath {
    param([string]$path)
    $currPath = getEnvUserPath
    $arr = $currPath.Split(';')
    foreach ($_ in $arr) {
        if ($_.EndsWith($path)) {
            return $true
        }
    }
    return $false
}

function addEnvUserPath {
    param([string]$path)
    if (testEnvUserPath $path) {
        return
    }
    if (-not $path.EndsWith(";")) {
        $path = $path + ";"
    }
    $currPath = getEnvUserPath
    if (-not $currPath.EndsWith(";")) {
        $currPath = $currPath + ";"
    }
    $currPath = $currPath + $path
    setEnvUserPath $currPath
}

function removeEnvUserPath {
    param([string]$path)
    if (-not (testEnvUserPath $path)) {
        return
    }
    $currPath = getEnvUserPath
    $arr = $currPath.Split(';')
    $newPath = ""
    foreach ($_ in $arr) {
        if ($_.EndsWith($path)) {
            continue
        }
        if ($_ -eq "") {
            continue
        }
        $newPath = $newPath + $_ + ";"
    }
    setEnvUserPath $newPath
}

<#------------------------------------------------------------------------------
Operation of environment variables
------------------------------------------------------------------------------#>
function setEnvUserVars {
    param([hashtable]$envVarHash)
    foreach ($_ in $envVarHash.GetEnumerator()) {
        [Environment]::SetEnvironmentVariable(
            $_.Key, $_.Value, [EnvironmentVariableTarget]::User)
    }
}

function removeEnvUserVars {
    param([hashtable]$envVarHash)
    foreach ($_ in $envVarHash.GetEnumerator()) {
        [Environment]::SetEnvironmentVariable(
            $_.Key, $null, [EnvironmentVariableTarget]::User)
    }
}

<#------------------------------------------------------------------------------
Cygwin
------------------------------------------------------------------------------#>
function setupCygwin {
    cygwin-setup --no-admin --no-desktop --no-shortcuts --no-startmenu @args
}

<#------------------------------------------------------------------------------
Aliases
------------------------------------------------------------------------------#>
Set-Alias sudo runasAdmin
Set-Alias su evaltoAdmin
Set-Alias issu testAdmin
Set-Alias cygwin-install setupCygwin
