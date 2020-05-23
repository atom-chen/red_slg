#ifndef _SCRIPT_ENGINE_COMMON_H_
#define _SCRIPT_ENGINE_COMMON_H_

#include "core/script/script_lua_inc.h"

#include "base_packet_def.h"

//#include "script_library_convert.inl"

typedef std::map<std::string, sint32> TScriptIntMap;
typedef std::map<std::string, std::string> TScriptStrMap;

class CScriptEngineCommon : public GXMISC::CLuaVM
{
public:
	CScriptEngineCommon(bool openStdLib = true);
	~CScriptEngineCommon();

public:
	typedef GXMISC::CLuaVM TBaseType;

public:
	virtual bool bindToScript();
};



#endif	// _SCRIPT_ENGINE_COMMON_H_