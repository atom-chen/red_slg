#ifndef _SERVER_TASK_POOL_MGR_H_
#define _SERVER_TASK_POOL_MGR_H_

#include "server_task_pool_wrap.h"

namespace GXMISC
{
	class CServerTaskConfig : public IModuleConfig
	{
		friend class CNetModule;

	public:
		CServerTaskConfig(const std::string moduleName);
		~CServerTaskConfig();

	public:
		virtual bool onLoadConfig(const CConfigMap* configs) override;

	public:
		sint32 getPoolNum();
		const std::string getScriptFileName();

	private:
		std::string _scriptFileName;				///< 脚本文件名
	};

	class CServerTaskPoolMgr : public CModuleBase
	{
		typedef CModuleBase TBaseType;

	public:
		CServerTaskPoolMgr(const std::string& moduleName = "ServerTaskPool");
		~CServerTaskPoolMgr();

	public:
		// 分配新的任务
		template<typename T>
		T* newTask()
		{
			return getLeastPoolWrap()->newTask<T>();
		}
		// 分配脚本任务
		CServerScriptTask* newScriptTask(std::string scriptName);

	protected:
		// 创建循环包装对象
		virtual CModuleThreadLoopWrap* createLoopWrap();

	public:
		CServerTaskPoolWrap* getLeastPoolWrap();

	protected:
		CServerTaskConfig _config;
	};
}

#endif	// _SERVER_TASK_POOL_MGR_H_