#include "socket_event_loop.h"
#include "debug.h"
#include "time_val.h"
#include "socket_util.h"
#include "socket.h"
#include "socket_packet_handler.h"
#include "socket_event_loop_wrap.h"
#include "socket_event_loop_wrap_mgr.h"

namespace GXMISC
{
	CSocketEventLoop::CSocketEventLoop() : CModuleThreadLoop()
    {
		_clearSelf();
    }

	void CSocketEventLoop::_clearSelf()
	{
		_newSocketQueue = NULL;
		_msgPerFrame = 1;
		_frameSleepDiff = 0; // @TODO 去掉FrameSleepTime
		_lastProfileTime = 0;
		_stopHandleMsg = false;
		_config = NULL;
		_packHandleBuff = NULL;
		_packHandleTempReadBuff = NULL;

		_totalSendMsgCount = 0;
		_totalRecvMsgCount = 0;
		_averageSendMsgCount = 0;
		_averageRecvMsgCount = 0;
		_maxSendMsgLen = 0;
		_maxRecvMsgLen = 0;
		_totalSendMsgLen = 0;
		_totalRecvMsgLen = 0;
		_averageSendFlow = 0;
		_averageRecvFlow = 0;
	}

    CSocketEventLoop::~CSocketEventLoop()
    {
        gxAssert(_base == NULL);
        gxAssert(_socketMgr.size() == 0);
        gxAssert(_newSocketQueue == NULL);

		_clearSelf();
    }

	void CSocketEventLoop::addSocket( CSocket* socket )
	{
		gxAssert(!socket->isSockError());

		TSocketEvent_t& readEvent = socket->getReadEvent();
		TSocketEvent_t& writeEvent = socket->getWriteEvent();
		SSocketLoopEventArg& readEventArg = socket->getReadEventArg();
		SSocketLoopEventArg& writeEventArg = socket->getWriteEventArg();

		if(0 != event_assign(&readEvent, _base, socket->getSocket(), EV_READ|EV_PERSIST, (event_callback_fn)CSocketEventLoop::OnReadEvent, &readEventArg))
		{
			gxAssert(false);
		}
		if(0 != event_assign(&writeEvent, _base, socket->getSocket(), EV_WRITE, (event_callback_fn)CSocketEventLoop::OnWriteEvent, &writeEventArg))
		{
			gxAssert(false);
		}

		if(0 != event_add(&readEvent, NULL))
		{
			gxAssert(false);
		}
		if(0 != event_add(&writeEvent, NULL))
		{
			gxAssert(false);
		}

		TUniqueIndex_t index = socket->getUniqueIndex();
		assertSocket(index, false);
		_socketMgr[index] = socket;

		sendAddSocketRet(index);
	}

	bool CSocketEventLoop::handleEventLoop(TDiffTime_t sleepMS)
	{
		sint32 ret = 0;
        ret = event_base_loop(_base, EVLOOP_ONCE | EVLOOP_NONBLOCK);
        if(-1 == ret)
        {
            return false;
        }
        
        if(0 == ret)
        {
            return true;
        }

        if(1 == ret)
        {
            return true;
        }
        
        return false;
    }

    void CSocketEventLoop::OnWriteEvent( TSocket_t fd, short evt, void* arg )
    {
        SSocketLoopEventArg* eventArg = (SSocketLoopEventArg*)arg;
        gxAssert(eventArg);
        gxAssert(eventArg->_loop);
        gxAssert(eventArg->_socket);

		if (!eventArg->_socket->isActive())
		{
			return;
		}

        if(evt & EV_WRITE)
        {
            eventArg->_loop->onWrite(eventArg->_socket);
        }
        else
        {
            gxAssert(false);
			eventArg->_socket->setActive(false);
            eventArg->_loop->handleCloseSocket(eventArg->_socket, true);
        }
    }

    void CSocketEventLoop::OnReadEvent( TSocket_t fd, short evt, void* arg )
    {
        SSocketLoopEventArg* eventArg = (SSocketLoopEventArg*)arg;
        gxAssert(eventArg);
        gxAssert(eventArg->_loop);
        gxAssert(eventArg->_socket);
		
		if(!eventArg->_socket->isActive())
		{
			return;
		}

        if(evt & EV_READ)
        {
            eventArg->_loop->onRead(eventArg->_socket);
        }
        else
        {
            gxAssert(false);
            eventArg->_loop->handleCloseSocket(eventArg->_socket, false);
        }
    }

