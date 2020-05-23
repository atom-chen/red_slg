#ifndef _SERVER_TASK_POOL_H_
#define _SERVER_TASK_POOL_H_

#include "interface.h"
#include "carray.h"
#include "time_util.h"
#include "thread.h"
#include "module_base.h"
#include "script/script_lua_inc.h"

namespace GXMISC
{
	class CServerScriptRetTask;

	class CServerTaskPool : public CModuleThreadLoop
	{
		typedef CModuleThreadLoop TBaseType;

	public:
		CServerTaskPool();
		~CServerTaskPool();

	public:
		// 初始化
		virtual bool init();
		// 清理数据
		virtual void cleanUp();

	public:
		// 在多线程运行前初始化
		virtual void initBeforeRun();

	public:
		CServerScriptRetTask* newScriptRetTask(std::string functionName);
		CLuaVM* getScriptEngine();

	private:
		CLuaVM _scriptEngine;							///< 脚本引擎
	};
}

#endif	// _SERVER_TASK_POOL_H_