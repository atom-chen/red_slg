#include "socket_handler.h"
#include "socket_util.h"
#include "socket_event_loop_wrap.h"

namespace GXMISC
{
	void CSocketHandler::send(const char* msg, sint32 len, const char* name)
    {
		gxAssert(_dataBuff.maxSize() > 0);
		if(!isInvalid())
		{
			if(_dataBuff.getFreeSize() <= sint32(len+_dataBuff.size()))
			{
				flush();
			}

			_dataBuff.serialBuffer(msg, len);
		}
    }

    void CSocketHandler::init( CNetLoopWrap* loopWrap, TUniqueIndex_t index )
    {
        _netLoop = loopWrap;
        IHandler::setParam(loopWrap->getTaskQueueWrap()->getOutputQ(), index);
    }

    CSocketHandler::CSocketHandler() : IHandler()
    {
        cleanUp();
		_lastKickTime = MAX_TIME;
		_dataBuff.init(SOCKET_HANDLER_BUFF_LEN);
    }

    CSocketHandler::~CSocketHandler()
    {
        cleanUp();
    }

    void CSocketHandler::kick(sint32 secs)
    {
		flush();

		gxInfo("kick socket, index = {0}", _index);
		_lastKickTime = DTimeManager.nowSysTime();
		_kickSeconds = secs;
		setInvalid();
    }

    void CSocketHandler::onDelete()
    {
		gxInfo("delete socket handler, index = {0}", _index);
    }

    bool CSocketHandler::isValid()
    {
        return !isInvalid() && NULL != _netLoop;
    }

    CSocketHandler* CSocketHandler::getOtherHandler( TUniqueIndex_t socketIndex )
    {
        return _netLoop->getSocketHandlerAll(socketIndex);
    }

	void CSocketHandler::flush()
	{
		if(_dataBuff.size() > 0)
		{
			onFlushData(_dataBuff.data(), _dataBuff.size());
			_dataBuff.reset();
		}
	}

	void CSocketHandler::breath( GXMISC::TDiffTime_t diff)
	{
		if(isStarted())
		{
			flush();
		}
	}

	CNetLoopWrap* CSocketHandler::getNetLoopWrap()
	{
		return _netLoop;
	}

	sint32 CSocketHandler::getWaitSecs()
	{
		return _kickSeconds;
	}

	const std::string CSocketHandler::getString()
	{
		return gxToString("SocketIndex=%"I64_FMT"u,Name=%u", getUniqueIndex(), getName());
	}

	bool CSocketHandler::onFlushData( const char* msg, sint32 len )
	{
		getNetLoopWrap()->writeMsg(msg, len, getUniqueIndex());
		return true;
	}

	sint32 CSocketHandler::getLocalPort()
	{
		return _port;
	}

	std::string CSocketHandler::getLocalIp()
	{
		return _IPStr;
	}

	void CSocketHandler::setAddr( const std::string& ip, sint32 port )
	{
		_IPStr = ip;
		_port = port;
	}

	void CSocketHandler::setRemoteAddr( const std::string& ip, sint32 port )
	{
		_remoteIPStr = ip;
		_remotePort = port;
	}

	sint32 CSocketHandler::getRemotePort()
	{
		return _remotePort;
	}

	std::string CSocketHandler::getRemoteIp()
	{
		return _remoteIPStr;
	}

	GXMISC::TUniqueIndex_t CSocketHandler::getSocketIndex()
	{
		return getUniqueIndex();
	}

	bool CSocketHandler::isScriptHandler()
	{
		return false;
	}

	void CSocketHandler::cleanUp()
	{
		_netLoop = NULL;
		_lastKickTime = 0;
		_kickSeconds = 0;
		_IPStr = "";
		 _port = 0;
		_remoteIPStr = "";
		_remotePort = 0;
	}

	CMemOutputStream* CSocketHandler::getBufferStream()
	{
		return &_dataBuff;
	}

	_SSocketParmHandler::_SSocketParmHandler(CSocketHandler* handler1, ISocketPacketHandler* handler2, sint32 tag)
	{
		socketHandler = handler1;
		packetHandler = handler2;
		this->tag = tag;
	}

	_SSocketParmHandler::_SSocketParmHandler()
	{
		socketHandler = NULL;
		packetHandler = NULL;
	}
	_SSocketParmHandler::~_SSocketParmHandler(){}

	void _SSocketParmHandler::freeAll()
	{
		DSafeDelete(socketHandler);
		DSafeDelete(packetHandler);
	}

	bool _SSocketParmHandler::isValid()
	{
		return socketHandler != NULL && packetHandler != NULL;
	}

	CScriptSocketHandler::CScriptSocketHandler() : CSocketHandler()
	{
	}

	CScriptSocketHandler::~CScriptSocketHandler()
	{
	}

	bool CScriptSocketHandler::start()
	{
		if (!isExistMember("start"))
		{
			return true;
		}

		return bCall("start", getSocketIndex());
	}

	GXMISC::EHandleRet CScriptSocketHandler::handle( char* msg, uint32 len )
	{
		CMemInputStream inStream;
		inStream.init(len, msg);

		if (!bCall("handle", &inStream))
		{
			return HANDLE_RET_FAILED;
		}

		return HANDLE_RET_OK;
	}

	void CScriptSocketHandler::close()
	{
		vCall("close");
	}

	bool CScriptSocketHandler::isScriptHandler()
	{
		return true;
	}

	bool CScriptSocketHandler::initScriptObject(CLuaVM* scriptEngine)
	{
		return initScript(scriptEngine, this);
	}

}