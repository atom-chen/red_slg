#ifndef _MAP_DB_SERVER_HANDLER_H_
#define _MAP_DB_SERVER_HANDLER_H_

#include "game_database_handler.h"
#include "base_util.h"

class CMapDbServerHandler : public CGameDatabaseHandler
{
public:
	typedef CGameDatabaseHandler TBaseType;

public:
    CMapDbServerHandler(GXMISC::CDatabaseConnWrap* dbWrap = NULL, GXMISC::TUniqueIndex_t index = GXMISC::INVALID_UNIQUE_INDEX) 
        : CGameDatabaseHandler(dbWrap, index) {}
    ~CMapDbServerHandler(){}

public:
    // 连接建立
    virtual bool start();
    // 消息处理
    virtual GXMISC::EHandleRet handle(char* msg, uint32 len);
    // 连接关闭
    virtual void close(){};
    // 定时更新
    virtual void breath(GXMISC::TDiffTime_t diff){ TBaseType::breath(diff); };

public:
	/// 保存服务器数据
	void sendSaveMapServerDataTask();
	/// 玩家注册
	void sendPlayerRegiste(std::string account, std::string passwd, GXMISC::TSocketIndex_t socketIndex);
private:
    bool sendServerInitTask();
};

#endif