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
	// �������ɵĽ�ɫUID
	void setGenRoleUID(TRoleUID_t roleUID, TObjUID_t objUID, uint32 maxNameID);
	// ���ɽ�ɫUID
	TRoleUID_t genRoleUID();
	// ��ǰ��ɫ����Ϸ�еĽ�ɫUID
	TObjUID_t genTempRoleUID();
	TObjUID_t getTempRoleUID();
	// ���һ������
	TRoleName_t genRoleName();
	
public:
	void update(GXMISC::TDiffTime_t diff);

private:
	TRoleUID_t _genRoleUID;		// ��ɫ��ȫ��UID
	TObjUID_t _genTempRoleUID;	// ��ɫ����Ϸ�е�ȫ��UID
	uint32 _genNameID;			// ������ֵ����ID

public:
	/// ��ͼ�������ر�
	void closeByMapServer(TServerID_t mapServerID);
	/// �ߵ����
	void kickPlayerByAccountID(TAccountID_t accountID);

public:
	// ������find*����
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
