#include "socket_connector.h"
#include "socket.h"
#include "socket_event_loop.h"

namespace GXMISC
{
    CSocketConnector::CSocketConnector( sint32 tag, CSocketEventLoop* loop /*= NULL*/, sint32 inputStreamLen /*= DEFAULT_SOCKET_INPUT_BUFFER_SIZE*/, 
        sint32 outputStreamLen /*= DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE*/, sint32 maxInputStreamLen /*= DISCONNECT_SOCKET_INPUT_SIZE*/,
        sint32 maxOutputStreamLen /*= DISCONNECT_SOCKET_OUTPUT_SIZE*/ ) : CSocket(loop, inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen)
    {
		_reconnectDiff = 0;
		updateLastConnectTime();
		_socketHandlerTag = tag;
    }

    CSocketConnector::~CSocketConnector()
    {
    }

	bool CSocketConnector::connect(const char* host, TPort_t port, uint32 diff)
    {
		_serverIP = host;
		_serverPort = port;
		setConnectDiff(diff);
		updateLastConnectTime();
        if(true == CSocket::connect(host, port, diff))
        {
            setNonBlocking(true);
            
            return true;
        }

        return false;
    }

	bool CSocketConnector::reconnect(const char* host, TPort_t port, uint32 diff)
    {
		setConnectDiff(diff);
		updateLastConnectTime();
        return CSocket::reconnect(host, port, diff);
    }

	void CSocketConnector::setReconnectDiff( TDiffTime_t diff )
	{
		_reconnectDiff = diff;
	}

	GXMISC::TDiffTime_t CSocketConnector::getReconnectDiff()
	{
		return _reconnectDiff;
	}

	void CSocketConnector::updateLastConnectTime()
	{
		_lastConnectTime = (TGameTime_t)std::time(NULL);
	}

	bool CSocketConnector::canReconnect()
	{
		TGameTime_t curTime = (TGameTime_t)std::time(NULL);
		if(curTime > (_lastConnectTime+_reconnectDiff/1000)){
			return true;
		}

		return false;
	}

}
