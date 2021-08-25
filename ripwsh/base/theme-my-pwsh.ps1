<###############################################################################

.SYNOPSIS
PowerShell standard theme

Created by peromage 2021/02/24
Last modified 2021/02/24

###############################################################################>

function global:prompt {
    $myPwd = { $pwd.Path -replace ([regex]::Escape($HOME)+'(.*)'),'~$1' }
    $hostname = [Environment]::MachineName
    $username = [Environment]::UserName
    if ($global:ri_meta.Privileged) {
        Write-Host -NoNewline -ForegroundColor Red "$username@$hostname "
        Write-Host -NoNewline -ForegroundColor White "$(&$myPwd)#"
    } else {
        Write-Host -NoNewline -ForegroundColor Green "$username@$hostname "
        Write-Host -NoNewline -ForegroundColor White "$(&$myPwd)$"
    }
    return " "
}
