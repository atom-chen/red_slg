#ifndef _SCRIPT_DEFINE_FUNCTION_H_
#define _SCRIPT_DEFINE_FUNCTION_H_

#include "debug.h"

class ManCore
{
public:
	static void infoLog(const std::string msg)
	{
		const char* FuncModuleName = "ScriptMod;";
		GXMISC::gxLog(false, DMainLog, GXMISC::CLogger::LOG_INFO, __LINE__, __FILE__, __FUNCTION__, FuncModuleName, msg.c_str());
	}

	static void debugLog(const std::string msg)
	{
#ifdef LIB_DEBUG
		const char* FuncModuleName = "ScriptMod;";
		GXMISC::gxLog(false, DMainLog, GXMISC::CLogger::LOG_DEBUG, __LINE__, __FILE__, __FUNCTION__, FuncModuleName, msg.c_str());
#endif
	}

	static void warnLog(const std::string msg)
	{
		const char* FuncModuleName = "ScriptMod;";
		GXMISC::gxLog(false, DMainLog, GXMISC::CLogger::LOG_WARNING, __LINE__, __FILE__, __FUNCTION__, FuncModuleName, msg.c_str());
	}

	static void errorLog(const std::string msg)
	{
		const char* FuncModuleName = "ScriptMod;";
		GXMISC::gxLog(false, DMainLog, GXMISC::CLogger::LOG_ERROR, __LINE__, __FILE__, __FUNCTION__, FuncModuleName, msg.c_str());
	}
};

#endif