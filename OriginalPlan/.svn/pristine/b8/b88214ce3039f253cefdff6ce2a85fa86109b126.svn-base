#include "stdcore.h"
#include "string_common.h"
#include "socket.h"
#include "socket_api.h"
#include "common.h"
#include "debug.h"
#include "socket_packet_handler.h"
#include "time_gx.h"

namespace GXMISC
{
	void CSocket::cleanUp(CSocketEventLoop* loop)
	{
		reset();
		_index = INVALID_UNIQUE_INDEX;
		_threadID = gxGetThreadID();
		_writeEventArg._loop = loop;
		_writeEventArg._socket = this;
		_readEventArg._loop = loop;
		_readEventArg._socket = this;
		_packetHandler = NULL;
		_unpacketNum = 0;
		_packetHandler = NULL;
		_lastUnpacketTime = CTimeManager::SysNowTime();
		_activeFlag = true;
		_waitCloseSecs = 0;
		_waitCloseStartTime = MAX_UINT32_NUM;
		_socket = INVALID_SOCKET;
	}

    CSocket::CSocket( CSocketEventLoop* loop /*= NULL*/, sint32 inputStreamLen /*= DEFAULT_SOCKET_INPUT_BUFFER_SIZE*/, 
        sint32 outputStreamLen /*= DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE*/, sint32 maxInputStreamLen /*= DISCONNECT_SOCKET_INPUT_SIZE*/,
        sint32 maxOutputStreamLen /*= DISCONNECT_SOCKET_OUTPUT_SIZE*/ )
    {
		cleanUp(loop);
		_inputStream.initsize(this, inputStreamLen, maxInputStreamLen);
		_outputStream.initsize(this, outputStreamLen, maxOutputStreamLen);
		genStrName();
    }

    CSocket::CSocket( const char* host, sint32 port, CSocketEventLoop* loop /*= NULL*/, sint32 inputStreamLen /*= DEFAULT_SOCKET_INPUT_BUFFER_SIZE*/,
        sint32 outputStreamLen /*= DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE*/, sint32 maxInputStreamLen /*= DISCONNECT_SOCKET_INPUT_SIZE*/,
        sint32 maxOutputStreamLen /*= DISCONNECT_SOCKET_OUTPUT_SIZE*/ )
    {
        gxAssert(NULL != host);
		cleanUp(loop);
		setAddr(host, port);
		_inputStream.initsize(this, inputStreamLen, maxOutputStreamLen);
		_outputStream.initsize(this, outputStreamLen, maxOutputStreamLen);
        genStrName();
    }

    CSocket::~CSocket () 
    {
        if(_packetHandler != NULL && _packetHandler->isNeedFree())
        {
            DSafeDelete(_packetHandler);
        }
    }

	bool CSocket::create( )
	{
		_socket = SOCKET_API::gx_socket( AF_INET , SOCK_STREAM , 0 );

        if( isValid() )
        {
            return true ;
        }
        else 
        {
            return false ;
        }
    }

    // close previous connection and connect to another server socket
    bool CSocket::reconnect ( const char* host , sint32 port, sint32 diff )
    {
        // delete old socket impl object
        close();

        setAddr(host, port);

        create();

        // try to connect
        return connect(host, port, diff);
    }

    void CSocket::close () 
    { 
		gxInfo("Close socket!Index={0}", getUniqueIndex());
        if( isValid() && !isSockError() ) 
        {
            SOCKET_API::gx_closesocket( _socket );
        }

        reset();
    }

    void CSocket::reset()
    {
        _socket = INVALID_SOCKET ;
        memset( &_socketAddr, 0, sizeof(SOCKADDR_IN) ) ;
        memset( m_Host, 0, IP_SIZE ) ;
        m_Port = 0 ;
    }

    bool CSocket::connect (const char* host, sint32 port, sint32 diff) 
    {
        SOCKADDR_IN addr;
        memset(&addr, 0, sizeof(addr));
        addr.sin_family = AF_INET;
        addr.sin_addr.s_addr = inet_addr( host );
		addr.sin_port = htons((u_short)port);
		
		bool ret = false;
		if(diff != 0)
		{
			ret = SOCKET_API::gx_connect2(_socket, (const struct sockaddr *)&addr, sizeof(addr), diff);
		}
		else
		{
			ret = SOCKET_API::gx_connect(_socket, (const struct sockaddr *)&addr, sizeof(addr));
		}

		if(ret)
		{
			onConnectSocket(host, port);
		}

		return ret;
    }

