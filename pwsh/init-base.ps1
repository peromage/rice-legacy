<#
.SYNOPSIS
init-base.ps1
Pwsh core config
#>

<#------------------------------------------------------------------------------
Basics
------------------------------------------------------------------------------#>

$global:rice = @{}
$rice.home_dir = (Get-Item $PSScriptRoot).Parent.FullName
$rice.scripts_dir = Join-Path $rice.home_dir scripts
$rice.root_user = if ($IsWindows) {
    ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
} else {
    (id -u) -eq 0
}

function rice_include {
    param ($module)
    . "$(Join-Path $rice.home_dir pwsh $module).ps1" @args
}

function rice_source_if_exists {
    param ($source)
    if (Test-Path -PathType Leaf $source) {
        . $source @args
    }
}

<#------------------------------------------------------------------------------
PSReadLine
------------------------------------------------------------------------------#>

&{
    $my_psreadline_options = @{
        EditMode = "Emacs"
        HistoryNoDuplicates = $true
        HistorySearchCursorMovesToEnd = $true
        HistorySearchCaseSensitive = $false
        HistorySaveStyle = "SaveIncrementally"
        PredictionSource = "History"
    }
    Set-PSReadLineOption @my_psreadline_options
}

