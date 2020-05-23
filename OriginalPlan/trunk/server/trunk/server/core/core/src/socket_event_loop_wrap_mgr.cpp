#include "stdcore.h"

#include "thread.h"
#include "socket_event_loop_wrap_mgr.h"
#include "socket_util.h"
#include "time_val.h"
#include "socket_listener.h"
#include "socket_handler.h"
#include "socket_connector.h"
#include "socket_event_loop_wrap.h"
#include "service.h"

namespace GXMISC
{
	CNetModule::CNetModule(const std::string& moduleName) : CModuleBase(&_config), _config(moduleName)
	{
		_clearSelf();
	}

	CNetModule::~CNetModule()
	{
		_clearSelf();
	}

	void CNetModule::_clearSelf()
	{
		_eventBase = NULL;
	}

	bool CNetModule::doLoop( TDiffTime_t diff )
	{
		if(!TBaseType::doLoop(diff))
		{
			return false;
		}

		// 监听链接事件
		sint32 ret = event_base_loop(_eventBase, EVLOOP_ONCE | EVLOOP_NONBLOCK);
        if(0 == ret || 1 == ret)
        {
            return true;
        }

        return false;
    }

    bool CNetModule::addListener( CSocketListener* listener )
    {
        // 确保监听socket和创建此监听socket的线程一致
        gxAssert(listener->getThreadID() == gxGetThreadID());

        TSocketEvent_t& listenEvt = listener->getListenEvent();
        SMainLoopEventArg& listenEvtArg = listener->getListenEventArg();
        if(0 != event_assign(&listenEvt, _eventBase, listener->getSocket(), EV_READ|EV_PERSIST, 
            (event_callback_fn)CNetModule::OnAccept, &listenEvtArg))
        {
            gxWarning("can't event assign!");
            return false;
        }

        if(0 != event_add(&listenEvt, NULL))
        {
            gxWarning("can't event add!errno={0}", strerror(errno));
            return false;
        }

        _listenerList.push_back(listener);

        return true;
    }

    bool CNetModule::addConnector( CSocketConnector* connector )
    {
        TSocketParmHandler handlers = connector->getHandler();
        if(!handlers.isValid())
        {
			gxWarning("Handler is invalid!");
            handlers.freeAll();
            return false;
        }

        connector->setPacketHandler(handlers.packetHandler);
        if(!addSocket(connector, handlers.socketHandler))
        {
			gxWarning("Can't add socket!");
			connector->setPacketHandler(NULL);
            handlers.freeAll();
            return false;
        }

		_mainService->onConnectSocket(connector, handlers.socketHandler, handlers.packetHandler, handlers.tag);

        return true;
    }

    bool CNetModule::addSocket( CSocket* socket, CSocketHandler* handler)
    {
        CNetLoopWrap* pLoop = getLeastNetLoop();
        if(NULL == pLoop)
        {
			gxWarning("Can't get LeastNetLoop");
            return false;
        }
		
        pLoop->addSocket(socket, handler);
		handler->setRemoteAddr(socket->getRemoteHostIPStr(), socket->getRemotePort());
		handler->setAddr(socket->getHostIPStr(), socket->getPort());
		_handleHash.insert(THandlerHash::value_type(handler->getUniqueIndex(), handler));

        return true;
    }

    bool CNetModule::onAccept( CSocketListener* listener )
    {
#define DRealseSocket() \
		socket->close(); \
		socket->setPacketHandler(NULL); \
		DSafeDelete(socket); \
		handlers.freeAll(); 

        gxAssert(listener);

        CSocket* socket = listener->accept();
        if(NULL == socket)
        {
            return false;
        }

		TSocketParmHandler handlers = listener->onAccept();
		if(!handlers.isValid())
		{
			DRealseSocket();

			return false;
		}

		if(!_mainService->onAcceptSocket(socket, handlers.socketHandler, handlers.packetHandler, handlers.tag))
		{
			DRealseSocket();

			return false;
		}

		socket->setPacketHandler(handlers.packetHandler);
		if (!addSocket(socket, handlers.socketHandler))
		{
			DRealseSocket();

			return false;
		}

		return true;
    }

    CNetLoopWrap* CNetModule::getLeastNetLoop() const
    {
		return dynamic_cast< CNetLoopWrap* >(getLeastLoop());
    }

	CNetLoopWrap** CNetModule::getAllNetLoopWrap() const
	{
		return (CNetLoopWrap**)(_loopThreadWraps);
	}

    void CNetModule::OnAccept( TSocket_t fd, short evt, void* arg )
    {
        SMainLoopEventArg* eventArg = (SMainLoopEventArg*)arg;
        gxAssert(eventArg);
        gxAssert(eventArg->_loop);
        gxAssert(eventArg->_listener);
		
		for(uint32 i = 0; i < ACCEPT_ONCE_NUM; ++i)
		{
			if(!eventArg->_loop->onAccept(eventArg->_listener))
			{
				// 内部有accept操作, 失败表示未有接收的连接, 正常跳出
				//continue;
				break;
			}
		}
    }

//     GXMISC::TUniqueIndex_t CNetModule::genUniqueIndex()
//     {
//         return _uniqueIndex++;
//     }


