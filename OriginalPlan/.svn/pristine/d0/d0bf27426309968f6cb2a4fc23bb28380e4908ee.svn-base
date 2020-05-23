#ifndef _WORLD_SCRIPT_ENGINE_H_
#define _WORLD_SCRIPT_ENGINE_H_

#include "script_engine_common.h"

class CWorldScriptEngine : public CScriptEngineCommon, 
	public GXMISC::CManualSingleton<CWorldScriptEngine>
{
public:
	typedef CScriptEngineCommon TBaseType;

public:
	virtual bool bindToScript();
};

#define DWorldScriptEngine CWorldScriptEngine::GetInstance()

#endif	// _WORLD_SCRIPT_ENGINE_H_