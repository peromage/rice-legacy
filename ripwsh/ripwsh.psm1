<###############################################################################

.SYNOPSIS
Rice root module. Initialization will be done in this module.

Created by peromage 2021/02/24
Last modified 2021/03/14

###############################################################################>

param([hashtable]$config=@{})

<#------------------------------------------------------------------------------
Default config variables
------------------------------------------------------------------------------#>
# Default configurations
$global:ri_config = @{

    # CLI prompt theme
    theme = ""

    # Additional mods
    mods = @()

}
# Update based on passed-in config
foreach ($_ in $config.GetEnumerator()) {
    $ri_config[$_.Key] = $_.Value
}

<#------------------------------------------------------------------------------
Meta
------------------------------------------------------------------------------#>
$global:ri_meta = @{}

$ri_meta.Privileged = if ($IsWindows) {
    ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
} else { (id -u) -eq 0 }

$ri_meta.PwshHome = $PSScriptRoot

$ri_meta.Home = [IO.Path]::GetDirectoryName($ri_meta.PwshHome)


<#------------------------------------------------------------------------------
Helper functions
------------------------------------------------------------------------------#>
# This is faster than the trivial sourcing
# In order to source the script in current scope, source the returned scriptblock
function ri_source_script {
    param([string]$rel_path)
    $abs_path = Join-Path $ri_meta.PwshHome $rel_path
    return [scriptblock]::Create([IO.File]::ReadAllText($abs_path, [Text.Encoding]::UTF8))
}

# Just normalize the given path. No file checks
function ri_normalize_path {
    param([string]$path)
    return $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
}

<#------------------------------------------------------------------------------
Initialization
------------------------------------------------------------------------------#>
# Sourcing base scripts
. (ri_source_script base/init-settings.ps1)

# Load theme
if (-not ([string]::IsNullOrWhiteSpace($ri_config.theme))) { . (ri_source_script base/theme-$($ri_config.theme).ps1) }

# Load additional mods
$ri_config.mods | ForEach-Object { . (ri_source_script base/mod-$_.ps1) }

# Add script path
$p = ri_normalize_path "$($ri_meta.Home)/bin"
if (-not ($env:PATH -match [regex]::Escape($p))) {
    $env:PATH += [IO.Path]::PathSeparator + $p
}
