### init-lib-windows.sh -- Shell in Windows

##------------------------------------------------------------------------------
## For Windows only e.g. mysys, cygwin
##------------------------------------------------------------------------------

case "$OS" in
    *Windows*) ;;
    *windows*) ;;
    *) return;;
esac

alias win_msys_update="pacman --needed -S bash pacman pacman-mirrors msys2-runtime"
alias win_cygwin_install="cygwin-setup --no-admin --no-desktop --no-shortcuts --no-startmenu"
