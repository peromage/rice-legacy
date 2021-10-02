#!/bin/bash
### init.sh -- Bootstrap for Bash

##------------------------------------------------------------------------------
## Pre-checks
##------------------------------------------------------------------------------

## interactive sessions
case "$-" in
    *i*) ;;
    *) return;;
esac
## Bash
[ -z "$BASH_VERSION" ] && return
## No nested loading
[ -n "$rice_loaded" ] && return

##------------------------------------------------------------------------------
## Environment initialization
##------------------------------------------------------------------------------

rice_loaded=1
rice_home_dir=$(dirname $(realpath "$BASH_SOURCE"))
rice_scripts_dir="$rice_home_dir/scripts"
rice_local_file="$rice_home_dir/local.bash"
export PATH="$PATH:$rice_scripts_dir"

rice_inc() {
    local module="$1" && shift
    . "$rice_home_dir/sh/$module.sh" $@
}

##------------------------------------------------------------------------------
## Bootstrap
##------------------------------------------------------------------------------

rice_inc init-lib-windows
rice_inc init-aliases
rice_inc theme-normal
rice_inc plugin-zlua

##------------------------------------------------------------------------------
## Wrapup
##------------------------------------------------------------------------------

[ -f "$rice_local_file" ] && . "$rice_local_file"
