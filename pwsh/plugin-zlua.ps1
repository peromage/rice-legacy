<###
.SYNOPSIS
plugin-zlua.ps1
PowerShell bootstrap
###>

param ($lua_bin="lua54")

$_lua_bin = Get-Command $lua_bin -ErrorAction SilentlyContinue
if ($null -eq $_lua_bin) {
    return
}

Invoke-Expression (
    (Invoke-Expression "($($_lua_bin.Source) $(Join-Path $rice.scripts z.lua) --init powershell enhanced once)") `
    -join "`n")
Remove-Variable _lua_bin
