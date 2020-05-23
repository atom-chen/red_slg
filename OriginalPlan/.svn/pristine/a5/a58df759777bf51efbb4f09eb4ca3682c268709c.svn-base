#include "core/script/script_export.h"
#include "core/script/lua_tinker.h"
#include "core/script/script_lua_inc.h"

#include "script_export_mapserver.h"

#include "map_server.h"

CMapServer* NewMapServer(const std::string& serverName)
{
	return new CMapServer(serverName);
}

int luaNewMapServer(lua_State* tolua_S)
{
	int argc = 0;
	bool ok = true;

	tolua_Error tolua_err;

	if (!tolua_isstring(tolua_S, 1, 0, &tolua_err)) goto tolua_lerror;

	argc = lua_gettop(tolua_S);
	if (argc == 1)
	{
		std::string arg0;
		ok &= luaval_to_std_string(tolua_S, 1, &arg0, "luaNewMapServer");
		if (!ok)
			return 0;

		CMapServer::InitStaticInstanace(tolua_S);
		CMapServer* pServer = NewMapServer(arg0);
		object_to_luaval<CMapServer>(tolua_S, "CMapServer", (CMapServer*)pServer);

		return 1;
	}
	CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "luaNewMapServer", argc, 1);
	return 0;

tolua_lerror:
	tolua_error(tolua_S, "#ferror in function 'luaNewService'.", &tolua_err);
	return 0;
}

// µ¼³öº¯Êý
LUA_API int luaopen_mapserver(lua_State* L)
{
	lua_pushcclosure(L, luaNewMapServer, 0);
	lua_setglobal(L, "NewMapServer");

	return 1;
}