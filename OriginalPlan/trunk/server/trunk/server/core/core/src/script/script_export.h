#ifndef _SCRIPT_EXPORT_H_
#define _SCRIPT_EXPORT_H_

extern "C"
{
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
}

LUA_API int luaopen_core(lua_State* L);

void registe_core_bind_lib(lua_State* L);

#endif