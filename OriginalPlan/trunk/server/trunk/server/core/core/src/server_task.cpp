#include "server_task.h"
#include "server_task_pool.h"
#include "server_task_pool_wrap.h"
#include "socket_connector.h"
#include "service.h"

namespace GXMISC
{
	CServerTaskPoolWrap* CServerPoolTask::getTaskPoolWrap()
	{
		return dynamic_cast<CServerTaskPoolWrap*>(getLoopThreadWrap());
	}

	void CServerPoolTask::setDebugInfo( std::string str )
	{
		debugInfo = str;
	}

	CServerTaskPool* CServerPoolWrapTask::getServerTaskPool()
	{
		return dynamic_cast<CServerTaskPool*>(getLoopThread());
	}

	void CServerPoolWrapTask::setDebugInfo( std::string str )
	{
		debugInfo = str;
	}

	CSocketReconnectTask::CSocketReconnectTask() : CServerPoolWrapTask()
	{
		diff = 0;
		port = 0;
		ip = "";
		pConnector = NULL;
	}

	void CSocketReconnectTask::doRun()
	{
		CSocketReconnectRetTask* pReturnTask = newTask<CSocketReconnectRetTask>();
		if(NULL == pReturnTask){
			gxError("Socket connect failed, can't new CSocketReconnectRetTask!IP={0},Port={1}", ip, port);
			return;
		}

		if(!debugInfo.empty())
		{
			gxDebug("{0}", debugInfo);
		}
		
		pReturnTask->pConnector = pConnector;
		pReturnTask->setDebugInfo(debugInfo);
		gxAssert(pConnector);
		if(false == pConnector->connect(ip.c_str(), port, diff))
		{
			gxError("Socket connect failed!IP={0},Port={1}", ip, port);
			pReturnTask->setSuccess(1);
		}else{
			gxInfo("Socket connect success!IP={0},Port={1}", ip, port);
			pReturnTask->setSuccess(0);
		}

		pReturnTask->pushToQueue();
	}

	CSocketReconnectRetTask::CSocketReconnectRetTask() : CServerPoolTask()
	{
		pConnector = NULL;
	}

	void CSocketReconnectRetTask::doRun()
	{
		if(!debugInfo.empty())
		{
			gxDebug("{0}", debugInfo);
		}

		if(isSuccess()){
			g_LibService->addConnector(pConnector);
		}else{
			// 重新连接
			g_LibService->addReconnector(pConnector);
		}
	}

	void CServerScriptTask::doRun()
	{
// 		if(!getServerTaskPool()->getScriptEngine()->vCall(scriptFuncName.c_str(), extData, this))
// 		{
// 			gxError("Can't do script function!ScriptFuncName={0}", scriptFuncName);
// 		}
		gxAssert(false);
	}

	CServerScriptRetTask* CServerScriptTask::newScriptRetTask( std::string functionName )
	{
		return getServerTaskPool()->newScriptRetTask(functionName);
	}

	void CServerScriptRetTask::doRun()
	{
// 		if(!scriptFuncName.empty())
// 		{
// 			if(!GetLibService()->getScriptEngine()->vCall(scriptFuncName.c_str(), extData))
// 			{
// 				gxError("Can't do script function!ScriptFuncName={0}", scriptFuncName);
// 			}
// 		}
		gxAssert(false);
	}
}