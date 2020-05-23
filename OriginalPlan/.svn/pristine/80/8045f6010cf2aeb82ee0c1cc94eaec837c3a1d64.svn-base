#include "script_engine.h"

extern bool BindClass(CScriptEngineCommon::TScriptState* pState);
extern bool BindFunc(CScriptEngineCommon::TScriptState* pState);
extern bool mapserverAutoBindClass(CScriptEngineCommon::TScriptState* pState);

bool CScriptEngine::bindToScript()
{
	TBaseType::bindToScript();

	BindFunc(getState());
	BindClass(getState());
	mapserverAutoBindClass(getState());

	return true;
}

CScriptEngine::CScriptEngine(bool openStdLib /*= false*/) : CScriptEngineCommon(openStdLib)
{

}

CScriptEngine::~CScriptEngine()
{

}
