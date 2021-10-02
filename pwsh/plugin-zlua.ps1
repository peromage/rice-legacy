<###
.SYNOPSIS
plugin-zlua.ps1
PowerShell bootstrap
###>

param ($lua_bin="lua5.3")

$_lua_bin = Get-Command $lua_bin -ErrorAction SilentlyContinue
if ($null -ne $_lua_bin) {
    Invoke-Expression ((Invoke-Expression "($($_lua_bin.Source) $(Join-Path $rice.scripts_dir z.lua) --init powershell enhanced once)") -join "`n")
    ## z.lua
    function zb { z -b @args }
    function zc { z -c @args }
    function zi { z -i @args }
    function zf { z -I @args }
}

Remove-Variable _lua_bin
