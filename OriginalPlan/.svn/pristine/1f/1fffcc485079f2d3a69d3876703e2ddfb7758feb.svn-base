#ifndef _SERVER_TASK_H_
#define _SERVER_TASK_H_

#include "task.h"
#include "base_util.h"
#include "server_task_pool.h"

namespace GXMISC
{
	class CServerPoolTask;
	class CServerTaskPoolWrap;
	class CServerPoolWrapTask;

	/// 从ServerTaskPool发送到ServerTaskPoolWrap的任务
	class CServerPoolTask : public CThreadToLoopTask
	{
	protected:
		CServerPoolTask() :CThreadToLoopTask(){}
	public:
		virtual ~CServerPoolTask(){}

	public:
		// 获取封装对象
		CServerTaskPoolWrap* getTaskPoolWrap();

	public:
		void setDebugInfo(std::string str);

	protected:
		std::string debugInfo;		///< 调试信息					
	};

	/// 从ServerTaskPoolWrap发送到ServerTaskPool的任务
	class CServerPoolWrapTask : public CLoopToThreadTask
	{
	protected:
		CServerPoolWrapTask() : CLoopToThreadTask(){}
	public:
		~CServerPoolWrapTask(){}

	public:
		CServerTaskPool* getServerTaskPool();

	public:
		void setDebugInfo(std::string str);

	protected:
		std::string debugInfo;							///< 调试信息
	};

	class CSocketConnector;
	// Socket重连事件
	class CSocketReconnectTask : public CServerPoolWrapTask
	{
	public:
		CSocketReconnectTask();
		~CSocketReconnectTask(){}

	public:
		std::string ip;					///< IP
		TPort_t port;					///< 端口
		TDiffTime_t diff;				///< 间隔时间
		CSocketConnector* pConnector;	///< 连接对象 @TODO去掉这个,采用Index查询
	public:
		// 执行任务
		virtual void doRun();
	};

	// 重新连接返回事件
	class CSocketReconnectRetTask : public CServerPoolTask
	{
	public:
		CSocketReconnectRetTask();
		virtual ~CSocketReconnectRetTask(){}

	public:
		// 执行任务
		virtual void doRun();

	public:
		CSocketConnector* pConnector;	///< 连接对象 @TODO去掉这个,采用Index查询
	};

	// 脚本任务返回事件
	class CServerScriptRetTask : public CServerPoolTask
	{
	public:
		CServerScriptRetTask() : CServerPoolTask(){
			extData = "";
			scriptFuncName = "";
		}
		virtual ~CServerScriptRetTask(){}

	public:
		std::string extData;			///< 额外数据
		std::string scriptFuncName;		///< 脚本函数名

	public:
		// 执行任务
		virtual void doRun();
	};

	// 脚本任务事件
	class CServerScriptTask : public CServerPoolWrapTask
	{
	public:
		CServerScriptTask() : CServerPoolWrapTask()
		{
			extData = "";
			scriptFuncName = "";
		}
		~CServerScriptTask(){}

	public:
		///< 分配一个新的脚本任务
		CServerScriptRetTask* newScriptRetTask(std::string functionName);

	public:
		std::string extData;			///< 额外数据
		std::string scriptFuncName;		///< 脚本函数名

	public:
		// 执行任务
		virtual void doRun();
	};
}

#endif	// _SERVER_TASK_H_