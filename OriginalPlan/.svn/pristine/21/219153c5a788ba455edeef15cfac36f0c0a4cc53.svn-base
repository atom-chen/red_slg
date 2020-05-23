#include "server_task_pool_wrap_mgr.h"

namespace GXMISC{

	bool CServerTaskConfig::onLoadConfig(const CConfigMap* configs)
	{
		static sint32 loadCount = 0;

		if (false == IModuleConfig::onLoadConfig(configs))
		{
			return false;
		}

		if (loadCount == 0){
			_scriptFileName = configs->readConfigText(_moduleName.c_str(), "ScriptFileName");
		}

		loadCount++;

		// @notice 注意检测是否已经被加载过了
		_loaded = true;
		return true;
	}

	CServerTaskPoolWrap* CServerTaskPoolMgr::getLeastPoolWrap()
	{
		sint32 minNum = 100000;
		sint32 index = 0;

		for(sint32 i = 0 ; i < _config.getPoolNum(); ++i)
		{
			if(_loopThreadWraps[i]->getOutputQSize() < minNum)
			{
				minNum = _loopThreadWraps[i]->getOutputQSize();
				index = i;
			}
		}

		return dynamic_cast<CServerTaskPoolWrap*>(_loopThreadWraps[index]);
	}

	CServerTaskPoolMgr::CServerTaskPoolMgr(const std::string& moduleName) : CModuleBase(&_config), _config(moduleName)
	{
	}

	CServerTaskPoolMgr::~CServerTaskPoolMgr()
	{
	}

	CServerScriptTask* CServerTaskPoolMgr::newScriptTask(std::string scriptName)
	{
		CServerScriptTask* pTask = newTask<CServerScriptTask>();
		pTask->scriptFuncName = scriptName;
		return pTask;
	}

	CModuleThreadLoopWrap* CServerTaskPoolMgr::createLoopWrap()
	{
		return new CServerTaskPoolWrap(this);
	}

}