#ifndef _SCRIPT_EXPORT_MAPSERVER_H__
#define _SCRIPT_EXPORT_MAPSERVER_H__

extern "C"
{
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
}

LUA_API int luaopen_mapserver(lua_State* L);

#endif //_SCRIPT_EXPORT_MAPSERVER_H__