	CSocket* CSocket::accept( sint32 inputStreamLen /*= DEFAULT_SOCKET_INPUT_BUFFER_SIZE*/, sint32 outputStreamLen /*= DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE*/,
		sint32 maxInputStreamLen /*= DISCONNECT_SOCKET_INPUT_SIZE*/, sint32 maxOutputStreamLen /*= DISCONNECT_SOCKET_OUTPUT_SIZE*/ )
	{
		CSocket* socket = new CSocket(NULL, inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen);
		uint32 addrlen = sizeof(SOCKADDR_IN);
		SOCKADDR_IN addr;
		//        socket->close();

		TSocket_t id = SOCKET_API::gx_accept( _socket, (struct sockaddr *)&addr, &addrlen ) ;
		if(id == INVALID_SOCKET)
		{
			DSafeDelete(socket);
			return NULL;
		}

		socket->setSocket(id);
		socket->setNonBlocking(true);
		socket->setLinger(0);
		socket->setRemoteAddr(addr);
		socket->onAcceptSocket();

		return socket;
	}

    sint32 CSocket::send (const void* buf, sint32 len, sint32 flags) 
    { 
        sint32 ret = SOCKET_API::gx_send( _socket , buf , len , flags );
        return ret;
    }

    sint32 CSocket::receive (void* buf, sint32 len, sint32 flags) 
    { 
        sint32 ret = SOCKET_API::gx_recv( _socket , buf , len , flags );
        return ret;
    }

    sint32 CSocket::available ()const
    { 
        return SOCKET_API::gx_availablesocket( _socket );
    }

    sint32 CSocket::getLinger ()const 
    { 
        struct linger ling;
        uint32 len = sizeof(ling);

        SOCKET_API::gx_getsockopt( _socket , SOL_SOCKET , SO_LINGER , &ling , &len );

        return ling.l_linger;
    }

    bool CSocket::setLinger (sint32 lingertime) 
    {
        struct linger ling;

        ling.l_onoff = lingertime > 0 ? 1 : 0;
        ling.l_linger = (decltype(ling.l_linger))lingertime;

        return SOCKET_API::gx_setsockopt( _socket , SOL_SOCKET , SO_LINGER , &ling , sizeof(ling) );
    }

    sint32 CSocket::getSockError()const 
    { 
        return isSockError(); 
    }

    bool CSocket::isNonBlocking ()const 
    { 
        return SOCKET_API::gx_getsocketnonblocking( _socket );
    }

    bool CSocket::setNonBlocking (bool on ) 
    { 
        return SOCKET_API::gx_setsocketnonblocking( _socket , on );
    }

    sint32 CSocket::getReceiveBufferSize ()const 
    { 
        sint32 ReceiveBufferSize;
        uint32 size = sizeof(ReceiveBufferSize);

        SOCKET_API::gx_getsockopt( _socket , SOL_SOCKET , SO_RCVBUF , &ReceiveBufferSize, &size );

        return ReceiveBufferSize;
    }

    bool CSocket::setReceiveBufferSize (sint32 size)
    { 
        return (bool)(SOCKET_API::gx_setsockopt( _socket , SOL_SOCKET , SO_RCVBUF , &size, sizeof(sint32) ) ) ;
    }

    sint32 CSocket::getSendBufferSize ()const 
    { 
        sint32 SendBufferSize;
        uint32 size = sizeof(SendBufferSize);

        SOCKET_API::gx_getsockopt( _socket , SOL_SOCKET , SO_SNDBUF , &SendBufferSize, &size );

        return SendBufferSize;
    }

    bool CSocket::setSendBufferSize (sint32 size)
    { 
        return (bool)(SOCKET_API::gx_setsockopt( _socket , SOL_SOCKET , SO_SNDBUF , &size, sizeof(sint32) ) );
    }

    sint32 CSocket::getPort ()const 
    { 
        return m_Port; 
    }

    TIP_t CSocket::getHostIP ()const 
    { 
        return (TIP_t)(_socketAddr.sin_addr.s_addr);
    }

    bool CSocket::isValid ()const 
    {
        return _socket  !=  INVALID_SOCKET;
    }

    TSocket_t CSocket::getSocket () const
    { 
        return _socket; 
    }

    void CSocket::setSocket( TSocket_t id )
    {
        _socket = id;
    }