    void CSocketEventLoop::onWrite( CSocket* socket )
    {
        gxAssert(socket);

        TUniqueIndex_t index = socket->getUniqueIndex();
        gxAssert(socket == getSocket(index));

        if(!socket->onWrite())
        {
			socket->setActive(false);
            handleCloseSocket(socket, true);
            return;
        }

        if(socket->isNeedWrite())
        {
            TSocketEvent_t& writeEvent = socket->getWriteEvent();
            event_add(&writeEvent, NULL);
        }
    }

    void CSocketEventLoop::onRead( CSocket* socket )
    {
        TUniqueIndex_t index = socket->getUniqueIndex();
        gxAssert(socket == getSocket(index));

        if(!socket->onRead())
        {
            handleCloseSocket(socket, false);
            return;
        }
    }

	bool CSocketEventLoop::onBreath()
    {
        // 保证先建的链接全部先处理, 能快速建立链接
        handleNewSocket(0);

		handleEventLoop(0);

		handleWaitDelSocket(0);

		handleSocketUnPacket(0);

		handleBroadcastMsg(0);

		handleProfile(0);

		return true;
    }

    void CSocketEventLoop::delSocket( CSocket* socket )
    {
        gxAssert(NULL != socket);
        TUniqueIndex_t index = socket->getUniqueIndex();
        gxAssert(getSocket(index) == socket);

        // 将数据全部写出
        socket->onWrite();

        TSocketEvent_t& readEvent = socket->getReadEvent();
        event_del(&readEvent);
        TSocketEvent_t& writeEvent = socket->getWriteEvent();
        event_del(&writeEvent);
        
//        gxStatistic(socket->toString());

        // 关闭链接
        socket->close();
        _socketMgr.erase(index);
        
        DSafeDelete(socket);
    }

	// 设置新连接消息队列
	void CSocketEventLoop::setNewSocketQueue(TSyncSocketQue* newSocketQ)
	{
		_newSocketQueue = newSocketQ;
	}

	void CSocketEventLoop::setMsgPerFrame(uint32 msgPerFrame)
	{
		_msgPerFrame = std::max(msgPerFrame, _msgPerFrame);
	}

	void CSocketEventLoop::setBroadCastQ(CSyncActiveQueue* inputQ, CSyncActiveQueue* outputQ)
	{
		_broadcastTaskQueue.setCommunicationQ(inputQ, outputQ);
	}

	bool CSocketEventLoop::init()
    {
		if (!TBaseType::init())
		{
			return false;
		}

		_base = event_base_new();
        
		_config = dynamic_cast<CNetModuleConfig*>(_moduleConfig);//((CNetLoopWrap*)_loopWrap)->getNetLoopWrapMgr()->getConfig();
		if(_config->getPackBuffLen() > 0)
		{
			_packHandleBuff = new char[_config->getPackBuffLen()];
		}
		if(_config->getPackTempReadBuffLen() > 0)
		{
			_packHandleTempReadBuff = new char[_config->getPackTempReadBuffLen()];
		}

		return true;
    }
    
    // @todo 重点处理, 避免内存泄漏
    void CSocketEventLoop::cleanUp()
    {
		TBaseType::cleanUp();

        // 将所有的事件移除
        clearEvent();
        
        if(true)
        {
            // 强制刷新所有的缓冲区
            clearFlushStream();
        }

        // 删除所有的socket
        clearSocket();
	
		clearLoop();
    }

    void CSocketEventLoop::clearEvent()
    {
        for(TSocketHash::iterator iter = _socketMgr.begin(); iter != _socketMgr.end(); ++iter)
        {
            CSocket* socket = iter->second;
            event_del(&socket->getReadEvent());
            event_del(&socket->getWriteEvent());
        }
    }

    void CSocketEventLoop::clearFlushStream()
    {
        // 不在接收数据包, 转入循环发送, 直到所有的数据都发送完为止
        for(TSocketHash::iterator iter = _socketMgr.begin(); iter != _socketMgr.end(); ++iter)
        {
            CSocket* socket = iter->second;
            socket->onWrite();
        }
    }

