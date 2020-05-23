#ifndef _WORLD_DB_TASK_H_
#define _WORLD_DB_TASK_H_

#include "core/db_task.h"
#include "core/base_util.h"
#include "core/carray.h"
#include "core/database_conn.h"

#include "game_errno.h"
#include "game_util.h"
#include "user_struct.h"
#include "game_define.h"
#include "server_define.h"
#include "packet_struct.h"
#include "world_login_role_list.h"
#include "server_struct.h"

class CWorldPlayer;

/**
* @brief 游戏初始化数据 
*/
class CWorldDbGameInitTask: public GXMISC::CDbWrapTask {
public:
	CWorldDbGameInitTask() :GXMISC::CDbWrapTask(){}
	~CWorldDbGameInitTask(){}

protected:
	virtual void doWork(mysqlpp::Connection * conn);
};
class CWorldDbGameInitRetTask: public GXMISC::CDbConnTask {
public:
	CWorldDbGameInitRetTask():GXMISC::CDbConnTask(){
		retCode = RC_FAILED;
		maxRoleUID = INVALID_ROLE_UID;
	}
	~CWorldDbGameInitRetTask(){}

public:
	TRetCode_t retCode;
	TRoleUID_t maxRoleUID;
	TObjUID_t maxObjUID;
	uint32 maxNameID;

public:
	virtual void doRun();
};

// 服务器列表数据
class CWorldDbServerInitTask: public GXMISC::CDbWrapTask {
public:
	CWorldDbServerInitTask():GXMISC::CDbWrapTask() {
		serverID = INVALID_SERVER_ID;
	}
	~CWorldDbServerInitTask() {
	}

protected:
	virtual void doWork(mysqlpp::Connection * conn);
public:
	TServerID_t serverID;
};
class CWorldDbServerInitRetTask: public GXMISC::CDbConnTask {
public:
	CWorldDbServerInitRetTask():GXMISC::CDbConnTask(){
		  retCode = RC_FAILED;
		  clientListenIP = "";
		  clientListenPort = 0;
		  serverFirstStartTime = 0;
		  serverOpenTime = 0;
	  }
	  ~CWorldDbServerInitRetTask() {
	  }

public:
	TRetCode_t retCode;
	TCharArray2 clientListenIP;
	GXMISC::TPort_t clientListenPort;
	GXMISC::CGameTime serverFirstStartTime;
	GXMISC::CGameTime serverOpenTime;

public:
	virtual void doRun();
};

/**
* @brief 从数据库层向游戏逻辑层发送的响应任务, 账号为唯一标识
*/
class CWorldDbResponseTask: public GXMISC::CDbConnTask {
protected:
	CWorldDbResponseTask() :
	  GXMISC::CDbConnTask() {
		  accountID = INVALID_ACCOUNT_ID;
	  }
public:
	  virtual ~CWorldDbResponseTask() {
	  }

public:
	virtual void doRun();

protected:
	virtual void doWork(CWorldPlayer* player) = 0;

public:
	TAccountID_t accountID; // 账号ID
};

/**
* @brief 从游戏逻辑层向数据库层发送请求任务, 账号为唯一标识
*/
class CWorldDbRequestTask: public GXMISC::CDbWrapTask {
protected:
	CWorldDbRequestTask() :
	  GXMISC::CDbWrapTask() {
		  accountID = INVALID_ACCOUNT_ID;
	  }
public:
	  virtual ~CWorldDbRequestTask() {
	  }

public:
	template<typename TaskType>
	TaskType* newResponseTask() {
		TaskType* temp = getDbConn()->newTask<TaskType>();
		temp->accountID = accountID;
		temp->setDbUserIndex(getDbUserIndex());
		return temp;
	}
public:
	TAccountID_t accountID;				// 账号ID
};

// 账号登陆
class CWorldDbAccountVerifyRetTask : public GXMISC::CDbConnTask {
public:
	CWorldDbAccountVerifyRetTask() :
	  GXMISC::CDbConnTask() {
		  DCleanSubStruct(GXMISC::CDbConnTask);
		  retCode = RC_FAILED;
		  loginKey = INVALID_LOGIN_KEY;
		  socketIndex = GXMISC::INVALID_UNIQUE_INDEX;
		  accountID = INVALID_ACCOUNT_ID;
	  }
	  ~CWorldDbAccountVerifyRetTask() {
	  }

public:
	TRetCode_t retCode;					///< 返回码
	TLoginKey_t loginKey;				///< 登陆Key
	GXMISC::TUniqueIndex_t socketIndex; ///< Socket索引
	TAccountID_t accountID;				///< 账号ID

private:
	void doPlayerClean();

public:
	virtual void doRun();
};
class CWorldDbAccountVerifyTask : public GXMISC::CDbWrapTask 
{
public:
	CWorldDbAccountVerifyTask() :
	  GXMISC::CDbWrapTask () {
		  DCleanSubStruct(CWorldDbRequestTask);
		  socketIndex = GXMISC::INVALID_UNIQUE_INDEX;
		  accountName.clear();
		  accountPass.clear();
		  accountID = INVALID_ACCOUNT_ID;
	  }
	  ~CWorldDbAccountVerifyTask() {
	  }

protected:
	virtual void doWork(mysqlpp::Connection * conn);

public:
	TAccountName_t accountName;				///< 账号名字
	TAccountPassword_t accountPass;			///< 账号密码
	GXMISC::TUniqueIndex_t socketIndex;		///< Socket索引
	TAccountID_t accountID;					///< 账号ID
};

