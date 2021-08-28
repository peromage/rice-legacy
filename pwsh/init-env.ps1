<###
.SYNOPSIS
init-env.ps1
Environment variable setup for the session
###>

$env:EDITOR = "vim"
$env:SHELL = "pwsh"
$env:XDG_DATA_HOME = Join-Path $HOME ".local/share"
$env:XDG_CONFIG_HOME = Join-Path $HOME ".config"
$env:XDG_CACHE_HOME = Join-Path $HOME ".cache"
