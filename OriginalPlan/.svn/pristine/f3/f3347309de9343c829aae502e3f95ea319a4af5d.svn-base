#include "server_task_pool.h"
#include "server_task_pool_wrap.h"
#include "server_task.h"
#include "server_task_pool_wrap_mgr.h"

namespace GXMISC
{
//	extern bool CoreLibraryScriptAutoBindFunc(lua_State*);

	bool CServerTaskPool::init()
	{
		if (!TBaseType::init())
		{
			return false;
		}

//		_scriptEngine.init(NULL, true);
//		CoreLibraryScriptAutoBindFunc(_scriptEngine.getState());
		return true;
	}

	void CServerTaskPool::initBeforeRun()
	{
		if (!((CServerTaskConfig*)_moduleConfig)->getScriptFileName().empty())
		{
			if (!_scriptEngine.initScript(((CServerTaskConfig*)_moduleConfig)->getScriptFileName().c_str()))
			{
				gxError("Can't load script file!FileName={0}", ((CServerTaskConfig*)_moduleConfig)->getScriptFileName());
			}
		}
	}

	void CServerTaskPool::cleanUp()
	{
		TBaseType::cleanUp();

		// @TODO  Õ∑≈Ω≈±æ
	}

	CServerTaskPool::CServerTaskPool()
	{
	}

	CServerTaskPool::~CServerTaskPool()
	{

	}

 	CLuaVM* CServerTaskPool::getScriptEngine()
 	{
 		return &_scriptEngine;
 	}

	CServerScriptRetTask* CServerTaskPool::newScriptRetTask(std::string functionName)
	{
		CServerScriptRetTask* pTask =  newTask<CServerScriptRetTask>();
		pTask->scriptFuncName = functionName;
		return pTask;
	}
}