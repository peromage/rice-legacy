<###
.SYNOPSIS
theme-my-pwsh.ps1
PowerShell standard theme
###>

function global:prompt {
    $myPwd = { $pwd.Path -replace ([regex]::Escape($HOME)+'(.*)'),'~$1' }
    $hostname = [Environment]::MachineName
    $username = [Environment]::UserName
    if ($rice.rooted) {
        Write-Host -NoNewline -ForegroundColor Red "$username@$hostname "
        Write-Host -NoNewline -ForegroundColor White "$(&$myPwd)#"
    } else {
        Write-Host -NoNewline -ForegroundColor Green "$username@$hostname "
        Write-Host -NoNewline -ForegroundColor White "$(&$myPwd)$"
    }
    return " "
}
