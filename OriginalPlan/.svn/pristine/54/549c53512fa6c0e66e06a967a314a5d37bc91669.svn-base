#include "core/game_exception.h"

#include "script_engine_common.h"
#include "module_def.h"
#include "lua_cjson_util.h"
#include "script_library_header.h"

bool CScriptEngineCommon::bindToScript()
{
//	FUNC_BEGIN(SCRIPT_MOD);

	luaopen_lua_extensions(getState());

	TBaseType::bindToScript();

	ShareLibraryBindClass(getState());
	ShareLibraryBindFunc(getState());
	sharelibAutoBindClass(getState());

	return true;

//	FUNC_END(false);
}

CScriptEngineCommon::CScriptEngineCommon(bool openStdLib /*= false*/) : TBaseType(openStdLib)
{

}

CScriptEngineCommon::~CScriptEngineCommon()
{

}
