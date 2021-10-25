### aliases.sh -- Rice Environment variables

## Environment variables
export EDITOR=vim

## XDG
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

## Input method
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

## Common aliases
alias ll="ls -lahF --color=auto"
alias brew="HOMEBREW_NO_AUTO_UPDATE=1 PATH=/home/linuxbrew/.linuxbrew/bin:$PATH /home/linuxbrew/.linuxbrew/bin/brew"

## Emacs
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
    else
        emacs -Q -nw --eval "(progn (xterm-mouse-mode 1) (dired \"~\"))"
    fi
}

## lf
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

## ranger
rf() {
    if [ -n "$RANGER_LEVEL" ]; then
        echo "Nested ranger!"
        return
    fi
    ranger $@
}

## fzf
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

## mysy and cygwin
case "$OS" in
    *Windows*) ;;
    *windows*) ;;
    *) return;;
esac

alias win_msys_update="pacman --needed -S bash pacman pacman-mirrors msys2-runtime"
alias win_cygwin_install="cygwin-setup --no-admin --no-desktop --no-shortcuts --no-startmenu"
