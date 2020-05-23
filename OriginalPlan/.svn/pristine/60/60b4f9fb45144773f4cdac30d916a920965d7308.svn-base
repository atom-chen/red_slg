#include "script_lua_inc.h"
#include "number_class.h"
#include "game_exception.h"
#include "script_export.h"

namespace GXMISC
{
	void initLibFunc(lua_State* L)
	{
		registe_core_bind_lib(L);
	}

	CLuaVM::CLuaVM(bool bOpenStdLib)
	{
		_scriptState = NULL;
		_inc = this;
		if(bOpenStdLib){
			_scriptState = luaL_newstate();
			openStdLib();
			init(_scriptState);
		}
	}

	CLuaVM::~CLuaVM()
	{
		uninitScript();
		lua_close(_scriptState);
		_scriptState = NULL;
	}

	void CLuaVM::openStdLib()
	{
		luaL_openlibs(_scriptState);
	}

	bool CLuaVM::init(lua_State* pState)
	{
		_scriptState = pState;
		initLibFunc(_scriptState);
		lua_tinker::init(_scriptState);
		if(!bindToScript())
		{
			printf("Can't bind objects to script!");
			return false;
		}

		return true;
	}

	bool CLuaVM::doScript()
	{
		if(_nParseStatus == 0)
		{
			// 得到调用状态
			_nParseStatus = lua_pcall(_scriptState, 0, LUA_MULTRET, 0);
		}

		if(_nParseStatus != 0)
		{
			// 出错

			if(lua_isfunction(_scriptState, -1))
			{
				// 函数出错, 断言函数
				lua_getglobal(_scriptState, "_ALERT");		// 取出"_ALERT"函数
				lua_insert(_scriptState, -2);				// 下移一个位置
				lua_call(_scriptState, 1, 0);				// 调用_ALERT函数输出
			}
			else
			{
				// 脚本字符串
				const char* msg;
				msg = lua_tostring(_scriptState, -1);
				if(msg == NULL) {
					msg = "(error with no message)";
				}

				gxError("CATCHED Lua EXCEPTION -> err: {0}", msg);
				lua_pop(_scriptState, 1);
			}
		}

		return _nParseStatus == 0;
	}

	bool CLuaVM::doFile(const char* filename)
	{
		if((_nParseStatus = luaL_loadfile(_scriptState, filename)) == 0)
		{
			return doScript();
		}
		else
		{
			const char* errmsg = (const char*)lua_tostring(_scriptState, -1);
			if(errmsg == NULL)
			{
				errmsg = "";
			}

			lua_pop(_scriptState, 1);

			gxError("CATCHED Lua EXCEPTION -> err: {0}", errmsg);
		}

		return false;
	}

	bool CLuaVM::doString(const char* buffer)
	{
		return doBuffer(buffer, strlen(buffer));
	}

	bool CLuaVM::doBuffer(const char* buffer, size_t size)
	{
		if((_nParseStatus = luaL_loadbuffer(_scriptState, buffer, size, "LuaWrap")) == 0)
		{
			return doScript();
		}
		else
		{
			const char* errmsg = (const char*)lua_tostring(_scriptState, -1);

			if(errmsg == NULL)
			{
				errmsg = "";
			};

			lua_pop(_scriptState, 1);

			gxError("CATCHED Lua EXCEPTION -> err: {0}", errmsg);
		}

		return false;
	}

	bool CLuaVM::loadFileToBuffer(lua_State *L, const char *filename, char* szbuffer, int &maxlen, bool& loadlocal)
	{
		return false;
	}

	bool CLuaVM::isExistFunction(const char* name)
	{
		lua_getglobal(_scriptState, name);

		if(lua_type(_scriptState, -1) == LUA_TFUNCTION)
		{
			lua_pop(_scriptState, 1);
			return true;
		}
		else
		{
			lua_pop(_scriptState, 1);
			return false;
		}
	}

	sint32	CallErrHandler(lua_State* L)
	{
		FUNC_BEGIN("SCRIPT_MOD;");

		try{
			lua_Debug d;
			bool bSucceed = false;
			sint32 nLevel = 10;
			while (!bSucceed && nLevel>-1 )
			{
				bSucceed = lua_getstack(L, nLevel, &d) == 1;
				nLevel--;
			}
			std::string err;
			std::string msg;
			if ( !bSucceed || lua_getinfo(L, "Sln", &d) == 0)
			{
				err = "error :lua_getinfo failed";
			}
			else
			{
				err = lua_tostring(L, -1);
				lua_pop(L, 1);
				msg.append(d.short_src);
				msg.append( ":" );
				char str[1024];
				memset(str, 0, sizeof(str));
				sprintf(str, "%d", d.currentline);
				msg.append(  str );
				msg.append( "\n" );

				if (d.name != 0)
				{
					msg.append( "(" );
					msg.append( d.namewhat );
					msg.append( " " );
					msg.append( d.name );
					msg.append( ")" );
				}
				msg.append( " " );
				msg.append( err.c_str() );
				lua_pushstring(L, msg.c_str());
			}
			gxError( "{0}", msg);
		}
		catch(...)
		{
			gxError( "在获取lua错误信息时发生错误" );
		}

		return 1;

		FUNC_END(1);
	}

	bool CLuaVM::initScript( const char* fileName )
	{	
		if(!doFile(fileName))
		{
			gxError("Can't load lua file!{0}", fileName);
			return false;
		}
		else
		{
			_initScriptFileName = fileName;

			if(isExistFunction("InstallScript"))
			{
				vCall("InstallScript");
			}
		}

		return true;
	}

	bool CLuaVM::uninitScript()
	{
		if(isExistFunction("UnInstallScript"))
		{
			vCall("UnInstallScript");
		}

		return true;
	}

	bool CLuaVM::bindToScript()
	{
		return true;
	}

	bool CLuaVM::loadFile( const char* fileName )
	{
		if((_nParseStatus = luaL_loadfile(_scriptState, fileName)) == 0)
		{
			return true;
		}
		else
		{
			const char* errmsg = (const char*)lua_tostring(_scriptState, -1);
			if(errmsg == NULL)
			{
				errmsg = "";
			}

			lua_pop(_scriptState, 1);

			gxError("CATCHED Lua EXCEPTION -> err: {0}", errmsg);
		}

		return false;
	}
}