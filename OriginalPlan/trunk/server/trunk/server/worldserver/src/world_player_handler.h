#ifndef _WORLD_PLAYER_HANDLER_H_
#define _WORLD_PLAYER_HANDLER_H_

#include "static_construct_enable.h"
#include "world_server_util.h"
#include "server_define.h"
#include "game_extend_socket_handler.h"
#include "packet_cw_login.h"

class CWorldDbHandler;
class CWorldPlayer;
class CWorldPlayerHandler : public CGameExtendSocketHandler<CWorldPlayerHandler> {
public:
	CWorldPlayerHandler() :
	  CGameExtendSocketHandler<CWorldPlayerHandler>() {
		  _dbUniqueIndex = GXMISC::INVALID_UNIQUE_INDEX;
		  _accountID = INVALID_ACCOUNT_ID;
	  }
	  ~CWorldPlayerHandler() {
	  }

protected:
	virtual bool start();
	virtual void close();
	virtual void breath(GXMISC::TDiffTime_t diff);
public:
	virtual bool onBeforeHandlePacket(CBasePacket* packet);

public:
	// @todo 退出, 清理指针及数据, 删除自身对象
	void quit();

private:
	void clean();
	bool closeDbHandler();
	bool closeLoginPlayer();
	bool closePlayer();

public:
	const char* toString();

public:
	CWorldDbHandler* getDbHandler();
	CWorldPlayer* getWorldPlayer();
	void setDbIndex(GXMISC::TUniqueIndex_t index);
	GXMISC::TUniqueIndex_t getDbIndex();
	void setAccountID(TAccountID_t accountID);
	TAccountID_t getAccountID();

private:
	GXMISC::TUniqueIndex_t _dbUniqueIndex;
	TAccountID_t _accountID;
	std::string _strName;

public:
	static void Setup();
	static void Unsetup();

	// 角色操作
protected:
	GXMISC::EHandleRet handleVerifyConnect(CWVerifyConnect* packet);
	GXMISC::EHandleRet handleRandRoleName(CWRandGenName* packet);
	GXMISC::EHandleRet handleCreateRole(CWCreateRole* packet);
	GXMISC::EHandleRet handleLoginGame(CWLoginGame* packet);
	GXMISC::EHandleRet handleLoginQuit(CWLoginQuit* packet);
};

#endif