    bool CSocket::isSockError()const
    {
        sint32 error;
        uint32 len = sizeof(error);

        sint32 Result = SOCKET_API::gx_getsockopt2( _socket , SOL_SOCKET , SO_ERROR , &error, &len );
        if( Result == 0 ) 
		{
            return false;
		}
        else
		{
            return true;
		}
    }

    bool CSocket::bind( )
    {
        bool result = SOCKET_API::gx_bind( _socket , (const struct sockaddr *)&_socketAddr , sizeof(_socketAddr) ) ;
        return result;
    }

    bool CSocket::bind( sint32 port )
    {
        _socketAddr.sin_addr.s_addr = htonl(INADDR_ANY);
        _socketAddr.sin_port = htons((u_short)port);

        bool result = SOCKET_API::gx_bind( _socket , (const struct sockaddr *)&_socketAddr , sizeof(_socketAddr) );
        setAddr(_socketAddr);
        if( result )
		{
            return true ;
		}
        else
		{
            return false ;
		}
    }

    bool CSocket::listen( sint32 backlog )
    {
        return SOCKET_API::gx_listen( _socket , backlog );
    }

    void CSocket::setAddr( const char* host, sint32 port )
    {
        _socketAddr.sin_family = AF_INET;
        _socketAddr.sin_port = htons((u_short)port);
		if(!strcmp("any", host))
		{
			_socketAddr.sin_addr.s_addr = inet_addr(host);
		}
		else
		{
			_socketAddr.sin_addr.s_addr = htonl(INADDR_ANY);
		}
        
        gxStrcpy( m_Host, IP_SIZE, host, IP_SIZE ) ;
        m_Port = port;
    }

    void CSocket::setAddr( SOCKADDR_IN addr )
    {
        m_Port = ntohs( addr.sin_port ) ;
        gxStrcpy( m_Host, IP_SIZE, inet_ntoa(addr.sin_addr), IP_SIZE) ;
        
        memcpy(&_socketAddr, &addr, sizeof(addr));
        _socketAddr.sin_family = AF_INET;
    }

	void CSocket::setRemoteAddr( const char* host, sint32 port )
	{
		memset(&_remoteSocketAddr, 0, sizeof(_remoteSocketAddr));
		_remoteSocketAddr.sin_family = AF_INET;
		_remoteSocketAddr.sin_port = htons((u_short)port);
		_remoteSocketAddr.sin_addr.s_addr = inet_addr(host);

		gxStrcpy( m_remoteHost, IP_SIZE, host, IP_SIZE ) ;
		m_remotePort = port;
	}

	void CSocket::setRemoteAddr( SOCKADDR_IN addr )
	{
		memset(&_remoteSocketAddr, 0, sizeof(_remoteSocketAddr));

		gxStrcpy( m_remoteHost, IP_SIZE, inet_ntoa(addr.sin_addr), IP_SIZE) ;
		m_remotePort = ntohs( addr.sin_port ) ;

		memcpy(&_remoteSocketAddr, &addr, sizeof(addr));
		_remoteSocketAddr.sin_family = AF_INET;
	}

    bool CSocket::isReuseAddr ()const
    {
        sint32 reuse;
        uint32 len = sizeof(reuse);

        SOCKET_API::gx_getsockopt( _socket , SOL_SOCKET , SO_REUSEADDR , &reuse , &len );

        return reuse == 1;
    }

    bool CSocket::setReuseAddr ( bool on )
    {
        sint32 opt = on == true ? 1 : 0;

        return SOCKET_API::gx_setsockopt( _socket , SOL_SOCKET , SO_REUSEADDR , &opt , sizeof(opt) );
    }

    bool CSocket::onRead()
    {
        genStrName();
        return _inputStream.fill() > SOCKET_ERROR;
    }

    bool CSocket::onWrite()
    {
        genStrName();
        return  _outputStream.flush() > SOCKET_ERROR ;
    }

    TSocketEvent_t& CSocket::getReadEvent()
    {
        return _readEvent;
    }

    TSocketEvent_t& CSocket::getWriteEvent()
    {
        return _writeEvent;
    }

    SSocketLoopEventArg& CSocket::getReadEventArg()
    {
        return _readEventArg;
    }

    SSocketLoopEventArg& CSocket::getWriteEventArg()
    {
        return _writeEventArg;
    }

    TUniqueIndex_t CSocket::getUniqueIndex()
    {
        return _index;
    }

    void CSocket::setUniqueIndex( TUniqueIndex_t index )
    {
        _index = index;
        genStrName();
    }

    TThreadID_t CSocket::getThreadID()
    {
        return _threadID;
    }

