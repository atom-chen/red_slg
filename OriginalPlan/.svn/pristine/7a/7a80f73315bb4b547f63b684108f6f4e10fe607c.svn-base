#ifndef _MAP_WORLD_HANDLER_BASE_H_
#define _MAP_WORLD_HANDLER_BASE_H_

#include "game_util.h"
#include "game_socket_handler.h"
#include "game_define.h"
#include "packet_mw_base.h"

enum ETransCode
{
	TRANS_CODE_CONTINUE,			// 转发给目标玩家
	TRANS_CODE_STOP,				// 停止转发给目标玩家
};

class CRoleBase;
// 地图服务器与世界服务器的连接处理句柄
class CMapWorldServerHandlerBase : public CGameSocketHandler<CMapWorldServerHandlerBase>
{
public:
	typedef CGameSocketHandler<CMapWorldServerHandlerBase> TBaseType;
	typedef CMapWorldServerHandlerBase TMySelfType;

public:
	CMapWorldServerHandlerBase() : CGameSocketHandler<CMapWorldServerHandlerBase>(){}
	~CMapWorldServerHandlerBase(){}

public:
	virtual bool    start();
	virtual void    close();
	virtual void    breath(GXMISC::TDiffTime_t diff);

public:
	void quit();

public:
	// 其他服务器广播
	virtual ETransCode doBroadCast(CBasePacket* packet, TObjUID_t srcObjUID){ return TRANS_CODE_STOP; }

	// 其他服务器转发
	virtual ETransCode doTrans(CBasePacket* packet, TObjUID_t srcObjUID, TObjUID_t destObjUID){ return TRANS_CODE_STOP; }

	// 转发出错
	void doTransError(CBasePacket* packet, TObjUID_t srcObjUID, TObjUID_t destObjUID, EGameRetCode retCode){}

public:
	template<typename T>
	static void SendPacket(T& packet);
	static bool IsActive();

public:
	void sendRegisteToWorld(TServerID_t serverID, EServerType serverType, uint32 maxRoleNum, const GXMISC::TIPString_t& ip, GXMISC::TPort_t port);

public:
	GXMISC::EHandleRet handleRegisteToWorldRet(WMRegisteRet* packet);
	GXMISC::EHandleRet handleBroadCast(MWBroadPacket* packet);
	GXMISC::EHandleRet handleTrans(MWTransPacket* packet);
	GXMISC::EHandleRet handleTransError(WMTransPacketError* packet);
	GXMISC::EHandleRet handleRoleHeartRet( WMRoleHeartRet* packet );
	GXMISC::EHandleRet handleRename(WMRenameRoleNameRet* packet);
	GXMISC::EHandleRet handleServerInfo(WMServerInfo* packet);

public:
	static CMapWorldServerHandlerBase* WorldServerHandler;

protected:
	static void WorldBroadPacket(CRoleBase*& pRole, void* arg);
};

// 发送协议到世界服务器
template<typename T>
void CMapWorldServerHandlerBase::SendPacket( T& packet )
{
	if(TMySelfType::IsActive())
	{
		TMySelfType::WorldServerHandler->sendPacket(packet);
	}
	else
	{
		gxError("World server is close! Packet={0}", typeid(packet).name());
	}
}

// 发送到世界服务器
template<typename T>
bool SendToWorld(T& packet)
{
	if(CMapWorldServerHandlerBase::IsActive())
	{
		CMapWorldServerHandlerBase::WorldServerHandler->sendPacket(packet);
		return true;
	}
	else
	{
		gxError("World server is close! Packet={0}", typeid(packet).name());
		return false;
	}

	return false;
}

template<bool flag>
struct PacketPush
{
public:
	template<typename T1, typename T2>
	static void Push(T1& packet, T2& msg)
	{
		GXMISC::CMemTempOutputStream<sizeof(T1)> outputStream;
		outputStream.serial(packet);
		gxAssert(outputStream.size() == packet.serialLen());
		msg.pushBack(outputStream.data(), outputStream.size());
	}
};

template<>
struct PacketPush<false>
{
public:
	template<typename T1, typename T2>
	static void Push(T1& packet, T2& msg)
	{
		msg.pushBack((const char*)&packet, packet.getPackLen());
	}
};

// 通过世界服务器广播到所有地图服务器
template<typename T>
void BroadCastToWorld(T& packet, TObjUID_t srcObjUID, bool sendToMe = false)
{
	MWBroadPacket broadMsg;
	if(packet.getPackLen() > broadMsg.msg.maxSize())
	{
		return;
	}

	broadMsg.sendToMe = sendToMe;
	broadMsg.srcObjUID = srcObjUID;
	PacketPush<GXMISC::ICanStreamable<T>::value>::Push(packet, broadMsg.msg);

	SendToWorld(broadMsg);
}

// 通过世界服务器转发到其他地图服务器
// failedNeedRes 发送失败之后是否需要通知发送人
template<typename T>
void Trans2OtherMapServer(T& packet, TObjUID_t srcObjUID, TObjUID_t destObjUID, bool failedNeedRes = true)
{
	MWTransPacket transMsg;
	if(packet.getPackLen() > (TPackLen_t)transMsg.msg.maxSize())
	{
		if(CMapWorldServerHandlerBase::IsActive())
		{
			CMapWorldServerHandlerBase::WorldServerHandler->doTransError(&packet, srcObjUID, destObjUID, RC_ROLE_OFFLINE);
		}

		return;
	}

	transMsg.failedNeedRes = failedNeedRes;
	transMsg.srcObjUID = srcObjUID;
	transMsg.destObjUID = destObjUID;
	PacketPush<GXMISC::ICanStreamable<T>::value>::Push(packet, transMsg.msg);
	if(false == SendToWorld(transMsg))
	{
		if(CMapWorldServerHandlerBase::IsActive())
		{
			CMapWorldServerHandlerBase::WorldServerHandler->doTransError(&packet, srcObjUID, destObjUID, RC_ROLE_OFFLINE);
		}
	}
}

// 发到世界服务器
template<typename T>
bool Trans2World(T& packet, TObjUID_t srcObjUID)
{
	MWTrans2WorldPacket transMsg;
	if(packet.getPackLen() > (TPackLen_t)transMsg.msg.maxSize())
	{
		gxError("Can't trans to world,msg pack len great than trans max size!PackSize={0},MaxTransSize={1},PackName={2}",
			packet.getPackLen(), transMsg.msg.maxSize(), typeid(packet).name());
		return false;
	}

	transMsg.destObjUID = srcObjUID;
	PacketPush<GXMISC::ICanStreamable<T>::value>::Push(packet, transMsg.msg);
	if(false == SendToWorld(transMsg))
	{
		if(CMapWorldServerHandlerBase::IsActive())
		{
			gxError("Can't trans to world, world close!PackName={0}", typeid(packet).name());
		}

		return false;
	}

	return true;
}

#define DMapWorldPlayerBase CMapWorldServerHandlerBase::WorldServerHandler

#endif	// _MAP_WORLD_HANDLER_BASE_H_