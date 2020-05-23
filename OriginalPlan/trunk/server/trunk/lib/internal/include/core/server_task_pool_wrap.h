#ifndef _SERVER_TASK_POOL_WRAP_H_
#define _SERVER_TASK_POOL_WRAP_H_

#include "server_task.h"
#include "server_task_pool.h"
#include "module_manager.h"

namespace GXMISC
{
	class CServerScriptTask;
	class CServerTaskPoolMgr;
	class CServerTaskPoolWrap : public CSimpleThreadLoopWrap
	{
		typedef CSimpleThreadLoopWrap TBaseType;

	public:
		CServerTaskPoolWrap(CServerTaskPoolMgr* mgr);
		~CServerTaskPoolWrap();

	public:
		CServerScriptTask* newScriptTask();

	protected:
		// ����һ���̶߳���
		virtual CModuleThreadLoop* createThreadLoop();

	protected:
		CServerTaskPool _serverTaskPool;					///< ����ش������
	};
}

#endif	// _SERVER_TASK_POOL_WRAP_H_