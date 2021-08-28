#!/bin/sh
### init-cmd.sh -- A collection for aliases and commands

alias ll="ls -lahF --color=always --group-directories-first"
alias brew="HOMEBREW_NO_AUTO_UPDATE=1 PATH=/home/linuxbrew/.linuxbrew/bin:$PATH /home/linuxbrew/.linuxbrew/bin/brew"

# z.lua
alias zb='z -b'
alias zc='z -c'
alias zi='z -i'
alias zf='z -I'

# fzf
ffdo() {
    if [ -z "$1" ]; then
        echo "Usage: ffdo <prog>"
        return
    fi
    eval "$1 $@ \$(fzf)"
}

ffcd() {
    _tmp="$(fzf)"
    [ -n "$_tmp" ] && cd "$_tmp"
}

# lf
lfcd() {
    _tmp="$(mktemp)"
    lf -last-dir-path="$_tmp" "$@"
    if [ -f "$_tmp" ]; then
        _tmp1="$(cat "$_tmp")"
        rm -f "$_tmp"
        if [ -d "$_tmp1" ] && [ "$_tmp1" != "$(pwd)" ]; then
            cd "$_tmp1"
        fi
    fi
}

# ranger
ranger() {
    if [ -n "$RANGER_LEVEL" ]; then
        echo "nested ranger!"
        return
    fi
    ranger "$@"
}
