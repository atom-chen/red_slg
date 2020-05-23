#include "stdcore.h"

#include "socket_event_loop_wrap.h"
#include "socket_util.h"
#include "time_val.h"
#include "socket_listener.h"
#include "socket_handler.h"
#include "socket_connector.h"
#include "socket_event_loop_wrap_mgr.h"
#include "thread.h"
#include "service.h"

namespace GXMISC
{
    CNetLoopWrap::CNetLoopWrap(CNetModule* mgr, sint32 msgNumPerBreath) 
		: TBaseType(mgr) 
	{
		_clearSelf();

		_netLoopMgr = mgr;
		_msgNumPerBreath = msgNumPerBreath;
    }

	CNetLoopWrap::~CNetLoopWrap()
	{

	}

	void CNetLoopWrap::_clearSelf()
	{
		_msgNumPerBreath = 0;
        _netLoopMgr = NULL;
	}

    void CNetLoopWrap::onBreath( GXMISC::TDiffTime_t diff )
    {
        // 定时处理
        updateSocketHandlers(diff);
    }

	sint32 CNetLoopWrap::getUserNum() const
	{
		return _handlerMap.size();
	}
	
	const CNetModuleConfig* CNetLoopWrap::getNetConfig() const
	{
		return dynamic_cast<CNetModuleConfig*>(_moduleConfig);
	}

	void CNetLoopWrap::handleCloseSocket(TUniqueIndex_t index)
	{
		CSocketHandler* handler = getSocketHandler(index);
		if(NULL == handler)
		{
			gxError("Close socket from net thread loop, but cant find socket handler!SocketIndex={0}", index);
			return;
		}

		// 关闭
		if(handler->isValid())
		{
			// 对象有效才回调关闭事件
			handler->close();
			handler->onReconnect();
		}

		delSocket(index);
		_netLoopMgr->delSocket(index);
	}

    void CNetLoopWrap::handleAddSocketRet( TUniqueIndex_t index )
    {
        CSocketHandler* handler = getSocketHandler(index);
        if(NULL == handler)
        {
            gxError("Add socket from thread loop, can't find socket handler! SocketIndex = {0}", index);
            return;
        }

        if(!handler->start())
        {
            closeSocket(index, DEFAULT_CLOSE_SOCKET_WAIT_SECS);
            return;
        }

        handler->setStarted();
    }

    void CNetLoopWrap::addSocket( CSocket* socket, CSocketHandler* handler )
    {
        // @todo 检测添加的时候会不会影响性能
		TUniqueIndex_t index = genUniqueIndex();
        handler->init(this, index);
        socket->setUniqueIndex(index);
        socket->setSocketEventLoop(&_socketEventLoop);

        _handlerMap.insert(THandlerHash::value_type(index, handler));
        _newSocketQueue.push(socket);
    }

    void CNetLoopWrap::handlePacket( TUniqueIndex_t index, char* msg, sint32 len )
    {
        CSocketHandler* handler = getSocketHandler(index);
        if(NULL == handler)
        {
			gxError("Handle socket message, cant find socket handler!SocketIndex={0}", index);
            return;
        }

        handler->handle(msg, len);
    }

    void CNetLoopWrap::writeMsg( const char* msg, sint32 len, TUniqueIndex_t index, const char* name )
    {
        CNetSendPacketTask* task = newTask<CNetSendPacketTask>();
        gxAssert(task);
        if(name != NULL)
        {
            task->setName(name);
        }
        char* arg = task->allocArg(len);
        gxAssert(arg);
        memcpy(arg, msg, len);
        pushTask(task, index);
        DTaskLog("Push task! {0}", task->getName().c_str());
    }

    void CNetLoopWrap::pushTask( CNetSocketLoopWrapTask* task, TUniqueIndex_t index )
    {
        gxAssert(index != INVALID_UNIQUE_INDEX);
        gxAssert(getSocketHandler(index) != NULL);
        task->setSocketIndex(index);
        _queueWrap.push(task);
    }

    void CNetLoopWrap::closeSocket( TUniqueIndex_t index, sint32 waitSecs )
    {
        if(_handlerMap.find(index) != _handlerMap.end())
		{
			gxInfo("Close socket!  Index = {0}", index);
			CNetSocketDelTask* task = newTask<CNetSocketDelTask>();
			gxAssert(task);
			if(task)
			{
				task->waitSecs = waitSecs;
				task->noDataDelFlag = 0;
				pushTask(task, index);
			}

			delSocket(index);
        }
        else
        {
            gxError("Can't find socket! Index = {0}", index);
        }
    }

    void CNetLoopWrap::delSocket( TUniqueIndex_t index )
    {
        CSocketHandler* handler = getSocketHandler(index);
        if(NULL == handler)
        {
            gxDbgWarning("Can't find CSocketHandler! Index = {0}", index);
            return;
        }

        _netLoopMgr->delSocket(index);
        _handlerMap.erase(index);
        if(handler->isNeedFree())
        {
            handler->onDelete();
            DSafeDelete(handler);
        }
    }

    CSocketEventLoop* CNetLoopWrap::getSocketEventLoop()
    {
        return &_socketEventLoop;
    }

    CSocketHandler* CNetLoopWrap::getSocketHandler( TUniqueIndex_t index )
    {
        THandlerHash::iterator iter = _handlerMap.find(index);
        if(iter == _handlerMap.end())
        {
            return NULL;
        }

        return iter->second;
    }

    void CNetLoopWrap::updateSocketHandlers(TDiffTime_t diff)
    {
        std::vector<CSocketHandler*> delList;

        for(THandlerHash::iterator iter = _handlerMap.begin(); iter != _handlerMap.end(); ++iter)
        {
            CSocketHandler* handler = iter->second;
            gxAssert(handler);
            if(handler == NULL)
            {
                continue;
            }

            if(handler->isValid())
            {
                if(handler->isStarted())
                {
                    handler->breath(diff);
                }
            }
            else
            {
                // 处理句柄已经失效, 删除
                delList.push_back(handler);
            }
        }

        for(uint32 i = 0; i < delList.size(); ++i)
        {
            closeSocket(delList[i]->getUniqueIndex(), delList[i]->getWaitSecs());
        }
    }

    CSocketHandler* CNetLoopWrap::getSocketHandlerAll( TUniqueIndex_t index )
    {
        return _netLoopMgr->getSocketHandler(index);
    }

	void CNetLoopWrap::broadMsg( const char* msg, sint32 len, const TSockIndexAry& socks )
	{
		_mainService->getNetBroadcast()->broadMsg(msg, len, socks);
	}

	CNetModule* CNetLoopWrap::getNetLoopWrapMgr()
	{
		return _netLoopMgr;
	}

	void CNetLoopWrap::initBroadcastQ(CSyncActiveQueue* loopInputQ, CSyncActiveQueue* loopOutputQ)
	{
		_socketEventLoop.getBroadcastQWrap()->setCommunicationQ(loopInputQ, loopOutputQ);
	}

	CModuleThreadLoop* CNetLoopWrap::createThreadLoop()
	{
		_socketEventLoop.setFreeFlag(false);
		return &_socketEventLoop;
	}

	void CNetLoopWrap::onCreateThreadLoop(CModuleThreadLoop* threadLoop)
	{
		_socketEventLoop.setNewSocketQueue(&_newSocketQueue);
		_socketEventLoop.setMsgPerFrame(getNetConfig()->getPacketNumPerFrame());

		TBaseType::onCreateThreadLoop(threadLoop);
	}
}