#!/bin/bash
### init.bash -- Bootstrap for Bash

################################################################################
## Prerequisites
################################################################################

## Make sure sourced by Bash
[[ -z $BASH_VERSION ]] && return

## Only sourced once
[[ -n $LOADED_RICE_BASH ]] && return
LOADED_RICE_BASH=1

## Only sourced in interactive sessions
case "$-" in
    *i*) ;;
    *) return;;
esac

## Directory where this script is
rice_home_dir=$(dirname $(realpath "$BASH_SOURCE"))

rice_include() {
    [[ ! -d $rice_home_dir ]] && return
    local file=$rice_home_dir/$1 && shift
    #local skip_not_exists=$1 && shift
    #[[ -n $skip_not_exists && ! -f $file ]] && return
    [[ ! -f $file ]] && return
    source $file $@
}

## PATH
PATH=$PATH:$rice_home_dir/scripts

################################################################################
## Load other files
################################################################################

rice_include bash/init-env.bash
rice_include bash/init-aliases.bash
rice_include bash/init-aliases-win.bash
rice_include bash/plugin-zlua.bash
rice_include bash/theme-normal.bash
rice_include local.bash