// 连接验证
class CWorldDbConnectVerifyRetTask : public GXMISC::CDbConnTask {
public:
	CWorldDbConnectVerifyRetTask() :
	  GXMISC::CDbConnTask() {
		  DCleanSubStruct(GXMISC::CDbConnTask);
		  retCode = RC_FAILED;
		  loginKey = INVALID_LOGIN_KEY;
		  socketIndex = GXMISC::INVALID_UNIQUE_INDEX;
		  accountID = INVALID_ACCOUNT_ID;
	  }
	  ~CWorldDbConnectVerifyRetTask() {
	  }

public:
	TRetCode_t retCode;					///< 返回码
	GXMISC::TUniqueIndex_t socketIndex; ///< Socket索引
	TLoginKey_t loginKey;				///< 登陆Key
	TAccountID_t accountID;				///< 账号ID
	TSourceWayID_t sourceWay;			///< 渠道
	TSourceWayID_t chiSourceWay;		///< 子渠道
	TGmPower_t gmPower;					///< GM权限
	TLoginRoleArray roleList;			///< 玩家列表

private:
	void doPlayerClean();

public:
	virtual void doRun();
};
class CWorldDbConnectVerifyTask : public GXMISC::CDbWrapTask 
{
public:
	CWorldDbConnectVerifyTask() :
	  GXMISC::CDbWrapTask () {
		  DCleanSubStruct(CWorldDbRequestTask);
		  socketIndex = GXMISC::INVALID_UNIQUE_INDEX;
		  loginKey = INVALID_LOGIN_KEY;
		  accountID = INVALID_ACCOUNT_ID;
	  }
	  ~CWorldDbConnectVerifyTask() {
	  }

protected:
	virtual void doWork(mysqlpp::Connection * conn);

private:
	// 获取角色列表
	bool getRoleList(mysqlpp::Connection * conn, TLoginRoleArray& roleList, TAccountID_t accountID);

public:
	TLoginKey_t loginKey;					///< 登陆Key
	GXMISC::TUniqueIndex_t socketIndex;		///< Socket索引
	TAccountID_t accountID;					///< 账号ID
	TSourceWayID_t sourceWay;				///< 渠道
	TSourceWayID_t chiSourceWay;			///< 子渠道
	TGmPower_t gmPower;						///< GM权限
};

// 创建角色
class CWorldCreateRoleRetTask : public CWorldDbResponseTask {
public:
	CWorldCreateRoleRetTask() :
	  CWorldDbResponseTask() {
		  retCode = RC_FAILED;
	  }
	  ~CWorldCreateRoleRetTask() {
	  }

public:
	TRetCode_t retCode;
	TLoginRole role;
	TRankNum_t rankNum;

protected:
	virtual void doWork(CWorldPlayer* player);
};

class CWorldDbRoleCreateTask : public CWorldDbRequestTask {
public:
	CWorldDbRoleCreateTask() :
	  CWorldDbRequestTask() 
	  {
		  DCleanSubStruct(CWorldDbRequestTask);
		  roleUID = INVALID_ROLE_UID;
		  objUID = INVALID_OBJ_UID;
		  name.clear();
		  typeID = INVALID_ROLE_PROTYPE_ID;
		  accountID = INVALID_ACCOUNT_ID;
		  sceneID = INVALID_SCENE_ID;
		  x = INVALID_AXIS_POS;
		  y = INVALID_AXIS_POS;
		  rankNum = INVALID_RANK_NUM;
		  sourceway = INVALID_SOURCE_WAY_ID;
		  chisourceway = INVALID_SOURCE_WAY_ID;
	  }
	  ~CWorldDbRoleCreateTask() {
	  }

public:
	TRoleUID_t roleUID;
	TObjUID_t objUID;
	TRoleName_t name;
	TRoleProtypeID_t typeID;
	TAccountID_t accountID;
	TSceneID_t sceneID;
	TAxisPos_t x;
	TAxisPos_t y;
	TRankNum_t rankNum;
	TSourceWayID_t	sourceway;
	TSourceWayID_t	chisourceway;

protected:
	virtual void doWork(mysqlpp::Connection * conn);
};

class CWorldLoadUserDataTask : public GXMISC::CDbWrapTask {
public:
	CWorldLoadUserDataTask() :
	  GXMISC::CDbWrapTask() 
	  {
		  roleUID = INVALID_ROLE_UID;
	  }
	  ~CWorldLoadUserDataTask() {}

protected:
	virtual void doWork(mysqlpp::Connection * conn);

public:
	TRoleUID_t			roleUID;
};

class CWorldLoadUserDataRetTask: public GXMISC::CDbConnTask {
public:
	CWorldLoadUserDataRetTask() :
	  GXMISC::CDbConnTask()
	  {
		  retCode = RC_FAILED;
		  roleUID = INVALID_ROLE_UID;
		  userData.cleanUp();
	  }
	  ~CWorldLoadUserDataRetTask() {}

protected:
	virtual void doRun();

public:
	TRetCode_t			retCode;
	TRoleUID_t			roleUID;
	TUserDbData			userData;
};

#endif	// _WORLD_DB_TASK_H_