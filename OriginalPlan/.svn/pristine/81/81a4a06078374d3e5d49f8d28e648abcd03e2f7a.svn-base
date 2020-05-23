#ifndef _BUFFER_SOCKET_HANDLER_H_
#define _BUFFER_SOCKET_HANDLER_H_

#include "core/socket_handler.h"
#include "game_util.h"
#include "game_handler.h"

template<typename T>
class CBufferSocketHandler : public GXMISC::CSocketHandler
{
protected:
	CBufferSocketHandler(){}
	virtual ~CBufferSocketHandler(){}

public:
	virtual GXMISC::EHandleRet handle(char* msg, uint32 len)
	{
		_buffer.append(msg, len);
		return GXMISC::HANDLE_RET_OK;
	}

protected:
	std::string _buffer;							///< »º³åBuffer
};

#endif	// _BUFFER_SOCKET_HANDLER_H_