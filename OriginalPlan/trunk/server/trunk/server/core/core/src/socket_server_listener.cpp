#include "socket_server_listener.h"

namespace GXMISC
{
    CSocket* CSocketServerListener::accept( sint32 inputStreamLen /*= DEFAULT_SOCKET_INPUT_BUFFER_SIZE*/,
		sint32 outputStreamLen /*= DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE*/, sint32 maxInputStreamLen /*= DISCONNECT_SOCKET_INPUT_SIZE*/,
		sint32 maxOutputStreamLen /*= DISCONNECT_SOCKET_OUTPUT_SIZE*/ )
    {
        return CSocket::accept(inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen);
    }

    CSocketServerListener::CSocketServerListener( CNetModule* loop, const char* ip, uint32 port, sint32 tag, uint32 backlog /*= ACCEPT_ONCE_NUM*/ ) :
        CSocketListener(loop, ip, port, backlog)
    {
		_socketHandlerTag = tag;
    }

    CSocketServerListener::~CSocketServerListener()
    {
    }
}