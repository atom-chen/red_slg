#ifndef _WORLD_SERVER_H_
#define _WORLD_SERVER_H_

#include <vector>
#include <list>

#include "core/service.h"
#include "core/timer.h"

#include "world_server_config.h"
#include "world_db_server_handler.h"
#include "game_struct.h"
#include "tbl_define.h"
#include "tbl_loader.h"
#include "stop_timer.h"

class CWorldServer:
	public GXMISC::GxService,
	public GXMISC::CGamePassTimerBase,
	public GXMISC::CManualSingleton<CWorldServer>
{
	typedef GXMISC::GxService					TBaseType;
public:
	CWorldServer(const std::string& serverName = "WorldServer");
	~CWorldServer();

public:
	bool					initServer( const TServerPwdInfo* pwdInfo );
	bool					initFromDb();
	void					clear();

	// 接口
public:
	CWorldServerConfig*		getConfig();

	// 网络
public:
	virtual bool			onAcceptSocket(GXMISC::CSocket* socket, GXMISC::CSocketHandler* sockHandler, GXMISC::ISocketPacketHandler* packetHandler, sint32 tag) override;
	virtual bool			onConnectSocket(GXMISC::CSocket* socket, GXMISC::CSocketHandler* sockHandler, GXMISC::ISocketPacketHandler* packetHandler, sint32 tag) override;

	// 服务
public:
	virtual void			onBreath(GXMISC::TDiffTime_t diff) override;									///< 心跳
	virtual bool			load(const std::string& serverName);											///< 加载配置
	virtual bool			init() override;																///< 初始化
	virtual void			onStat() override;																///< 统计事件
	virtual bool			onLoad(const std::string& inData, std::string& outData) override;				///< 加载事件
	virtual	bool			onAfterStart() override;														///< 服务开始后事件
	virtual void			onFirstLoop() override;															///< 第一次循环事件
	virtual void			onPassHour() override;															///< 过小时事件
	virtual void			onPassDay() override;															///< 过天

public:
	EServerStatus			getServerStatus();												///< 服务器状态
	TWorldServerID_t		getWorldServerID() const;										///< 得到服务器ID
	GXMISC::TGameTime_t		getStartTime() const;											///< 得到开启时间
	GXMISC::TGameTime_t		getFirstStartTime() const;										///< 得到第一次启动时间
	GXMISC::TGameTime_t		getOpenTime() const;											///< 得到开服时间
	const CWorldServerInfo* getServerInfo() const;											///< 得到服务器信息
	CWorldServerInfo*		getServerInfo();												///< 得到服务器信息
	CWorldDbServerHandler*	getLoginDbHandler();											///< 得到登陆数据库连接
	CWorldDbServerHandler*	getGameDbHandler();												///< 得到游戏数据库连接
	CWorldDbServerHandler*	getServerListDbHandler();										///< 得到服务器数据库连接
	CStopTimer*				getStopTimer();													///< 停服定时器

private:
	bool _initServerMgrData();																///< 初始化服务器管理数据
	bool _initSockets();																	///< 初始化所有Socket
	bool _initServerData();																	///< 初始化服务器数据
	bool _initServerConfig( const TServerPwdInfo& pwdStr );									///< 初始化服务器配置
	bool _ininServerLogicMod();																///< 初始化逻辑模块
	bool _newLoginDbHandler();																///< 新创建登陆数据库连接
	bool _newGameDbHandler();																///< 新创建游戏数据库连接
	bool _newServerListDbHandler();															///< 新创建服务器数据库连接
	bool checkTblConfig();																	///< 配置文件检测

private:
	CWorldServerConfig				_config;												///< 服务器配置
	bool							_initDataSuccess;										///< 是否成功初始化数据
	CWorldServerInfo				_serverInfo;											///< 服务器信息
	GXMISC::TGameTime_t				_serverStartTime;										///< 服务器启动时间
	CWorldDbServerHandler*			_loginDbHandler;										///< 登陆数据库连接
	CWorldDbServerHandler*			_gameDbHandler;											///< 游戏数据库连接
	CWorldDbServerHandler*			_serverListDbHandler;									///< 服务器列表连接
	TTblLoaderVec					_tblLoaders;											///< 配置文件
	CStopTimer _stopTimer;																	///< 停服定时器
};

extern CWorldServer* g_WorldServer; 
#define	DCWorldServer g_WorldServer

#endif
