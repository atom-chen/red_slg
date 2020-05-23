#ifndef _WORLD_MAP_PLAYER_MGR_H_
#define _WORLD_MAP_PLAYER_MGR_H_

#include "game_util.h"
#include "world_map_player.h"

#include "core/obj_mem_fix_pool.h"
#include "core/multi_index.h"
#include "core/singleton.h"
#include "core/time/interval_timer.h"

class CWorldMapPlayerMgr : public GXMISC::CHashMultiIndex<CWorldMapPlayer>,
	public GXMISC::CManualSingleton<CWorldMapPlayerMgr>
{
public:
	typedef GXMISC::CHashMultiIndex<CWorldMapPlayer> TBaseType;
	DSingletonImpl();
	DMultiIndexIterFunc(CWorldMapPlayer);

public:
	CWorldMapPlayerMgr() ;
	~CWorldMapPlayerMgr();

public:
	bool init(uint32 num);
	void update(GXMISC::TDiffTime_t diff);
	CWorldMapPlayer* addMapPlayer(TServerID_t serverID);
	void delMapPlayer(TServerID_t serverID);
	CWorldMapPlayer* findMapPlayer(TServerID_t serverID);

public:
	CWorldMapPlayer* getLeastNormalMapServer();             // 获取一个可以进入的最小的普通场景服务器
	CWorldMapPlayer* getLeastDynamicServer();               // 得到一个人数最小的动态场景服务器

public:
	void updateServerInfo();

public:
	template<typename T>
	void broadCast(T&packet)
	{
		for(TBaseType::Iterator iter = begin(); iter != end(); ++iter)
		{
			iter->second->sendPacket(packet);
		}
	}

public:
	template <typename T>
	void sendPacket( T& msg )
	{
		for ( TBaseType::Iterator itr=begin(); itr!=end(); ++itr )
		{
			CWorldMapPlayer* mapPlayer = itr->second;
			if ( mapPlayer == NULL )
			{
				continue;
			}
			mapPlayer->sendPacket(msg);
		}
	}

	template <typename T>
	void sendPacketToSingleMapServer( T& msg )
	{
		TBaseType::Iterator itr = begin();
		if ( itr == end() )
		{
			return ;
		}
		CWorldMapPlayer* mapPlayer = itr->second;
		if ( mapPlayer == NULL )
		{
			return ;
		}
		mapPlayer->sendPacket(msg);
	}

private:
	void updateServerData(GXMISC::TDiffTime_t diff);

private:
	GXMISC::CFixObjPool<CWorldMapPlayer> _objPool;
	GXMISC::CManualIntervalTimer _updateServerDataTimer;
};

#define DWorldMapPlayerMgr CWorldMapPlayerMgr::GetInstance()

// 广播
template<typename T, bool flag >
struct _SendPackBroad
{
	void SendPacketBroad(T& packet, TObjUID_t srcObjUID);
};
template<typename T>
struct _SendPackBroad<T, false>
{
	static void SendPacketBroad(T& packet, TObjUID_t srcObjUID)
	{
		MWBroadPacket broadPacket;
		broadPacket.srcObjUID = srcObjUID;
		bool val = GXMISC::ICanStreamable<T>::value;
		gxAssert( val == false);												// 不允许发送从IStreamable继承下来的类
		broadPacket.msg.pushBack((char*)&packet, packet.getPackLen());
		DWorldMapPlayerMgr.broadCast(broadPacket);
	}
};

template<typename T>
struct _SendPackBroad<T, true>
{
	static void SendPacketBroad(T& packet, TObjUID_t srcObjUID = INVALID_OBJ_UID)
	{
#define MAX_SEND_PACKET_TRANS_BUF 32*1024

		GXMISC::CMemOutputStream outStream;
		uint32 len = packet.serialLen();
		if(len > MAX_SEND_PACKET_TRANS_BUF)
		{
			bool val = GXMISC::ICanStreamable<T>::value;
			gxAssert( val == true );								// 不允许发送从IStreamable继承下来的类

			outStream.init(len+100);

			outStream.serial(packet);
			MWBroadPacket broadPacket;
			broadPacket.srcObjUID = srcObjUID;
			broadPacket.msg.pushBack((char*)outStream.data(), outStream.size());
			DWorldMapPlayerMgr.broadCast(broadPacket);
		}
		else
		{
			char buf[MAX_SEND_PACKET_TRANS_BUF];
			memset(buf, 0, sizeof(buf));
			outStream.init(MAX_SEND_PACKET_TRANS_BUF, buf);

			outStream.serial(packet);

			MWBroadPacket broadPacket;
			broadPacket.srcObjUID = srcObjUID;
			broadPacket.msg.pushBack((char*)outStream.data(), outStream.size());
			DWorldMapPlayerMgr.broadCast(broadPacket);
		}
	}
};

// 通过MapServer转发数据到客户端
template<typename T>
void BroadCastToMapServer(T& packet, TObjUID_t srcObjUID = SYSTEM_OBJ_UID)
{
	_SendPackBroad<T, GXMISC::ICanStreamable<T>::value >::SendPacketBroad(packet, srcObjUID);
}

#endif
