#ifndef _WORLD_SQL_MANAGER_H_
#define _WORLD_SQL_MANAGER_H_

#include "core/db_single_conn_manager.h"

#include "game_util.h"
#include "user_struct.h"
#include "server_struct.h"
#include "world_server_data.h"

class CSqlConnectionManagerBase : public GXMISC::CDbConnectionManager<CSqlConnectionManagerBase>
{
public:
	CSqlConnectionManagerBase();
	virtual ~CSqlConnectionManagerBase();

	// 服务器信息
public:
	//	bool	loadServerInfo();

	// 所有玩家
public:
	bool	loadAllUser();												///< 加载所有玩家
	bool	loadAllUserRoleUID(std::vector<TRoleUID_t>& data);			///< 加载所有的玩家的角色UID

	// 玩家数据
public:
	bool	loadUserData(TUserDbData* data);							///< 加载角色数据
	bool	addUserData(TUserDbData* data);								///< 添加角色数据 
	bool	updateUserData(TRoleUID_t roleUID, TUserDbData* newData);	///< 更新角色数据
	bool	deleteUserData(TRoleUID_t roleUID);							///< 删除角色数据

	// 角色管理
public:
	bool		changeRoleObjUID(TRoleUID_t roleUID, TObjUID_t objUID);		///< 更新角色objUID
	bool		delRole(TRoleUID_t roleUID, const char* roleStr);           ///< 删除角色时清除数据接口
	TRoleUID_t	getRoleUIDByAccountID(TAccountID_t accountID);				///< 通过账号得到角色UID
	TRoleName_t getRoleNameByRoleId(TRoleUID_t roleUID);					///< 通过uid查找名字
	TLevel_t	getRoleLevelByRoleId(TRoleUID_t roleUID);					///< 通过uid查找等级

	// 充值
public:
	bool	addTempRechargeRecord(TSerialStr_t serialNo, TAccountID_t accountID, TRmb_t rmb, TRmb_t bindRmb);	///< 增加临时充值记录
	bool	delTempRechargeRecord(TSerialStr_t serialNo);														///< 删除临时充值记录
	bool	updateTempRechargeRecord(TSerialStr_t serialNo, sint8 status);										///< 更新临时充值记录
	bool	accountRmbQuery(TAccountID_t accountID, TRmb_t& rmb, TRmb_t& bindRmb);								///< 账号元宝查询
	bool	addAccountRmb(TAccountID_t accountID, TRmb_t rmb, TRmb_t bindRmb);									///< 增加元宝
	TRoleUID_t getLastLoginRoleUIDByAccountID(TAccountID_t accountID);											///< 获取最后一次登陆的玩家UID

public:
	bool addAwardBindRmb(TRmb_t rmb, TGold_t gameMoney);														///< 后台奖励所有玩家元宝
	bool addAwardItem(TRoleUID_t roleUID, TItemTypeID_t itemID, TItemNum_t num);								///< 后台奖励玩家道具
	bool addRoleAwardBindRmb(TRoleUID_t roleUID, TAccountID_t accountID, TRmb_t rmb, TGold_t gameMoney);		///< 后台奖励玩家金钱
};

class CSqlConnectionManager : public CSqlConnectionManagerBase
{
public:
	CSqlConnectionManager();
	~CSqlConnectionManager();
};

#define DSqlConnectionMgr CSqlConnectionManager::GetInstance()

#endif	// _WORLD_SQL_MANAGER_H_