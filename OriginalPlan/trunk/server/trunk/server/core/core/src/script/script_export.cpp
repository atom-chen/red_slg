#include "script_export.h"
#include "lua_tinker.h"
#include "script_lua_inc.h"
#include "autobind/corelib.hpp"

#include "mini_server.h"

GXMISC::CMiniServer* NewServer(const lua_tinker::s_object& serverName, const std::string& needRequireFile, const std::string& newServerScriptFunction)
{
	const char* _scriptBuffer
		= "function _gx_NewServer(name) return CMiniServer:new(name); end";
	lua_tinker::dobuffer(serverName.interpreter(), _scriptBuffer, strlen(_scriptBuffer));
	
	GXMISC::CLuaVM* pScriptEngine = new GXMISC::CLuaVM(false);
	pScriptEngine->init(serverName.interpreter());

	GXMISC::CMiniServer* pService = lua_tinker::call<GXMISC::CMiniServer*>(serverName.interpreter(), "_gx_NewServer", serverName);
	pService->setScriptEngine(pScriptEngine);
	pService->setMainScriptName(needRequireFile);
	pService->setNewServiceFunctionName(newServerScriptFunction);

	return pService;
}

int luaNewService(lua_State* tolua_S)
{
	int argc = 0;
	bool ok = true;

	tolua_Error tolua_err;

	if (!tolua_isstring(tolua_S, 1, 0, &tolua_err)) goto tolua_lerror;

	argc = lua_gettop(tolua_S);
	if (argc == 3)
	{
		lua_tinker::s_object obj;
		obj = lua_tinker::read<lua_tinker::s_object>(tolua_S, 1);

		std::string arg0;
		ok &= luaval_to_std_string(tolua_S, 2, &arg0, "LuaNewService");
		if (!ok)
			return 0;

		std::string arg1;
		ok &= luaval_to_std_string(tolua_S, 3, &arg1, "LuaNewService");
		if (!ok)
			return 0;
		
		GXMISC::CMiniServer* pServer = NewServer(obj, arg0, arg1);
		object_to_luaval<GXMISC::CMiniServer>(tolua_S, "CMiniServer", (GXMISC::CMiniServer*)pServer);
		return 1;
	}
	CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "luaNewService", argc, 1);
	return 0;
tolua_lerror:
	tolua_error(tolua_S, "#ferror in function 'luaNewService'.", &tolua_err);
	return 0;
}

static void registe_all_manual_core(lua_State* L)
{
	
}

void registe_core_bind_lib(lua_State* L)
{
	registe_all_manual_core(L);
	register_all_corelib(L);
}

// µ¼³öº¯Êý
LUA_API int luaopen_core(lua_State* L)
{
	lua_pushcclosure(L, luaNewService, 0);
	lua_setglobal(L, "NewServer");

	return 1;
}