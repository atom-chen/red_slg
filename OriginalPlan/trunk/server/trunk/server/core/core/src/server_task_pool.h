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
		// ��ʼ��
		virtual bool init();
		// ��������
		virtual void cleanUp();

	public:
		// �ڶ��߳�����ǰ��ʼ��
		virtual void initBeforeRun();

	public:
		CServerScriptRetTask* newScriptRetTask(std::string functionName);
		CLuaVM* getScriptEngine();

	private:
		CLuaVM _scriptEngine;							///< �ű�����
	};
}

#endif	// _SERVER_TASK_POOL_H_