    bool CSocket::isNeedWrite()
    {
        return _outputStream.size() > 0;
    }

    sint32 CSocket::write(const char* msg, sint32 len )
    {
        sint32 ret = _outputStream.write(msg, len);
        return ret;
    }

    sint32 CSocket::read( char* msg, sint32 len )
    {
        sint32 ret = _inputStream.read(msg, len);
        return ret;
    }

    void CSocket::setSocketEventLoop( CSocketEventLoop* loop )
    {
        _writeEventArg._loop = loop;
        _writeEventArg._socket = this;
        _readEventArg._loop = loop;
        _readEventArg._socket = this;
    }

    CSocketEventLoop* CSocket::getSocketEventLoop()
    {
        gxAssert(_readEventArg._loop == _writeEventArg._loop);

        return _readEventArg._loop;
    }

    CSocketInputStream* CSocket::getInputStream()
    {
        return &_inputStream;
    }

    CSocketOutputStream* CSocket::getOutputStream()
    {
        return &_outputStream;
    }

    sint32 CSocket::getInputLen()
    {
        return _inputStream.length();
    }

    sint32 CSocket::getOutputLen()
    {
        return _outputStream.length();
    }

    ISocketPacketHandler* CSocket::getPacketHandler()
    {
        return _packetHandler;
    }

    void CSocket::setPacketHandler( ISocketPacketHandler* handler )
    {
        _packetHandler = handler;
		if(NULL != handler)
		{
			_packetHandler->setSocket(this);
		}
    }

    bool CSocket::canUnpacket()
    {
        if(_packetHandler != NULL)
        {
            return _packetHandler->canUnpacket() > 0;
        }

        return false;
    }

	bool CSocket::unpacket( CNetSocketLoopTask* task, char* packBuff, sint32 packBuffLen, char* packBuffTempRead, sint32 packBuffTempReadLen )
	{
		TTime_t curTime = CTimeManager::SysNowTime();
		if(curTime != _lastUnpacketTime)
		{
			_unpacketNum = 0;
		}
		
		_lastUnpacketTime = curTime;
		_unpacketNum++;

		if(_packetHandler != NULL)
		{
			return _packetHandler->unpacket(task, packBuff, packBuffLen, packBuffTempRead, packBuffTempReadLen);
		}
			
		return false;
	}

	sint32 CSocket::getUnpacketNum()
	{
		if(CTimeManager::SysNowTime() != _lastUnpacketTime)
		{
			_unpacketNum = 0;
		}
		
		if(_packetHandler != NULL)
		{
			if(_packetHandler->getUnpacketNum() > _unpacketNum)
			{
				return _packetHandler->getUnpacketNum() -_unpacketNum;
			}
		}

		return 0;
	}

	void CSocket::setActive( bool flag )
	{
		_activeFlag = flag;
	}

	bool CSocket::isActive()
	{
		return _activeFlag;
	}

	uint32 CSocket::getWaitCloseSecs()
	{
		return _waitCloseSecs;
	}

	void CSocket::setWaitCloseSecs( uint32 secs )
	{
		_waitCloseStartTime = (uint32)CTimeManager::SysNowTime();
		_waitCloseSecs = secs;
	}

	bool CSocket::needDel()
	{
		if(isActive())
		{
			return false;
		}

		if((CTimeManager::SysNowTime()-_waitCloseStartTime)>_waitCloseSecs)
		{
			return true;
		}

		return false;
	}

	std::string CSocket::getHostIPStr() const
	{
		return std::string(m_Host);
	}

	void CSocket::getLocalAddr()
	{
		SOCKADDR_IN localAddr;
		memset(&localAddr, 0, sizeof(localAddr));
		localAddr.sin_family = AF_INET;
		socklen_t len = sizeof(localAddr);
		getsockname(_socket, (struct sockaddr *)&localAddr, &len);
		setAddr(localAddr);
	}

	void CSocket::onAcceptSocket()
	{
		getLocalAddr();
	}

	void CSocket::onConnectSocket(const char* host, sint32 port)
	{
		getLocalAddr();
		setRemoteAddr(host, port);
	}

	sint32 CSocket::getRemotePort() const
	{
		return m_remotePort;
	}

	GXMISC::TIP_t CSocket::getRemoteHostIP() const
	{
		return (TIP_t)(_remoteSocketAddr.sin_addr.s_addr);
	}

	std::string CSocket::getRemoteHostIPStr() const
	{
		return std::string(m_remoteHost);
	}
}