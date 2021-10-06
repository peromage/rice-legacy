### init-aliases.sh -- A collection for aliases and commands

##------------------------------------------------------------------------------
## Utility wrappers
##------------------------------------------------------------------------------

alias ll="ls -lahF --color=always --group-directories-first"

##------------------------------------------------------------------------------
## Linuxbrew
##------------------------------------------------------------------------------

alias brew="HOMEBREW_NO_AUTO_UPDATE=1 PATH=/home/linuxbrew/.linuxbrew/bin:$PATH /home/linuxbrew/.linuxbrew/bin/brew"

##------------------------------------------------------------------------------
## Emacs
##------------------------------------------------------------------------------

## Open files in the terminal
alias em="emacsclient -c -nw"
## Open files in the current frame
alias emm="emacsclient -n"
## Emacs daemon
alias emdaemon="emacs --daemon"
## Emacs file manager
ef() {
    if [ -n "$1" ]; then
        emacs -Q -nw --eval "(progn (xterm-mouse-mode 1) (dired \"$1\"))"
        return
    fi
    emacs -Q -nw --eval "(progn (xterm-mouse-mode 1) (dired \"~\"))"
}

##------------------------------------------------------------------------------
## lf
##------------------------------------------------------------------------------

lfcd() {
    _tmp="$(mktemp)"
    lf -last-dir-path="$_tmp" $@
    if [ -f "$_tmp" ]; then
        _dir="$(cat "$_tmp")"
        rm -f "$_tmp"
        if [ -d "$_dir" ] && [ "$_dir" != "$(pwd)" ]; then
            cd "$_dir"
        fi
    fi
    unset _tmp _dir
}

##------------------------------------------------------------------------------
## ranger
##------------------------------------------------------------------------------

rf() {
    if [ -n "$RANGER_LEVEL" ]; then
        echo "Nested ranger!"
        return
    fi
    ranger $@
}

##------------------------------------------------------------------------------
## fzf
##------------------------------------------------------------------------------

ffdo() {
    if [ -z "$1" ]; then
        echo "Usage: ffdo <cmd> [arguments]"
        return
    fi
    _cmd="$1" && shift
    _target="$(fzf)"
    [ -n "$_target" ] && eval "$_cmd $@ $_target"
    unset _cmd _target
}

ffcd() {
    _target="$(fzf)"
    [ -n "$_target" ] && cd "$_target"
    unset _target
}

##------------------------------------------------------------------------------
## mysy and cygwin
##------------------------------------------------------------------------------

case "$OS" in
    *Windows*) ;;
    *windows*) ;;
    *) return;;
esac

alias win_msys_update="pacman --needed -S bash pacman pacman-mirrors msys2-runtime"
alias win_cygwin_install="cygwin-setup --no-admin --no-desktop --no-shortcuts --no-startmenu"
