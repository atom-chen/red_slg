#ifndef _GAME_HANDLER_H_
#define _GAME_HANDLER_H_

#include <map>

#include "base_packet_def.h"

#include "core/debug.h"
#include "core/socket_handler.h"
#include "core/hash_util.h"

typedef GXMISC::EHandleRet (GXMISC::CSocketHandler::*TPacketHandler)(CBasePacket* packet);	// 消息处理函数
typedef CHashMap<TPacketID_t, TPacketHandler> TPacketHandlerHash;							// 消息处理函数哈希映射表

template<typename T>
class CGameHandler : public GXMISC::CScriptSocketHandler
{
public:
	typedef GXMISC::CScriptSocketHandler TBaseType;
protected:
	CGameHandler(){ _isIgnore = false; _isLog = true; }
	virtual ~CGameHandler(){}

public:
	void setIgnore()
	{
		_isIgnore = true;
	}
	void setShowLog(bool flag = false)
	{
		_isLog = flag;
	}
public:
	static void RegisteHandler(TPacketID_t id, TPacketHandler handler);

public:
	virtual GXMISC::EHandleRet handle(char* msg, uint32 len)
	{
		gxAssert(msg != NULL);
		CBasePacket* packet = (CBasePacket*)msg;
		gxAssert(packet->totalLen <= len);
		if(false == packet->check())
		{
			gxError("Pack is invalid! TotalLen={0}, PacketID={1}, Flag={2}", packet->totalLen, packet->packetID, int(packet->flag));
		}
		gxDebug("PacketID={0}", packet->getPacketID());

		T* caller = (T*)this;
		if (false == caller->onBeforeHandlePacket(packet))
		{
			return GXMISC::HANDLE_RET_OK;
		}

		GXMISC::EHandleRet ret = GXMISC::HANDLE_RET_FAILED;
		TPacketHandlerHash::iterator iter = HandlerMap.find(packet->getPacketID());
		if (iter != HandlerMap.end())
		{
			TPacketHandler handler = iter->second;
			ret = (caller->*handler)(packet);
		}
		else if(!IsSuccess(TBaseType::handle(msg, len)) && _isLog)
		{
			gxError("Can't get packet handler!PacketID={0}", packet->getPacketID());
			return GXMISC::HANDLE_RET_FAILED;
		}

		ret = GXMISC::HANDLE_RET_OK;
		caller->onAfterHandlePacket(packet);

		return ret;
	}

private:
	bool _isIgnore;										// 是否忽略消息未注册的错误
	bool _isLog; // 是否显示日志

private:
	static TPacketHandlerHash HandlerMap;				// 消息处理函数哈希表
};

template<typename T>
TPacketHandlerHash CGameHandler<T>::HandlerMap;

template<typename T>
void CGameHandler<T>::RegisteHandler( TPacketID_t id, TPacketHandler handler )
{
	HandlerMap.insert(TPacketHandlerHash::value_type(id, handler));
}

#endif