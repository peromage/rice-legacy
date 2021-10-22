<#
.SYNOPSIS
theme-normal.ps1
Normal mediocre prompt
#>

function global:_simplifyHomePath {
    $pwd.Path -replace ([regex]::Escape($HOME)+'(.*)'),'~$1'
}

if ($rice.root_user) {
function global:prompt {
    Write-Host -NoNewline -ForegroundColor DarkGray "["
    Write-Host -NoNewline -ForegroundColor Red "$([Environment]::UserName)"
    Write-Host -NoNewline -ForegroundColor DarkGray "@"
    Write-Host -NoNewline -ForegroundColor Red "$([Environment]::MachineName)"
    Write-Host -NoNewline " "
    Write-Host -NoNewline -ForegroundColor Red "$(_simplifyHomePath)"
    Write-Host -NoNewline -ForegroundColor DarkGray "]!>"
    return " "
}} else {
function global:prompt {
    Write-Host -NoNewline -ForegroundColor DarkGray "["
    Write-Host -NoNewline -ForegroundColor Blue "$([Environment]::UserName)"
    Write-Host -NoNewline -ForegroundColor DarkGray "@"
    Write-Host -NoNewline -ForegroundColor Blue "$([Environment]::MachineName)"
    Write-Host -NoNewline " "
    Write-Host -NoNewline -ForegroundColor Cyan "$(_simplifyHomePath)"
    Write-Host -NoNewline -ForegroundColor DarkGray "]>"
    return " "
 }}