    CNetModuleConfig* CNetModule::getConfig()
    {
        return &_config;
    }

	void CNetModule::cleanEvent()
	{
		if (NULL != _eventBase)
		{
			for (ListenerList::iterator iter = _listenerList.begin(); iter != _listenerList.end(); ++iter)
			{
				CSocketListener* listener = *iter;
				if (listener != NULL)
				{
					listener->close();
					TSocketEvent_t& listenEvent = listener->getListenEvent();
					event_del(&listenEvent);
					DSafeDelete(listener);
					// @TODO 释放PacketHandler
				}
			}
			_listenerList.clear();

			event_base_free(_eventBase);
			_eventBase = NULL;
		}
	}

	void CNetModule::cleanUp()
	{
		TBaseType::cleanUp();

		cleanEvent();
	}

	bool CNetModule::init()
	{
		if (!TBaseType::init())
		{
			return false;
		}

		static sint32 initCount = 0;	// 防止远程配置加载

		gxAssert(_config.check());
		if(false == _config.check())
		{
			return false;
		}

		if (initCount == 0)
		{
			if(!_eventBase){
				_eventBase = event_base_new();
			}
			gxAssert(_eventBase);
			if(_eventBase == NULL)
			{
				return false;
			}
		}

		initCount++;

		return true;
	}

    void CNetModule::closeSocket( TUniqueIndex_t index, sint32 waitSecs )
    {
		CSocketHandler* handler = getSocketHandler(index);
		if(NULL != handler)
		{
			gxInfo("Close socket!{0}", handler->getString());
			handler->getNetLoopWrap()->closeSocket(index, waitSecs);
		}

		delSocket(index);
    }

    CSocketHandler* CNetModule::getSocketHandler( TUniqueIndex_t index )
    {		
		THandlerHash::iterator iter = _handleHash.find(index);
		if(iter != _handleHash.end())
		{
			return iter->second;
		}

		return NULL;
    }

	void CNetModule::delSocket( TUniqueIndex_t index )
	{
		_handleHash.erase(index);
	}

	CModuleThreadLoopWrap* CNetModule::createLoopWrap()
	{
		return new CNetLoopWrap(this, _config.getPacketNumPerFrame());
	}

    CNetModuleConfig::CNetModuleConfig( const std::string moduleName ) : IModuleConfig(moduleName)
    {
		_clearSelf();
    }

    CNetModuleConfig::~CNetModuleConfig()
    {
		_clearSelf();
    }

	bool CNetModuleConfig::onLoadConfig(const CConfigMap* configs)
	{
		if (!TBaseType::onLoadConfig(configs))
		{
			return false;
		}

		// 每帧处理的消息数
		sint32 msgPerFrame = 0;
		if ((msgPerFrame = configs->readConfigValue(_moduleName.c_str(), "MsgPerFrame")) = -1)
		{
			if (_msgPerFrame == 0)
			{
				_msgPerFrame = 4;
			}
		}
		else
		{
			_msgPerFrame = msgPerFrame;
		}

		sint32 packBuffLen = 0;
		// 每个包的解析缓冲长度
		if ((packBuffLen = configs->readConfigValue(_moduleName.c_str(), "PackBuffLen")) = -1)
		{
			if (_packBuffLen == 0)
			{
				_packBuffLen = 1 * 1024 * 1024;
			}
		}
		else
		{
			_packBuffLen = packBuffLen;
		}

		sint32 packTempReadBuffLen = 0;
		// 从Socket中一次读取的缓冲长度
		if ((packTempReadBuffLen = configs->readConfigValue(_moduleName.c_str(), "PackTempReadBuffLen")) = -1)
		{
			if (_packTempReadBuffLen == 0)
			{
				_packTempReadBuffLen = 1 * 1024 * 1024;
			}
		}
		else
		{
			_packTempReadBuffLen = packTempReadBuffLen;
		}

		// @notice 注意检测是否已经被加载过了
		_loaded = true;
		return true;
	}

	void CNetModuleConfig::_clearSelf()
	{
		_msgPerFrame = 0;
		_packBuffLen = 0;
		_packTempReadBuffLen = 0;
	}

	sint32 CNetModuleConfig::getPackBuffLen()const
	{
		return _packBuffLen;
	}

	sint32 CNetModuleConfig::getPackTempReadBuffLen()const
	{
		return _packTempReadBuffLen;
	}

	sint32 CNetModuleConfig::getPacketNumPerFrame()const
	{
		return _msgPerFrame;
	}

}