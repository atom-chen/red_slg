#ifndef _ROLE_MANAGER_H_
#define _ROLE_MANAGER_H_

#include "core/obj_mem_fix_empty_pool.h"
#include "core/singleton.h"

#include "role.h"
#include "game_util.h"
#include "game_player_mgr.h"
#include "map_db_role_data.h"
#include "role_manager_base.h"

// 角色管理器
class CRoleManager : public CRoleManagerBase
	, public GXMISC::CManualSingleton<CRoleManager>
{
public:
	typedef CRoleManagerBase TBaseType;
	typedef GXMISC::CFixEmptyObjPool<CHumanDBData, TRoleUID_t, 1000> THummanDBPool;
	typedef GXMISC::CFixObjPool<CRole> TRolePool;
	typedef CRole* ValueType;
	DSingletonImpl();

public:
	CRoleManager();
	~CRoleManager();

public:
	bool init(sint32 maxPlayerNum);

public:
	template<typename T>
	void broadcastToAllEnterQue(T& pack)
	{
		for(auto iter = this->_enterQue.begin(); iter != this->_enterQue.end(); ++iter)
		{
			iter->second->sendPacket(pack);
		}
	}

public:
	CRole* addNewPlayer(CRole::KeyType key1, CRole::KeyType2 key2, CRole::KeyType3 key3, bool isAddToReady = false); 
	void freeNewPlayer(ValueType val); 
	void delPlayer( CRole::KeyType key1 ); 
	sint32 getSize();

public:
	virtual void update(uint32 diff); 
	void roleHeart(GXMISC::TDiffTime_t diff);

public:
	// 重命名find*函数, 重命名之后为: findByRoleUID(TRoleUID), findByObjUID(TObjUID), findByAccountID(TAccountID)
	DGameMgrRenameFunc1(ValueType, RoleUID, CRole);
	DGameMgrRenameFunc2(ValueType, ObjUID, CRole);
	DGameMgrRenameFunc3(ValueType, AccountID, CRole);

public:
	CRoleManager::THummanDBPool* getRoleHummanDBPool();					// 玩家数据池
	CRole* newRole(TRoleUID_t roleUID, TObjUID_t objUID, TAccountID_t accountID, bool addToReadyFlag);	// 分配Role对象
	void delRole(TRoleUID_t roleUID);									// 删除玩家对象 
	bool initRolePool(sint32 num);										// 初始化玩家对象池
	void setNewRoleScriptFunctionName(std::string functionName);		// 脚本函数名

	// 加载和保存玩家数据
public:
	// 加载玩家数据
	EGameRetCode loadRoleData(TLoadRoleData* loadData, GXMISC::TSocketIndex_t requestSocketIndex, GXMISC::TSocketIndex_t playerSocketIndex, TChangeLineTempData* changeLineTempData, bool isLocalServerLogin);
	// 加载玩家数据返回
	EGameRetCode loadRoleDataRet(TLoadRoleData* loadData, GXMISC::TSocketIndex_t requestSocketIndex, GXMISC::TSocketIndex_t loginPlayerSockIndex,
		TChangeLineTempData* changeLineTempData, GXMISC::TDbIndex_t dbIndex, TRoleManageInfo* roleInfo, CHumanDBBackup* humanDB, bool isAdult, bool isLocalServerLogin, CRole*& pRole);
	// 施放玩家数据
	EGameRetCode unLoadRoleData(TRoleUID_t roleUID, GXMISC::TSocketIndex_t loginPlayerSocketIndex, bool needRet, EUnloadRoleType unloadType);

private:
	THummanDBPool _hummanDBPool;							// 玩家数据池
	TRolePool _objPool;										// 对象池
	GXMISC::CManualIntervalTimer _scriptUpdateTimer;		// 脚本更新定时器
	GXMISC::CManualIntervalTimer _roleHeartUpdateTimer;		// 角色心跳更新到世界服务器的定时器
	std::string _newRoleScriptFunctionName;					// 创建Role的脚本函数名
};

#define DRoleManager CRoleManager::GetInstance()

#endif	// _ROLE_MANAGER_H_