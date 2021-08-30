#!/usr/bin/bash
### init.sh -- Bootstrap for Bash

## Pre-checks
## Is session interactive
case "$-" in
    *i*) ;;
    *) return;;
esac
## Is shell bash
[ -z "$BASH_VERSION" ] && return
## No nested loading
[ -n "$rice_loaded" ] && return

## Environment initialization
rice_loaded=1
rice_home=$(dirname $(realpath "$BASH_SOURCE"))
rice_scripts="$rice_home/scripts"
rice_local="$rice_home/local.bash"
export PATH="$PATH:$rice_scripts"
rice_inc() {
    _tmp="$1" && shift
    . "$rice_home/shell/$_tmp.sh" $@
}

## Bootstrap
rice_inc init-env
rice_inc init-cmd
rice_inc init-windows
rice_inc theme-normal
rice_inc plugin-zlua

## Wrapup
if [ -f "$rice_local" ]; then
    . "$rice_local"
fi
