#ifndef _WORLD_DB_HANDLER_H_
#define _WORLD_DB_HANDLER_H_

#include "core/base_util.h"

#include "game_database_handler.h"
#include "game_util.h"
#include "world_db_task.h"

class CWorldDbHandler : public CGameDatabaseHandler 
{
public:
	typedef CGameDatabaseHandler TBaseType;

public:
	CWorldDbHandler(GXMISC::CDatabaseConnWrap* dbWrap = NULL, GXMISC::TUniqueIndex_t index =
		GXMISC::INVALID_UNIQUE_INDEX) :
	CGameDatabaseHandler(dbWrap, index) {
		setAccountID(INVALID_ACCOUNT_ID);
	}
	~CWorldDbHandler() {
	}

public:
	// 连接建立
	virtual bool start() {
		return true;
	}

	// 消息处理
	virtual GXMISC::EHandleRet handle(char* msg, uint32 len) {
		return GXMISC::HANDLE_RET_OK;
	}

	// 连接关闭
	virtual void close() {
	}

	// 定时更新
	virtual void breath(GXMISC::TDiffTime_t diff) {
		TBaseType::breath(diff);
	}


public:
	// @todo 退出, 清理指针, 删除自身对象
	void quit();

public:
	inline TAccountID_t getAccountID();
	inline void setAccountID(TAccountID_t accountID);

	template<typename TaskType>
	TaskType* newWorldDbTask() {
		TaskType* temp = newDatabaseTask<TaskType>();
		if (NULL == temp) {
			gxWarning("Can't new database task! DbIndex = {0}", getUniqueIndex());
		}
		temp->accountID = getAccountID();
		return temp;
	}
	void freeWorldDbTask(CWorldDbRequestTask* task) {
		freeDatabaseTask(task);
	}

	// 任务发送函数
public:
	bool sendVerifyAccountTask(TAccountName_t accountName, TAccountPassword_t pass);
	bool sendVerifyConnectTask(TLoginKey_t loginKey, TSourceWayID_t sourceWay, TSourceWayID_t chiSourceWay, TGmPower_t gmPower);
	bool sendCreateRoleTask(const char* name, TRoleProtypeID_t typeID, TSourceWayID_t sourceway, TSourceWayID_t chisourceway);

private:
	TAccountID_t _accountID;

public:
	DFastObjToString3Alias(CWorldDbHandler, TAccountID_t, AccountID, _accountID, GXMISC::TSocketIndex_t, SocketIndex, _socketIndex, GXMISC::TDbIndex_t, DbIndex, _index);
};

inline TAccountID_t CWorldDbHandler::getAccountID() {
	return _accountID;
}

inline void CWorldDbHandler::setAccountID(TAccountID_t accountID) {
	genStrName();
	_accountID = accountID;
}

#endif