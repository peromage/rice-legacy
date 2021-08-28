<###
.SYNOPSIS
theme-my-lite.ps1
PowerShell lite theme
###>

function global:prompt {
    $myPwd = { $pwd.Path -replace ([regex]::Escape($HOME)+'(.*)'),'~$1' }
    if ($rice.rooted) {
        Write-Host -NoNewline -ForegroundColor Red "! $(&$myPwd)"
    } else {
        Write-Host -NoNewline -ForegroundColor Green "> $(&$myPwd)"
    }
    return " "
}
