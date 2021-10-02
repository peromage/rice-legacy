### plugin-zlua.sh -- Z.lua Initialization

# Provide a custom lua binary
if [ -n "$1" ]; then
    _lua_bin="$1"
else
    # Fallback version
    _lua_bin=lua5.3
fi

which "$_lua_bin" 1>/dev/null 2>&1
if [ "$?" -eq 0 ]; then
    eval "$($_lua_bin $rice_scripts_dir/z.lua --init bash enhanced once)"
    ## z.lua aliases
    alias zb='z -b'
    alias zc='z -c'
    alias zi='z -i'
    alias zf='z -I'
fi

unset _lua_bin