    void CSocketEventLoop::clearSocket()
    {
        for(TSocketHash::iterator iter = _socketMgr.begin(); iter != _socketMgr.end();)
        {
            CSocket* socket = iter->second;
            socket->close();
            iter = _socketMgr.erase(iter);
            DSafeDelete(socket);
        }
    }
    
    void CSocketEventLoop::clearLoop()
    {
        // @todo 统计还有多少数据包未处理
        // @todo 统计还有多少连接未处理
		
        event_base_free(_base);
        _base = NULL;
		_newSocketQueue = NULL;
		DSafeDeleteArray(_packHandleBuff);
		DSafeDeleteArray(_packHandleTempReadBuff);
    }

    void CSocketEventLoop::handleNewSocket(TDiffTime_t diff)
    {
        // 处理连接请求
        SocketList lst;
        _newSocketQueue->pop(lst);
        for(SocketList::iterator iter = lst.begin(); iter != lst.end(); ++iter)
        {
            CSocket* socket = *iter;
            gxAssert(socket);
            addSocket(socket);
        }
    }

	void CSocketEventLoop::handleBroadcastMsg( TDiffTime_t diff )
	{	
		_broadcastTaskQueue.update(diff);
		_broadcastTaskQueue.handleTask(diff);
	}

    void CSocketEventLoop::handleProfile(TDiffTime_t diff)
    {
        if((_curTime-_lastProfileTime) > PROFILE_SOCKET_SECONDS)
        {
            _lastProfileTime = _curTime;  
			doSocketProfile();
        }

		if(_curTime-_lastLoopProfileTime > PROFILE_LOOP_SOCKET_SECONDS)
		{
			doLooProfile();
		}
    }

    void CSocketEventLoop::handleDelSocket(TUniqueIndex_t index, sint32 waitCloseSecs, sint32 noDataNeedDel)
    {
        CSocket* socket = getSocket(index);
        if(NULL != socket)
        {
			gxDebug("Server close socket!{0}", socket->toString());
			if(waitCloseSecs <= 0 || (noDataNeedDel == 1 && socket->getOutputLen() <= 0))
			{
				socket->setWaitCloseSecs(std::min(waitCloseSecs, 3));
			}
			else
			{
				if(waitCloseSecs > MAX_CLOSE_SOCK_WAIT_SECS)
				{
					waitCloseSecs = MAX_CLOSE_SOCK_WAIT_SECS;
				}
				socket->setWaitCloseSecs(waitCloseSecs);
			}
			// 关闭读事件
			event_del(&(socket->getReadEvent()));
			socket->setActive(false);
			_delSockList.push_back(socket->getUniqueIndex());
        }
    }

    void CSocketEventLoop::handleCloseSocket( CSocket* socket, bool writeFlag )
    {
		if(writeFlag)
		{
			gxInfo("Write close socket!index = {0}", socket->getUniqueIndex());
		}
		else
		{
			gxInfo("Read close socket!index = {0}", socket->getUniqueIndex());
		}

		if(socket->isActive())
		{
			socket->getOutputStream()->flush();
		}

        sendCloseSocket(socket->getUniqueIndex());

        delSocket(socket);
    }

    void CSocketEventLoop::handleWriteMsg( TUniqueIndex_t index, char* msg, uint32 len )
    {
        CSocket* socket = getSocket(index);
        if(!socket)
        {
            return;
        }
		
#if 0 // @TODO 采用这种方式更好?
		CPackHandleAry packAry;
		if(!socket->getPacketHandler()->parsePack(packAry, msg, len))
		{
			gxError("Can't parse msg!");
			socket->setActive(false);
			return;
		}

		for(sint32 i = 0; i < packAry.getPackNum(); ++i)
		{
			socket->getPacketHandler()->onSendPack(packAry.getPack(i), packAry.getPackLen(i), true);
		}
#endif

		char* pOutMsg = msg;
		uint32 pOutLen = len;
		sint32 pTempOutLen = _config->getPackBuffLen();
		if(socket->getPacketHandler()->needHandle(ISocketPacketHandler::PACK_SEND))
		{
			if(ISocketPacketHandler::PACK_HANDLE_OK != socket->getPacketHandler()->onBeforeFlushToSocket(pOutMsg, pOutLen, _packHandleBuff, pTempOutLen))
			{
				gxError("Can't handle pack to socket!{0}", socket->toString());
				socket->setActive(false);
				return;
			}
		}
		else
		{
			socket->getPacketHandler()->sendPack(msg, len);
		}

        if(socket->isNeedWrite())
        {
            TSocketEvent_t& writeEvent = socket->getWriteEvent();
            event_add(&writeEvent, NULL);
        }
    }

