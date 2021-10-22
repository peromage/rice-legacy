#!/bin/bash
### init.bash -- Bootstrap for Bash

##------------------------------------------------------------------------------
## Prerequisites
##------------------------------------------------------------------------------

## Interactive sessions
case "$-" in
    *i*) ;;
    *) return;;
esac

## Bash
[ -z "$BASH_VERSION" ] && return

##------------------------------------------------------------------------------
## Bootstrap
##------------------------------------------------------------------------------

## Modules
. $(dirname $(realpath "$BASH_SOURCE"))/bash/init-base.bash
rice_include theme-normal
rice_include plugin-zlua

## PATH
export PATH="$PATH:$rice_scripts_dir"

## Local config
rice_source_if_exists "$rice_home_dir/aliases.sh"
rice_source_if_exists "$rice_home_dir/local.bash"
