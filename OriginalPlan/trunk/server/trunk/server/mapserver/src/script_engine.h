#ifndef _SCRIPT_ENGINE_H_
#define _SCRIPT_ENGINE_H_

#include "core/script/script_lua_inc.h"
#include "core/singleton.h"

#include "base_packet_def.h"
#include "bag_struct.h"
#include "game_util.h"
#include "script_engine_common.h"

class CScriptEngine : public CScriptEngineCommon, public GXMISC::CManualSingleton<CScriptEngine>
{
public:
	CScriptEngine(bool openStdLib = true);
	~CScriptEngine();

public:
	typedef CScriptEngineCommon TBaseType;

public:
	virtual bool bindToScript();
};

#define DScriptEngine CScriptEngine::GetInstance()

#endif	// _SCRIPT_ENGINE_H_