	void CSocketEventLoop::handleUnPacket(CSocket* socket)
	{
		gxAssert(socket);

		uint32 msgNum = socket->getUnpacketNum();
		if(msgNum <= 0)
		{
			return;
		}

		if(!socket->canUnpacket())
		{
			return;
		}

		if(msgNum > 2000)
		{
			msgNum = 2000;
		}

		CNetRecvPacketTask* task = newTask<CNetRecvPacketTask>();
		gxAssert(task);
		if(NULL == task)
		{
			socket->setActive(false);
			gxError("Can't new msg task!{0}", socket->toString());
			return;
		}

		uint32 count = 0;
		for(uint32 i = 0; i < msgNum; ++i)
		{
			if(socket->canUnpacket())
			{
				if(!socket->unpacket(task, _packHandleBuff, _config->getPackBuffLen(), _packHandleTempReadBuff, _config->getPackTempReadBuffLen()))
				{
					gxError("Unpacket failed!{0}", socket->toString());
					freeTask(task);
					socket->setActive(false);
					return;
				}

				for(uint32 j = i; j < task->getArgNum(); ++j)
				{
					onRecvPacket(task->getArg<char>(j), task->getArgLen(j));
				}

				gxAssert(task->getArgNum() >= (i+1));

				i += (task->getArgNum()-i-1);
			}
			else
			{
				break;
			}

			count++;
		}

		gxAssert(count > 0);
		pushTask(task, socket->getUniqueIndex());
		_queueWrap.update(0); // @TODO 等待下一次更新, 不提前更新
		_totalRecvMsgCount += count;
	}

	void CSocketEventLoop::updateLoopState(TDiffTime_t diff)
	{
		if (_runSeconds > 0)
		{
			_averageSendMsgCount = _totalSendMsgCount / _runSeconds;
			_averageRecvMsgCount = _totalRecvMsgCount / _runSeconds;
			_averageRecvFlow = _totalRecvMsgLen / _runSeconds;
			_averageSendFlow = _totalSendMsgLen / _runSeconds;
		}

		if (_curTime - _lastLoopProfileTime > PROFILE_LOOP_SOCKET_SECONDS)
		{
			doLooProfile();
		}
	}

    void CSocketEventLoop::sendAddSocketRet( TUniqueIndex_t index )
    {
		CNetSocketAddRet* addRet = newTask<CNetSocketAddRet>();
        gxAssert(addRet);
        pushTask(addRet, index);
    }

    void CSocketEventLoop::pushTask( CNetSocketLoopTask* task, TUniqueIndex_t index )
    {
        task->setSocketIndex(index);
        if(!isStopMsgHandle())
        {
            _queueWrap.push(task);
        }
        else
        {
			freeTask(task);
        }
    }

    void CSocketEventLoop::sendCloseSocket( TUniqueIndex_t index )
    {
		CNetSocketClose* sockClose = newTask<CNetSocketClose>();
        pushTask(sockClose, index);
    }

    void CSocketEventLoop::assertSocket( TUniqueIndex_t index, bool flag )
    {
#ifdef LIB_DEBUG
        gxAssert((_socketMgr.find(index) != _socketMgr.end()) == flag);
#endif
    }

    CSocket* CSocketEventLoop::getSocket( TUniqueIndex_t index )
    {
        TSocketHash::iterator iter = _socketMgr.find(index);
        if(iter == _socketMgr.end())
        {
            return NULL;
        }

        return iter->second;
    }

