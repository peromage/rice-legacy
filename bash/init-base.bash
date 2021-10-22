### init-base.bash -- Bash config core

##------------------------------------------------------------------------------
## Basics
##------------------------------------------------------------------------------

rice_home_dir=$(dirname $(dirname $(realpath "$BASH_SOURCE")))
rice_scripts_dir="$rice_home_dir/scripts"

rice_include() {
    local module=$1 && shift
    . "$rice_home_dir/bash/$module.bash" $@
}

rice_source_if_exists() {
    local file=$1 && shift
    [ -f $file ] && . $file $@
}
