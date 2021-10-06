<###
.SYNOPSIS
init-aliases.ps1
Common utility functions
###>

<#------------------------------------------------------------------------------
Utility wrappers
------------------------------------------------------------------------------#>

if ("Alias" -eq (Get-Command ls).CommandType) {
    # On Windows, ls is an alias of Get-ChildItem
    function ll {
        [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName="sortByDefault")]
        param (
            [Parameter(Position=0)][string]$path=$PWD.Path,
            [Parameter(Mandatory=$false, ParameterSetName="sortByWriteTime")][switch]$write,
            [Parameter(Mandatory=$false, ParameterSetName="sortByAccessTime")][switch]$access,
            [Parameter(Mandatory=$false, ParameterSetName="sortByCreationTime")][switch]$creation,
            [Parameter(Mandatory=$false, ParameterSetName="sortByName")][switch]$name,
            [Parameter(Mandatory=$false, ParameterSetName="sortBySize")][switch]$size
        )
        if ($write) {
            Get-ChildItem $path `
            | Sort-Object LastWriteTime `
            | Select-Object Mode,Length,LastWriteTime,Name,Target `
            | Format-Table -AutoSize
        } elseif ($access) {
            Get-ChildItem $path `
            | Sort-Object LastAccessTime `
            | Select-Object Mode,Length,LastAccessTime,Name,Target `
            | Format-Table -AutoSize
        } elseif ($creation) {
            Get-ChildItem $path `
            | Sort-Object CreationTime `
            | Select-Object Mode,Length,CreationTime,Name,Target `
            | Format-Table -AutoSize
        } elseif ($name) {
            Get-ChildItem $path `
            | Sort-Object Name `
            | Select-Object Mode,Length,LastWriteTime,Name,Target `
            | Format-Table -AutoSize
        } elseif ($size) {
            Get-ChildItem $path `
            | Sort-Object Length `
            | Select-Object Mode,Length,LastWriteTime,Name,Target `
            | Format-Table -AutoSize
        } else {
            Get-ChildItem $path `
            | Select-Object Mode,Length,LastWriteTime,Name,Target `
            | Format-Table -AutoSize
        }
    }
} else {
    function ll {
        ls -lahF --color=always --group-directories-first @args
    }
}


<#------------------------------------------------------------------------------
Linuxbrew
------------------------------------------------------------------------------#>

function brew {
    env HOMEBREW_NO_AUTO_UPDATE=1 PATH=/home/linuxbrew/.linuxbrew/bin:$PATH /home/linuxbrew/.linuxbrew/bin/brew @args
}

<#------------------------------------------------------------------------------
Emacs
------------------------------------------------------------------------------#>

## Open files in the terminal
function em {
    emacsclient -c -nw @args
}
## Open files in the current frame
function emm {
    emacsclient -n @args
}
## Emacs daemon
function emdaemon {
    emacs --daemon @args
}
## Emacs file manager
function ef {
    param ($dir="~")
    emacs -Q -nw --eval "(progn (xterm-mouse-mode 1) (dired \`"$dir\`"))"
}

<#------------------------------------------------------------------------------
lf
------------------------------------------------------------------------------#>

function lfcd {
    $tmp = [IO.Path]::GetTempFileName()
    lf "-last-dir-path=$tmp"
    if (Test-Path -PathType Leaf $tmp) {
        $dst = Get-Content $tmp
        Remove-Item $tmp
        if ((Test-Path -PathType Container $dst) -and ($dst -ne $pwd.Path)) {
            Set-Location $dst
        }
    }
}

<#------------------------------------------------------------------------------
ranger
------------------------------------------------------------------------------#>

function rf {
    if ($null -ne $RANGER_LEVEL) {
        Write-Host "Nested ranger!"
        return
    }
    ranger @args
}

<#------------------------------------------------------------------------------
fzf
------------------------------------------------------------------------------#>

function ffdo {
    param ($cmd)
    if ($null -eq $cmd) {
        Write-Host "Usage: ffdo <cmd> [arguments]"
        return
    }
    $target = fzf
    if ($null -ne $target) {
        Invoke-Expression "$cmd $args $target"
    }
}

function ffcd {
    $target = fzf
    if ($null -ne $target) {
        Set-Location $target
    }
}

<#------------------------------------------------------------------------------
cygwin
------------------------------------------------------------------------------#>

if (-not $IsWindows) {
    return
}

function cygwin {
    cygwin-install --no-admin --no-desktop --no-shortcuts --no-startmenu @args
}
