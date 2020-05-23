#ifndef _LUA_CJSON_UTIL_H_
#define _LUA_CJSON_UTIL_H_

extern "C"
{
#include "lua/lua.h"
#include "lua/lauxlib.h"
#include "lua/lualib.h"
}

void luaopen_lua_extensions(lua_State *L);

#endif	// _LUA_CJSON_UTIL_H_