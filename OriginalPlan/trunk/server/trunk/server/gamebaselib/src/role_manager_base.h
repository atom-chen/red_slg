#ifndef _ROLE_MANAGER_BASE_H_
#define _ROLE_MANAGER_BASE_H_

#include "core/obj_mem_fix_empty_pool.h"
#include "core/singleton.h"

#include "role_base.h"
#include "game_util.h"
#include "game_player_mgr.h"

typedef CRoleBase RoleBase;

class CRoleManagerBase 
	: public CGamePlayerMgr3<CRoleBase>
{
	friend class CRoleBase;

public:
	typedef CGamePlayerMgr3<CRoleBase>::ValueType ValueType;
	typedef CGamePlayerMgr3<CRoleBase> TBaseType;

protected:
	CRoleManagerBase();
public:
	virtual ~CRoleManagerBase();

public:
	// 重命名find*函数, 重命名之后为: findByRoleUID(TRoleUID), findByObjUID(TObjUID), findByAccountID(TAccountID)
	DGameMgrRenameFunc1(ValueType, RoleUID, RoleBase);
	DGameMgrRenameFunc2(ValueType, ObjUID, RoleBase);
	DGameMgrRenameFunc3(ValueType, AccountID, RoleBase);

public:
	void update(uint32 diff);  
	void updateTimer(uint32 timerID);  
	void updateRoleIdle();									// 更新玩家  
	TSaveIndex_t getSaveSec();                    			// 获取保存的时间间隔  
	bool renameRole(TRoleUID_t roleUID, const std::string& name);	// 重命名 
	void kickAllRole();										// 踢掉所有玩家 
	void doProfile();										// 统计 

private:
	void rebuildSaveIndex(bool forceFlag);      			// 重建索引
	TSaveIndex_t randSaveIndex();                 			// 随机索引
	uint8 getSaveNumIndex();                    			// 根据人数获取保存的数目索引
	TSaveIndex_t getSaveIndex();                  			// 获取人数最小的保存索引
	void putSaveIndex(TSaveIndex_t index);        			// 返回一个索引
	

protected:
	virtual void delRole(TRoleUID_t roleUID) = 0;			// 删除玩家

private:
	GXMISC::TGameTime_t			_lastProfileTime;			// 上一次统计时间
	std::vector<TSaveIndex_t>	_roleSaveIndexs;			// 角色的保存索引
	TSaveIndex_t				_saveNumIndex;				// 保存索引的个数
	GXMISC::TGameTime_t			_lastUpdateTimeoutRoleTime;	// 上一检查超时的时间
};

#endif	// _ROLE_MANAGER_BASE_H_