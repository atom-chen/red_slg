#include "net_task.h"
#include "socket_event_loop.h"
#include "socket_event_loop_wrap.h"
#include "socket_broad_cast.h"

namespace GXMISC
{
	CNetSocketLoopTask::CNetSocketLoopTask() : CThreadToLoopTask()
	{
		_socketIndex = INVALID_UNIQUE_INDEX;
		setName("CNetSocketLoopTask");
	}

	void CNetSocketLoopTask::setSocketIndex(TUniqueIndex_t index)
	{
		_socketIndex = index;
	}

	TUniqueIndex_t CNetSocketLoopTask::getSocketIndex() const
	{
		return _socketIndex;
	}

    CNetLoopWrap* CNetSocketLoopTask::getNetLoopWrap()
    {
		return dynamic_cast<CNetLoopWrap*>(getLoopThreadWrap());
    }

    CSocketEventLoop* CNetSocketLoopWrapTask::getSocketLoop()
    {
		return dynamic_cast<CSocketEventLoop*>(getLoopThread());
    }

	CNetSocketLoopWrapTask::CNetSocketLoopWrapTask() : CLoopToThreadTask()
    {
		_socketIndex = INVALID_UNIQUE_INDEX;
        setName("CNetSocketLoopTask");
    }

	void CNetSocketLoopWrapTask::setSocketIndex(TUniqueIndex_t index)
	{
		_socketIndex = index;
	}

	TUniqueIndex_t CNetSocketLoopWrapTask::getSocketIndex() const
	{
		return _socketIndex;
	}

    CNetSendPacketTask::CNetSendPacketTask() : CNetSocketLoopWrapTask()
    {
        setName("CNetSendPacketTask");
    }
    void CNetSendPacketTask::doRun()
    {
        getSocketLoop()->handleWriteMsg(getSocketIndex(), getArg<char>(0), getArgLen(0));
    }

	const std::string CNetSendPacketTask::getName() const
	{
		std::string name = CNetSocketLoopWrapTask::getName();
		name = name + gxToString("PacketLen=%u", getTotalArgLen());
		return name;
	}

    GXMISC::TTaskType_t CNetSendPacketTask::type() const
    {
        return NET_TASK_SEND_MSG;
    }

    CNetRecvPacketTask::CNetRecvPacketTask() : CNetSocketLoopTask()
    {
        setName("CNetRecvPacketTask");
    }

    void CNetRecvPacketTask::doRun()
    {
		for(uint32 i = 0; i < getArgNum(); ++i)
		{
			getNetLoopWrap()->handlePacket(getSocketIndex(), getArg<char>(i), getArgLen(i));
		}
    }

	const std::string CNetRecvPacketTask::getName() const
	{
		std::string name = CNetSocketLoopTask::getName();
		name = name + gxToString("PacketLen=%u", getTotalArgLen());
		return name;
	}

    CNetSocketClose::CNetSocketClose() : CNetSocketLoopTask()
    {
        setName("CNetSocketClose");
    }
    void CNetSocketClose::doRun()
    {
        getNetLoopWrap()->handleCloseSocket(getSocketIndex());
    }

    CNetSocketDelTask::CNetSocketDelTask() : CNetSocketLoopWrapTask()
    {
        setName("CNetSocketDelTask");
    }
    void CNetSocketDelTask::doRun()
    {
		getSocketLoop()->handleDelSocket(getSocketIndex(), waitSecs, noDataDelFlag);
    }

    CNetSocketAddRet::CNetSocketAddRet() : CNetSocketLoopTask()
    {
        setName("CNetSocketAddRet");
    }
    void CNetSocketAddRet::doRun()
    {
		getNetLoopWrap()->handleAddSocketRet(getSocketIndex());
    }

	CBroadcastPacketTask::CBroadcastPacketTask() :CNetSocketLoopWrapTask()
	{
	}

	void CBroadcastPacketTask::doRun()
	{
		char* msg = getArg<char>(0);
		for (uint32 i = 1; i < getArgNum(); ++i)
		{
			TSockIndexAry* sockAry = getArg<TSockIndexAry>(i);
			for(uint8 j = 0; j < sockAry->size(); ++j)
			{
				getSocketLoop()->handleWriteMsg(sockAry->at(j), msg, getArgLen(0));
			}
		}
	}

	void CNetWrapBroadCastTask::doRun()
	{
		char* msg = getArg<char>(0);
		TSockIndexAry* sockAry = getArg<TSockIndexAry>(1);
		CSocketBroadCast* pBroadCast = dynamic_cast<CSocketBroadCast*>(getLoopThread());
		pBroadCast->broadMsg(msg, getArgLen(0), *sockAry);
	}
}