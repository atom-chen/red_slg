#ifndef _MAP_DB_TASK_H_
#define _MAP_DB_TASK_H_

#include "core/string_common.h"
#include "core/database_util.h"
#include "core/db_task.h"
#include "core/database_handler.h"

#include "game_util.h"
#include "game_errno.h"
#include "map_db_task_base.h"
#include "role.h"

class CLoadRoleDataRetTask;
class CRole;
// 加载角色数据
class CLoadRoleDataTask : public GXMISC::CDbWrapTask
{
public:
	CLoadRoleDataTask();
	~CLoadRoleDataTask(){}

protected:
	virtual void doWork(mysqlpp::Connection * conn);

private:
	bool		loadRoleGMPower(mysqlpp::Connection* conn, CLoadRoleDataRetTask* retTask);
	bool		loadRoleLimitInfo(mysqlpp::Connection* conn, CLoadRoleDataRetTask* retTask);

	DObjToString5Alias(CLoadRoleDataTask,
		GXMISC::TDbIndex_t, DbIndex, _uid,
		TRoleUID_t, RoleUID, loadData.roleUID, 
		TObjUID_t, ObjUID, loadData.objUID,
		TAccountID_t, AccountID, loadData.accountID,
		TMapID_t, TSceneID_t, loadData.sceneID);

public:
	bool isLocalServerLogin;
	TLoadRoleData loadData;
	TChangeLineTempData changeLineTempData;
	GXMISC::TSocketIndex_t worldPlayerSockIndex;
	GXMISC::TSocketIndex_t requestSocketIndex;
};
class CLoadRoleDataRetTask : public GXMISC::CDbConnTask
{
public:
	CLoadRoleDataRetTask();
	~CLoadRoleDataRetTask(){}

public:
	virtual void doRun();

	DObjToString5Alias(CLoadRoleDataRetTask,
		GXMISC::TDbErrorCode_t, RetCode, errorCode,
		GXMISC::TDbIndex_t, DbIndex, _uid,
		TRoleUID_t, RoleUID, loadData.roleUID, 
		TObjUID_t, ObjUID, loadData.objUID,
		TAccountID_t, AccountID, loadData.accountID);

public:
	bool isLocalServerLogin;
	TRoleManageInfo	roleInfo;
	TLoadRoleData loadData;
	TChangeLineTempData changeLineTempData;
	GXMISC::TSocketIndex_t worldPlayerSockIndex;
	GXMISC::TSocketIndex_t requestSocketIndex;
	CHumanDBBackup humanDB;
	bool isAdult;			// 是否成年 
};

/// 玩家注册任务
class CPlayerRegisteTask : public GXMISC::CDbWrapTask
{
public:
	TAccountName_t account;
	TAccountPassword_t passwd;
	GXMISC::TSocketIndex_t socketIndex;

protected:
	virtual void doWork(mysqlpp::Connection * conn);
};
class CPlayerRegisteRetTask  : public GXMISC::CDbConnTask
{
public:
	TAccountName_t account;
	GXMISC::TSocketIndex_t socketIndex;

public:
	virtual void doRun();
};

/**
* @brief 保存角色数据
*/
class CSaveRoleDataTask : public CMapDbRequestTask
{
public:
    CSaveRoleDataTask() : CMapDbRequestTask(){}

protected:
    virtual void doWork(mysqlpp::Connection * conn);

public:
	CHumanDBBackup humanDB;
    GXMISC::TSocketIndex_t worldPlayerSockIndex;
    bool needRet;

    DObjToStringAlias(CSaveRoleDataTask, TRoleUID_t, RoleUID, roleUID);
};

class CSaveRoleDataRetTask : public CMapDbResponseTask
{
public:
	CSaveRoleDataRetTask() : CMapDbResponseTask(){}

protected:
	virtual void doWork(CRoleBase* role);

public:
    GXMISC::TSocketIndex_t worldPlayerSockIndex;
};

class CUpdateRoleDataTimerTask : public CMapDbRequestTask
{
public:
	CUpdateRoleDataTimerTask() : CMapDbRequestTask(){}

protected:
	virtual void doWork(mysqlpp::Connection * conn);

public:
	CHumanDBBackup humanDB;

	DObjToStringAlias(CUpdateRoleDataTimerTask, TRoleUID_t, RoleUID, roleUID);
};
#endif	// _MAP_DB_TASK_H_