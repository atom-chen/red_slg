#include "server_task_pool_wrap.h"
#include "server_task_pool_wrap_mgr.h"

namespace GXMISC{

	CServerTaskConfig::CServerTaskConfig( const std::string moduleName ) : IModuleConfig(moduleName)
	{
	}

	CServerTaskConfig::~CServerTaskConfig()
	{
	}

	sint32 CServerTaskConfig::getPoolNum()
	{
		return _loopThreadNum;
	}

	const std::string CServerTaskConfig::getScriptFileName()
	{
		return _scriptFileName;
	}

	CServerTaskPoolWrap::CServerTaskPoolWrap(CServerTaskPoolMgr* mgr) : TBaseType(mgr)
	{
	}

	CServerTaskPoolWrap::~CServerTaskPoolWrap()
	{
	}

	CServerScriptTask* CServerTaskPoolWrap::newScriptTask()
	{
		return newTask<CServerScriptTask>();
	}

	CModuleThreadLoop* CServerTaskPoolWrap::createThreadLoop()
	{
		_serverTaskPool.setFreeFlag(false);
		return &_serverTaskPool;
	}
}