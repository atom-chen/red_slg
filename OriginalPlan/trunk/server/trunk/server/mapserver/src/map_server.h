#ifndef _MAP_SERVER_H_
#define _MAP_SERVER_H_

#include <string>

#include "map_server_base.h"
#include "map_server_config.h"
#include "announcement_sys.h"
#include "stop_timer.h"
#include "core/script/script_lua_inc.h"
#include "script_engine.h"

class CMapServer : public CMapServerBase
{
protected:
	typedef CMapServerBase TBaseType;
	DSingletonImpl();
public:
	CMapServer(const std::string& serverName = "MapServer");
	~CMapServer();

public:
	static void InitStaticInstanace(CScriptEngine::TScriptState* L = NULL);

public:
	virtual bool init()override;

protected:
	void doTest();

public:
	virtual const TMapIDList getMapIDs() const override;
	virtual EServerType getServerType() override;
	virtual sint32 getMaxRoleNum() override;
	virtual TServerID_t getServerID() override;
	virtual std::string getToClientListenIP() override;
	virtual GXMISC::TPort_t getToClientListenPort() override;

protected:
	virtual void onBreath(GXMISC::TDiffTime_t diff) override;
	virtual void onIdle() override;
	virtual void onTimer();
	virtual void onLoopBefore() override;
	virtual void onLoopAfter() override;
	virtual bool onAfterStart() override;
	virtual bool onAfterLoad() override;
	virtual	void onPassMonth() override;			// 过月
	virtual	void onPassWeekday()override;			// 过星期
	virtual void onPassDay()override;				// 过天
	virtual void onPassHour()override;				// 过小时
	virtual bool OnCommand(char* szCmd);

	// Socket建立事件
	virtual bool onAcceptSocket(GXMISC::CSocket* socket, GXMISC::CSocketHandler* sockHandler, GXMISC::ISocketPacketHandler* packetHandler, sint32 tag)override;
	virtual bool onConnectSocket(GXMISC::CSocket* socket, GXMISC::CSocketHandler* sockHandler, GXMISC::ISocketPacketHandler* packetHandler, sint32 tag)override;
	virtual void onStat()override;

public:
	const CMapServerConfig* getServerConfig() const;							///< 得到服务器配置 
	bool isGmLog();																///< 是否显示GM日志
	GXMISC::TGameTime_t	getFirstStartTime() const;								///< 得到第一次启动时间
	GXMISC::TGameTime_t	getOpenTime() const;									///< 得到开服时间
	virtual void onRegisteToWorld(TServerID_t serverID);						///< 向世界服务器注册成功
	virtual void onWorldServerInfo(WMServerInfo* packet);						///< 世界服务器信息更新
	CStopTimer* getStopTimer() { return &_stopTimer; }							///< 停止定时器 

public:
	virtual bool canOpenDynamicMap() const;										///< 是否能够打开动态地图
	virtual bool isDynamicServer() const;										///< 是否动态副本服务器
	virtual bool isConfigRemotePath() const;									///< 是否远程加载配置

public:
	void addManagerBoard(std::string msg, sint32 interval);						///< 添加后台管理公告 
	void addManagerBoard(std::string msg, sint32 lastTime, sint32 interval);	///< 添加后台管理公告 

protected:	
	virtual bool onBeforeInitServer();											///< 服务器开始初始化
	virtual bool onLoadTblConfig(CCconfigLoaderParam& configLoaderParam);		///< 加载表格配置文件
	virtual bool onInitSocket();												///< 开启Socket
	virtual bool onInitServerData();											///< 初始化服务器的内存数据, 包括管理器及各个管理器之间的数据校验等
	virtual bool onAfterInitServer();											///< 服务器初始化结束
	virtual bool onInitServerDbData();											///< 初始化服务器DB数据

private:
	bool addNpcToMap();								///< 添加NPC到地图
	bool addTransportToMap();						///< 添加传送门到地图
	bool checkTblConfig();							///< 检查配置
	void addSysBroad();								///< 添加系统广播
	void updateBroad(GXMISC::TDiffTime_t diff);		///< 更新系统广播

private:
	TTblLoaderVec _tblLoaders;													///< 所有加载的配置表对象
	CAnnouncementSysManager _announcementSysMgr;								///< 系统公告管理
	CStopTimer _stopTimer;														///< 停止服务器定时器
	CMapServerConfig _config;													///< 配置文件
	GXMISC::CManualIntervalTimer _timer;										///< 定时器
};

#endif