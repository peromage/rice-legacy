#!/bin/sh
### plugin-zlua.sh -- Z.lua Initialization

if [ -n "$1" ]; then
    _lua_bin="$1"
else
    # Fallback version
    _lua_bin=lua5.3
fi

which "$_lua_bin" 1>/dev/null 2>&1
if [ "$?" -eq "1" ]; then
    return
fi

eval "$($_lua_bin $rice_scripts/z.lua --init bash enhanced once)"
unset _lua_bin
