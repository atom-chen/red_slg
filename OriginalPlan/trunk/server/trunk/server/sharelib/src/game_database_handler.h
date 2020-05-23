#ifndef _GAME_DATABASE_HANDLER_H_
#define _GAME_DATABASE_HANDLER_H_

#include "core/database_handler.h"
#include "core/types_def.h"
#include "core/base_util.h"
#include "core/socket_event_loop_wrap_mgr.h"

#include "game_socket_handler.h"
#include "game_util.h"
#include "base_packet_def.h"

class CGameDatabaseHandler  
	: public GXMISC::CDatabaseHandler
{
public:
	// 向网络层发送数据包
	template<typename T>
	void sendPacket(T packet)
	{
		GXMISC::CSocketHandler* handler = getSocketHandler();
		if(NULL != handler)
		{
			handler->send(&packet, packet.getPackLen());
		}
	}

protected:
	CGameDatabaseHandler(GXMISC::CDatabaseConnWrap* dbWrap = NULL, GXMISC::TUniqueIndex_t index = GXMISC::INVALID_UNIQUE_INDEX) :
	  CDatabaseHandler(dbWrap, index), _socketMgr(NULL), _socketIndex(GXMISC::INVALID_SOCKET_INDEX) {}
public:
	  virtual ~CGameDatabaseHandler(){}

public:
	void setSocketMgr(GXMISC::CNetModule* mgr)
	{
		_socketMgr = mgr;
	}
	void setSocketIndex(GXMISC::TSocketIndex_t socketIndex)
	{
		_socketIndex = socketIndex;
	}
	GXMISC::TSocketIndex_t getSocketIndex()
	{
		return _socketIndex;
	}
	virtual void breath(GXMISC::TDiffTime_t diff){}

protected:
	GXMISC::CSocketHandler* getSocketHandler()
	{
		GXMISC::CSocketHandler* handler = _socketMgr->getSocketHandler(_socketIndex);
		if(NULL == handler)
		{
			gxError("Can't find CSocketHandler! SocketIndex = {0}", GXMISC::gxToString(_socketIndex).c_str());
			return NULL;
		}

		return handler;
	}

protected:
	GXMISC::CNetModule* _socketMgr;
	GXMISC::TSocketIndex_t _socketIndex;
};

#endif