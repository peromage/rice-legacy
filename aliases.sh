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

## Emacs
## Open files in the terminal
alias em="emacsclient -c -nw"
## Open files in the current frame
alias emm="emacsclient -c -n"
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

## linuxbrew
brewenv() {
    alias brew="/home/linuxbrew/.linuxbrew/bin/brew"
    eval "$(brew shellenv)"
}

## Authentication agents
update-ssh-agent() {
    export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
    if [[ ! -e $SSH_AUTH_SOCK ]]; then
        eval $(ssh-agent -a $SSH_AUTH_SOCK)
    fi
}

update-gpg-agent() {
    unset SSH_AGENT_PID
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    export GPG_TTY="$(tty)"
    gpg-connect-agent updatestartuptty /bye > /dev/null
}

################################################################################
## mysy and cygwin
################################################################################
case "$OS" in
    *Windows*) ;;
    *windows*) ;;
    *) return;;
esac

alias msys2-update="pacman --needed -S bash pacman pacman-mirrors msys2-runtime"
alias cygwin-install="cygwin-setup --no-admin --no-shortcuts"
