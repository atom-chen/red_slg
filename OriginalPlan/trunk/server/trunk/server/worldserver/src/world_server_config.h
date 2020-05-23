#ifndef _WORLD_SERVER_CONFIG_H_
#define _WORLD_SERVER_CONFIG_H_

#include "core/ini.h"
#include "core/service.h"

#include "socket_attr.h"
#include "game_util.h"

enum ESocketTag
{
	SOCKET_TAG_WML,		// 地图服务器监听
	SOCKET_TAG_WCL,		// 客户端监听
	SOCKET_TAG_WMC,		// 管理器服务器连接
	SOCKET_TAG_WGML,	// GM监听
	SOCKET_TAG_WRL,		// 日志服务器连接
	SOCKET_TAG_WBC,		// 充值服务器连接
	SOCKET_TAG_WDC,		// 资源服务器连接
	SOCKET_TAG_WLC,		// 登陆服务器
	SOCKET_TAG_WHL,		// HTTP监听
};

typedef GXMISC::TPort_t TPort_t;
class CWorldServerConfig // @sc
	: public GXMISC::CGxServiceConfig
{
public:
	CWorldServerConfig(const std::string& moduleName);
	~CWorldServerConfig();

public:
	virtual bool onLoadConfig(const GXMISC::CConfigMap* configs) override;

private:
	void cleanUp();

public:
	const TSockExtAttr* getClientSocketAttr() const;
	const TSockExtAttr* getMapServerSocketAttr() const;
	const TSockExtAttr* getSvrMgrSocketAttr() const;
	const TSockExtAttr* getGmSocketAttr() const;
	const TSockExtAttr* getRecordeSocketAttr() const;
	const TSockExtAttr* getBillSocketAttr() const;
	const TSockExtAttr*	getPwdSocketAttr() const;

public:
	const std::string& getToClientIP() const; // @sf
	const TPort_t getToClientPort() const; // @sf
	const char* getClientListenIP() const; // @sf
	TPort_t getClientListenPort() const; // @sf
	const char* getLoginServerIP() const; // @sf
	TPort_t getLoginServerPort() const; // @sf
	const char* getMapListenIP() const; // @sf
	TPort_t getMapListenPort() const; // @sf
	const char* getRecordeServerIP() const; // @sf
	TPort_t getRecordeServerPort() const; // @sf
	const char* getGmListenIP() const; // @sf
	TPort_t getGmListenPort() const; // @sf
	const char* getManagerServerIP() const; // @sf
	TPort_t getManagerServerPort() const; // @sf
	const std::string getBillListenIP() const; // @sf
	TPort_t getBillListenPort() const; // @sf
	const char* getPwdIP() const; // @sf
	TPort_t	getPwdPort() const; // @sf
	TWorldServerID_t getWorldServerID() const; // @sf
	uint32 getClientNum() const; // @sf
	uint32 getLoginPlayerNum() const; // @sf
	uint32 getMapServerNum() const; // @sf
	std::string getCheckTextFileName() const; // @sf
	const char* getDbHostIP() const; // @sf
	TPort_t	getDbPort() const; // @sf
	const char* getDbName() const; // @sf
	const char* getDbUser() const; // @sf
	const char* getDbPwd() const; // @sf
	std::string getConfigTblPath() const; // @sf
	bool isConfigRemotePath() const; // @sf
	std::string getHttpListenIP() const { return _httpListenIP; } // @sf
	void setHttpListenIP(std::string val) { _httpListenIP = val; } // @sf
	GXMISC::TPort_t getHttpListenPort() const { return _httpListenPort; } // @sf
	void setHttpListenPort(GXMISC::TPort_t val) { _httpListenPort = val; } // @sf
	bool getGmCheck() const { return _gmCheck; } // @sf
	void setGmCheck(bool val) { _gmCheck = val; } // @sf
	bool getHttpCheck() const { return _httpCheck; } // @sf
	void setHttpCheck(bool val) { _httpCheck = val; } // @sf

private:
	TSockExtAttr _clientListenSocket;		// 客户端监听端口
	TSockExtAttr _svrMgrListenSocket;		// 管理服务器监听端口
	TSockExtAttr _billListenSocket;			// 充值服务器监听端口
	TSockExtAttr _recordeListenSocket;		// 日志服务器端口
	TSockExtAttr _gmListenSocket;			// GM监听服务器端口
	TSockExtAttr _mapServerListenSocket;	// 场景服务器监听端口
	TSockExtAttr _resourceSocket;			// 资源服务器端口
	TSockExtAttr _loginSocket;				// 登陆服务器端口
	std::string _toClientIP;				// 对客户端开放的IP
	GXMISC::TPort_t _toClientPort;			// 对客户端开放的端口
	std::string		_httpListenIP;			// http监听IP
	GXMISC::TPort_t	_httpListenPort;		// http监听端口
	std::string _filterFileName;			// 过滤字文件
	TWorldServerID_t _serverID;				// 服务器ID
	uint32 _clientNum;						// 玩家数目
	uint32 _loginPlayerNum;					// 排队玩家数目
	uint32 _mapServerNum;					// 场景服务器个数
	std::string	_dbHostIP;					// 数据库IP
	GXMISC::TPort_t	_dbPort;				// 数据库端口
	std::string	_dbName;					// 数据库名字
	std::string	_dbUser;					// 数据库用户
	std::string	_dbPwd;						// 数据库密码
	std::string _configTblPath;				// 配置目录
	uint32 _configRemotePath;				// 配置是否远程地址
	bool _gmCheck;							// GM命令检测
	bool _httpCheck;						// Http命令检测
};

class CWorldServerInfo{
public:
	CWorldServerInfo(){
		_firstStartTime = 0;
		_openTime = 0;
	}
	~CWorldServerInfo(){

	}
public:
	GXMISC::TGameTime_t getFirstStartTime() const { return _firstStartTime; }
	void setFirstStartTime(GXMISC::TGameTime_t val) { _firstStartTime = val; }
	GXMISC::TGameTime_t getOpenTime() const { return _openTime; }
	void setOpenTime(GXMISC::TGameTime_t val) { _openTime = val; }

private:
	GXMISC::TGameTime_t _firstStartTime;
	GXMISC::TGameTime_t _openTime;
};
static const sint32 FlashPolicydPort=843;

#endif
