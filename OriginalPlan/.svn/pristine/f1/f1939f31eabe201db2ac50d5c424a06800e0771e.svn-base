#ifndef _MAP_PLAYER_HANDLER_H_
#define _MAP_PLAYER_HANDLER_H_

#include "map_player_handler_base.h"
#include "game_player_mgr.h"

#include "packet_cm_login.h"
#include "packet_cm_base.h"
#include "packet_cm_mission.h"
#include "packet_cm_bag.h"

class CRole;
class CMapPlayerHandler : public CMapPlayerHandlerBase
{
	typedef CMapPlayerHandlerBase TBaseType;

public:
	CMapPlayerHandler(){}
	~CMapPlayerHandler(){}

public:
	// 启动
	virtual bool start();

public:
	// 设置注册
	static void Setup();
	// 取消注册
	static void Unsetup();

public:
	// 初始化脚本对象
	virtual bool initScriptObject(GXMISC::CLuaVM* scriptEngine) override;

	// 登陆模块
public:
	// 本地登陆
	GXMISC::EHandleRet handleLocalLogin(CMLocalLoginGame* packet);
	// 本地登陆
	GXMISC::EHandleRet handleLocalLoginAccount(CMLocalLoginGameAccount* packet);
	// 注册
	//GXMISC::EHandleRet handleRegister(CMGameRegister* packet);
	// 进入游戏
	GXMISC::EHandleRet handleEnterGame(CMEnterGame* packet);

protected:
	// 进入前事件
	bool enterBefore(CRole* pRole);
	// 进入后事件
	void enterAfter(CRole* pRole);

	/// 切换场景及切线
public:
	// 进入场景
	GXMISC::EHandleRet handleEnterScene(CMEnterScene* packet);
	// 传送点
	GXMISC::EHandleRet handleTransmite(CMTransmite* packet);

	// 基础模块
public:
	// 聊天消息
	GXMISC::EHandleRet handleChat(CMChat* packet);
	// 重命名角色名字
	GXMISC::EHandleRet handleRename(CMRenameRoleName* packet);
	// 随机角色名字
	GXMISC::EHandleRet handleRandRoleName(CMRandRoleName* packet);
	// 移动
	GXMISC::EHandleRet handleMove(CMMove* packet);
	// 跳跃
	GXMISC::EHandleRet handleJump(CMJump* packet);
	// 掉落
	GXMISC::EHandleRet handleDrop(CMDrop* packet);
	// 着陆
	GXMISC::EHandleRet handleLand(CMLand* packet);

	// 任务
public:
	// 任务操作
	GXMISC::EHandleRet handleMissionOperate(CMMissionOperate* packet);

	// 其他功能
public:
//	GXMISC::EHandleRet handleExchangeGiftReq( const CMExchangeGiftReq* packet );

private:
	// 获取玩家对象
	CRole* getRole(EManagerQueType queType = MGR_QUE_TYPE_ENTER);
};

#endif	// _MAP_PLAYER_HANDLER_H_