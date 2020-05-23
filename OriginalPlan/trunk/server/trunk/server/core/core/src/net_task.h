#ifndef _NET_TASK_H_
#define _NET_TASK_H_

#include "task.h"
#include "socket_util.h"
#include "module_base.h"

namespace GXMISC
{
	class CNetLoopWrap;

    // 网络底层向网络包装层发送的任务
    class CNetSocketLoopTask : public CThreadToLoopTask
    {
	protected:
        CNetSocketLoopTask();
	public:
        virtual ~CNetSocketLoopTask(){}

	public:
		CNetLoopWrap* getNetLoopWrap();

	public:
		void setSocketIndex(TUniqueIndex_t index);
		TUniqueIndex_t getSocketIndex() const;

	private:
		TUniqueIndex_t _socketIndex;   // Socket唯一索引
    };

    // 网络包装层向网络底层发送的任务
    class CNetSocketLoopWrapTask : public CLoopToThreadTask
    {
	protected:
        CNetSocketLoopWrapTask();
	public:
        virtual ~CNetSocketLoopWrapTask(){}

    public:
        CSocketEventLoop* getSocketLoop();

	public:
		void setSocketIndex(TUniqueIndex_t index);
		TUniqueIndex_t getSocketIndex() const;

	private:
		TUniqueIndex_t _socketIndex;   // Socket唯一索引
    };
    
    // 发送消息包
    class CNetSendPacketTask : public CNetSocketLoopWrapTask
    {
    public:
        CNetSendPacketTask();
        virtual ~CNetSendPacketTask(){}
	
    public:
		virtual const std::string getName() const;
        virtual void doRun();
        virtual TTaskType_t type() const;
    };

    // 接收消息包
    class CNetRecvPacketTask : public CNetSocketLoopTask
    {
    public:
        CNetRecvPacketTask();
        virtual ~CNetRecvPacketTask(){}

    public:
        virtual void doRun();
		virtual const std::string getName() const;
    };
	
	// 广播消息, 主线程发送给广播对象
	class CNetWrapBroadCastTask : public CNetSocketLoopWrapTask
	{
	public:
		CNetWrapBroadCastTask() : CNetSocketLoopWrapTask() {}
		virtual ~CNetWrapBroadCastTask(){}

	public:
		virtual void doRun();
	};

	// 广播消息, 广播对象发送给网络线程
	class CBroadcastPacketTask : public CNetSocketLoopWrapTask
	{
	public:
		CBroadcastPacketTask();
		virtual ~CBroadcastPacketTask(){}

	public:
		virtual void doRun();
	};
    
    // socket断开连接
    class CNetSocketClose : public CNetSocketLoopTask
    {
    public:
        CNetSocketClose();
        virtual ~CNetSocketClose(){}

    public:
        virtual void doRun();
    };
    
    // 删除socket
    class CNetSocketDelTask : public CNetSocketLoopWrapTask
    {
    public:
        CNetSocketDelTask();
        virtual ~CNetSocketDelTask(){}

    public:
        virtual void doRun();

    public:
        sint32 waitSecs;            // 关闭一个socket最多等待多长
		sint32 noDataDelFlag;		// 没有数据发送的时候立即关闭
    };

    // 添加socket返回
    class CNetSocketAddRet : public CNetSocketLoopTask
    {
    public:
        CNetSocketAddRet();
        virtual ~CNetSocketAddRet(){}

    public:
        virtual void doRun();
    };
}

#endif