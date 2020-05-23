#include "socket_server_connector.h"

namespace GXMISC
{
    CSocketServerConnector::CSocketServerConnector( sint32 tag, CSocketEventLoop* loop /*= NULL*/, sint32 inputStreamLen /*= DEFAULT_SOCKET_INPUT_BUFFER_SIZE*/,
        sint32 outputStreamLen /*= DEFAULT_SOCKET_OUTPUT_BUFFER_SIZE*/, sint32 maxInputStreamLen /*= DISCONNECT_SOCKET_INPUT_SIZE*/,
        sint32 maxOutputStreamLen /*= DISCONNECT_SOCKET_OUTPUT_SIZE*/ ) : CSocketConnector(tag, loop, inputStreamLen, outputStreamLen, maxInputStreamLen, maxOutputStreamLen)
    {
    }

    CSocketServerConnector::~CSocketServerConnector()
    {

    }
}