    void CSocketEventLoop::doSocketProfile()
    {
        _remainInputLen = 0;
        _remainOutputLen = 0;
        _outputCapacity = 0;
        _inputCapacity = 0;
        for(TSocketHash::iterator iter = _socketMgr.begin(); iter != _socketMgr.end(); ++iter)
        {
            CSocket* socket = iter->second;
            gxAssert(NULL != socket);
            if(socket->getInputLen() > WARNING_SOCKET_INPUT_SIZE || socket->getOutputLen() > WARNING_SOCKET_OUTPUT_SIZE)
            {
                gxWarning("Socket stream is big! {0}, IutputLen={1}, OutputLen={2}", socket->toString(), socket->getInputLen(), socket->getOutputLen());
            }
            _remainInputLen += socket->getInputLen();
            _remainOutputLen += socket->getOutputLen();
            _outputCapacity += socket->getOutputStream()->capacity();
            _inputCapacity += socket->getInputStream()->capacity();
        }

        genName();

		DSocketProfileLog("{0}", _strSocketProfile.c_str());
    }

    void CSocketEventLoop::doLooProfile()
    {
		DSocketLoopProfileLog("{0}", _strLoopProfile.c_str());
    }

	void CSocketEventLoop::onHandleTask( CTask* task )
	{
		if(task->getTotalArgLen() > _maxSendMsgLen)
		{
			_maxSendMsgLen = task->getTotalArgLen();
		}

		_totalSendMsgLen += task->getTotalArgLen();

		_totalSendMsgCount++;
	}

	void CSocketEventLoop::onStop()
	{
		stopMsgHandle();
		_broadcastTaskQueue.flushQueue();

		TBaseType::onStop();
	}

	void CSocketEventLoop::initBeforeRun()
	{
		setName(gxToString("SocketEventLoop: TID = %s", GXMISC::gxToString(getThreadID()).c_str()));
		_broadcastTaskQueue.setThreadID();
	}

	void CSocketEventLoop::onRecvPacket( const char* msg, uint32 len )
	{
		if(len > _maxRecvMsgLen)
		{
			_maxRecvMsgLen = len;
		}
		_totalRecvMsgLen += len;
	}

    void CSocketEventLoop::genName()
    {
        _strSocketProfile = getName() + gxToString(";RunTime=%u,TotalSendMsgCount=%u,TotalRecvMsgCount=%u,AverageSendMsgCount=%u,"
            "AverageRecvMsgCount=%u,MaxSendMsgLen=%u,MaxRecvMsgLen=%u,TotalSendMsgLen=%u,TotalRecvMsgLen=%u,AverageSendFlow=%u,"
            "AverageRecvFlow=%u,RemainOutputLen=%u,RemainInputLen=%u,OutputCapacityLen=%u,InputCapacityLen=%u",
            _runSeconds, _totalSendMsgCount, _totalRecvMsgCount, _averageSendMsgCount, _averageRecvMsgCount, _maxSendMsgLen, _maxRecvMsgLen, _totalSendMsgLen,
            _totalRecvMsgLen, _averageSendFlow, _averageRecvFlow, _remainOutputLen, _remainInputLen, _outputCapacity, _inputCapacity);

        _strLoopProfile = getName() + gxToString(";TotalLoopCount=%"I64_FMT"u,MaxLoopCount=%u,CurrentLoopCount=%u",_totalLoopCount, _maxLoopCount, _curLoopCount);
    }

    void CSocketEventLoop::stopMsgHandle()
    {
        _stopHandleMsg = true;
    }

    bool CSocketEventLoop::isStopMsgHandle()
    {
        return _stopHandleMsg;
    }

	void CSocketEventLoop::handleSocketUnPacket(TDiffTime_t diff)
	{
		for(TSocketHash::iterator iter = _socketMgr.begin(); iter != _socketMgr.end(); ++iter)
		{
			if(!iter->second->isActive())
			{
				continue;;
			}

			if(iter->second->getInputLen() > 0)
			{
				handleUnPacket(iter->second);
			}
		}
	}

	void CSocketEventLoop::handleWaitDelSocket( TDiffTime_t diff )
	{
		for(TDelSockList::iterator iter = _delSockList.begin(); iter != _delSockList.end(); )
		{
			CSocket* pSocket = getSocket(*iter);
			if(NULL != pSocket)
			{
				if(!pSocket->needDel())
				{
					++iter;
					continue;
				}

				gxDebug("Del socket!{0}", pSocket->toString());
				delSocket(pSocket);
			}

			iter = _delSockList.erase(iter);
		}
	}

	CSyncActiveQueueWrap* CSocketEventLoop::getBroadcastQWrap()
	{
		return &_broadcastTaskQueue;
	}
}