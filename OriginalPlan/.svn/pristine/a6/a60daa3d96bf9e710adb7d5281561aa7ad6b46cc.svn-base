#ifndef _WORLD_PLAYER_MGR_H_
#define _WORLD_PLAYER_MGR_H_

#include "core/singleton.h"

#include "game_player_mgr.h"
#include "world_player.h"
#include "packet_struct.h"

class CWorldPlayerMgr: public CGamePlayerMgr2Pool<CWorldPlayer>,
	public GXMISC::CManualSingleton<CWorldPlayerMgr> {
public:
	typedef CGamePlayerMgr<CWorldPlayer>::ValueType ValueType;
	typedef CGamePlayerMgr2<CWorldPlayer> TBaseType;
	DSingletonImpl();

public:
	CWorldPlayerMgr();
	~CWorldPlayerMgr();

public:
	// 设置生成的角色UID
	void setGenRoleUID(TRoleUID_t roleUID, TObjUID_t objUID, uint32 maxNameID);
	// 生成角色UID
	TRoleUID_t genRoleUID();
	// 当前角色在游戏中的角色UID
	TObjUID_t genTempRoleUID();
	TObjUID_t getTempRoleUID();
	// 随机一个名字
	TRoleName_t genRoleName();
	
public:
	void update(GXMISC::TDiffTime_t diff);

private:
	TRoleUID_t _genRoleUID;		// 角色的全局UID
	TObjUID_t _genTempRoleUID;	// 角色在游戏中的全局UID
	uint32 _genNameID;			// 随机名字的最大ID

public:
	/// 地图服务器关闭
	void closeByMapServer(TServerID_t mapServerID);
	/// 踢掉玩家
	void kickPlayerByAccountID(TAccountID_t accountID);

public:
	// 重命名find*函数
	DGameMgrRenameFunc1(ValueType, AccountID, CWorldPlayer);
	DGameMgrRenameFunc2(ValueType, SocketIndex, CWorldPlayer);

	static void UpdateReadyRole(CWorldPlayer*& pplayer, void* arg)
	{
		TPacketSourceWay temp;
		TPacketSourceWayVec* tempary = (TPacketSourceWayVec*)arg;
		if(pplayer)
		{
			temp.clean();
			temp.source_way		= pplayer->getSourceWay();
			temp.chisource_way	= pplayer->getChisourceWay();
			tempary->push_back(temp);
		}
	}
private:
	GXMISC::TGameTime_t _lastProfileTime;
};

#define DWorldPlayerMgr CWorldPlayerMgr::GetInstance()

#endif
