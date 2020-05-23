#ifndef _MAP_DB_PLAYER_HANDLER_BASE_H_
#define _MAP_DB_PLAYER_HANDLER_BASE_H_

#include "core/database_conn_wrap.h"

#include "game_util.h"
#include "map_db_task_base.h"
#include "game_database_handler.h"
#include "map_world_handler_base.h"

class CDataBackup;
class CRole;

class CMapDbPlayerHandlerBase : public CGameDatabaseHandler
{
public:
	typedef CGameDatabaseHandler TBaseType;

public:
	CMapDbPlayerHandlerBase(GXMISC::CDatabaseConnWrap* dbWrap = NULL, GXMISC::TUniqueIndex_t index = GXMISC::INVALID_UNIQUE_INDEX);
	~CMapDbPlayerHandlerBase(){}

public:
	// 连接建立
	virtual bool start();
	// 消息处理
	virtual GXMISC::EHandleRet handle(char* msg, uint32 len){ return GXMISC::HANDLE_RET_OK; }
	// 连接关闭
	virtual void close(){}
	// 定时更新
	virtual void breath(GXMISC::TDiffTime_t diff){ TBaseType::breath(diff); }
	// 退出
	void quit();

public:
	void setAccountID(TAccountID_t accountID);
	TAccountID_t getAccountID();
	void setRoleUID(TRoleUID_t roleUID);
	TRoleUID_t getRoleUID();
	void setObjUID(TObjUID_t objUID);
	TObjUID_t getObjUID();
	void setRequestSocketIndex(GXMISC::TSocketIndex_t index);
	GXMISC::TSocketIndex_t getRequestSocketIndex();
	void setLoginPlayerSockIndex(GXMISC::TSocketIndex_t index);
	GXMISC::TSocketIndex_t getLoginPlayerSockIndex();
	CRoleBase* getRole(bool logFlag);

public:
	template<typename T>
	void sendPacketToWorld(T& packet)
	{
		CMapWorldServerHandlerBase* handler = getWorldServerHandlerBase();
		if(NULL != handler)
		{
			handler->sendPacket(packet);
		}
	}

protected:
	CMapWorldServerHandlerBase* getWorldServerHandlerBase(bool logFlag = true);

public:
	void pushTask(CMapDbRequestTask* task);

private:
	TAccountID_t    _accountID;							// 账号UID
	TRoleUID_t      _roleUID;							// 角色UID
	TObjUID_t       _objUID;							// 对象UID
	GXMISC::TSocketIndex_t  _requestSocketIndex;		// 世界服务器连接ID
	GXMISC::TSocketIndex_t  _loginPlayerSockIndex;		// 世界服务器上玩家的连接ID

	DFastObjToString5Alias(CMapDbPlayerHandlerBase,
		GXMISC::TDbIndex_t,     DbIndex,    _index,
		TAccountID_t,   AccountID,  _accountID,
		TRoleUID_t,     RoleUID,    _roleUID,
		TObjUID_t,      ObjUID,     _objUID,
		GXMISC::TSocketIndex_t, WorldSvrSocketIndex, _requestSocketIndex);
};

#endif	// _MAP_DB_PLAYER_HANDLER_BASE_H_