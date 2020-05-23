#ifndef _MAP_SERVER_BASE_H_
#define _MAP_SERVER_BASE_H_

#include <string>

#include "core/service.h"
#include "core/singleton.h"
#include "core/ini.h"
#include "core/timer.h"

#include "game_struct.h"
#include "game_define.h"
#include "tbl_loader.h"
#include "packet_mw_base.h"
//#ifdef OS_WIN
//#include "win_service.h"
//#endif

class CMapServerBase :
//#ifdef OS_WIN
//	public GameService,
//#else
	public GXMISC::GxService,
//#endif
	public GXMISC::CManualSingleton<CMapServerBase>,
	public GXMISC::CGamePassTimerBase
{
public:
	typedef GXMISC::GxService TBaseType;

public:
	CMapServerBase(const std::string& serverName = "MapServer", GXMISC::CGxServiceConfig* config = NULL);
	~CMapServerBase();

public:
	/// 初始化
	virtual bool init();

public:
	/// 获取服务器类型
	virtual EServerType getServerType(){ return INVALID_SERVER_TYPE;}
	/// 获取客户端监听IP
	virtual std::string getToClientListenIP(){ return ""; }
	/// 获取客户端监听端口
	virtual GXMISC::TPort_t getToClientListenPort(){ return 0; }
	/// 获取最大角色数目
	virtual sint32 getMaxRoleNum(){ return 0; }
	/// 获取服务器ID
	virtual TServerID_t getServerID(){ return INVALID_SERVER_ID; }
	/// 获取可以开放的最大场景数目
	virtual sint32 getScenePoolNum(){ return 0;}
	/// 获取地图列表
	virtual const TMapIDList getMapIDs() const { return TMapIDList(); }

private:
	/// 更新到世界服务器
	void updateToWorld();

private:
	/// 服务器的初始化，整个初始化是同步的
	bool initServer(const TServerPwdInfo& pwdInfo);

protected:	
	/// 服务器开始初始化
	virtual bool onBeforeInitServer(){ return false; }						
	/// 加载配置
	virtual bool onLoadTblConfig(CCconfigLoaderParam& configLoaderParam);	
	/// 开启Socket
	virtual bool onInitSocket(){ return false; }			
	/// 初始化服务器的内存数据, 包括管理器及各个管理器之间的数据校验等
	virtual bool onInitServerData(){ return false; }						
	/// 从数据库加载一些同步的初始化数据完成整个服务器的初始化
	virtual bool onInitServerDbData();						
	/// 服务器初始化结束
	virtual bool onAfterInitServer(){ return false; }						

public:
	/// 帧更新
	virtual void onBreath(GXMISC::TDiffTime_t diff) override;
	/// 启动后事件
	virtual bool onAfterStart();
	/// 加载事件
	virtual bool onLoad(GXMISC::CIni* iniFile, const std::string& fileName);

public:
	/// 向世界服务器注册成功
	virtual void onRegisteToWorld(TServerID_t serverID);
	/// 世界服务器信息
	virtual void onWorldServerInfo( WMServerInfo* packet );

public:
	/// 是否动态服务器
	virtual bool isDynamicServer()const { return false; }
	/// 是否可以打开动态地图
	virtual bool canOpenDynamicMap() const{return false;}
	/// 是否远程配置
	virtual bool isConfigRemotePath() const{ return false; }

private:
	bool _initServerConfig( const TServerPwdInfo& pwdInfo );
	void _initFromDb();
};

#endif	// _MAP_SERVER_BASE_H_