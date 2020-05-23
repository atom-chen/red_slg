#include "world_script_engine.h"
#include "core/game_exception.h"
#include "module_def.h"

extern bool BindClass(CScriptEngineCommon::TScriptState* pState);
extern bool BindFunc(CScriptEngineCommon::TScriptState* pState);
extern bool worldserverAutoBindClass(CScriptEngineCommon::TScriptState* pState);

bool CWorldScriptEngine::bindToScript()
{
	FUNC_BEGIN(SCRIPT_MOD);

	TBaseType::bindToScript();

	BindFunc(getState());
	BindClass(getState());
	worldserverAutoBindClass(getState());

	return true;

	FUNC_END(false);
}
