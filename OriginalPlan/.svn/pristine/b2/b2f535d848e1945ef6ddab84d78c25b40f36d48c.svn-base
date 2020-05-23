#ifndef _WORLD_DB_SERVER_HANDLER_H_
#define _WORLD_DB_SERVER_HANDLER_H_

#include "game_database_handler.h"
#include "world_server_util.h"
#include "game_time.h"
#include "packet_struct.h"

class CWorldDbServerHandler : public CGameDatabaseHandler
{
public:
	CWorldDbServerHandler(GXMISC::CDatabaseConnWrap* dbWrap = NULL,
		GXMISC::TUniqueIndex_t index = GXMISC::INVALID_UNIQUE_INDEX) :
	CGameDatabaseHandler(dbWrap, index) 
	{
	}
	~CWorldDbServerHandler() 
	{
	}

public:
	// 连接建立
	virtual bool start();
	// 消息处理
	virtual GXMISC::EHandleRet handle(char* msg, uint32 len);
	// 连接关闭
	virtual void close() {}
	// 定时更新
	virtual void breath(GXMISC::TDiffTime_t diff) {}

public:
	// 加载游戏初始化数据
	bool sendGameInitTask();
	// 服务器初始化数据
	bool sendServerInitTask();
	// 加载玩家数据
	bool sendLoadUserData( TRoleUID_t roleUID );
	// 加载登陆服务器IP列表
//	bool sendLoadLoginServers();

	// ===============扩展功能===============
public:
};

CWorldDbServerHandler* GetWorldLoginDbHandler();		// 账号数据库
CWorldDbServerHandler* GetWorldGameDbHandler();			// 游戏数据库
CWorldDbServerHandler* GetWorldServerListDbHandler();	// 所有区服数据库


#endif
