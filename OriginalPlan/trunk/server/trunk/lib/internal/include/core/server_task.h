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

	/// ��ServerTaskPool���͵�ServerTaskPoolWrap������
	class CServerPoolTask : public CThreadToLoopTask
	{
	protected:
		CServerPoolTask() :CThreadToLoopTask(){}
	public:
		virtual ~CServerPoolTask(){}

	public:
		// ��ȡ��װ����
		CServerTaskPoolWrap* getTaskPoolWrap();

	public:
		void setDebugInfo(std::string str);

	protected:
		std::string debugInfo;		///< ������Ϣ					
	};

	/// ��ServerTaskPoolWrap���͵�ServerTaskPool������
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
		std::string debugInfo;							///< ������Ϣ
	};

	class CSocketConnector;
	// Socket�����¼�
	class CSocketReconnectTask : public CServerPoolWrapTask
	{
	public:
		CSocketReconnectTask();
		~CSocketReconnectTask(){}

	public:
		std::string ip;					///< IP
		TPort_t port;					///< �˿�
		TDiffTime_t diff;				///< ���ʱ��
		CSocketConnector* pConnector;	///< ���Ӷ��� @TODOȥ�����,����Index��ѯ
	public:
		// ִ������
		virtual void doRun();
	};

	// �������ӷ����¼�
	class CSocketReconnectRetTask : public CServerPoolTask
	{
	public:
		CSocketReconnectRetTask();
		virtual ~CSocketReconnectRetTask(){}

	public:
		// ִ������
		virtual void doRun();

	public:
		CSocketConnector* pConnector;	///< ���Ӷ��� @TODOȥ�����,����Index��ѯ
	};

	// �ű����񷵻��¼�
	class CServerScriptRetTask : public CServerPoolTask
	{
	public:
		CServerScriptRetTask() : CServerPoolTask(){
			extData = "";
			scriptFuncName = "";
		}
		virtual ~CServerScriptRetTask(){}

	public:
		std::string extData;			///< ��������
		std::string scriptFuncName;		///< �ű�������

	public:
		// ִ������
		virtual void doRun();
	};

	// �ű������¼�
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
		///< ����һ���µĽű�����
		CServerScriptRetTask* newScriptRetTask(std::string functionName);

	public:
		std::string extData;			///< ��������
		std::string scriptFuncName;		///< �ű�������

	public:
		// ִ������
		virtual void doRun();
	};
}

#endif	// _SERVER_TASK_H_