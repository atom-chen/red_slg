#ifndef _MAP_SERVER_CONFIG_H_
#define _MAP_SERVER_CONFIG_H_

#include <set>

#include "core/ini.h"
#include "core/service.h"

#include "game_util.h"
#include "game_struct.h"
#include "game_define.h"
#include "socket_attr.h"
#include "game_config.h"

class CMapServer;
class CMapServerConfig 
	: public GXMISC::CGxServiceConfig
{
public:
	CMapServerConfig(const std::string& moduleName);
	~CMapServerConfig();

public:
	virtual bool onLoadConfig(const GXMISC::CConfigMap* configs) override;
	virtual bool check();

	void onAfterLoad();

public:
	void setFrameNum(sint32 num);
	void setRecordeSize();

public:
	const std::string		getClientListenIP()				const; 
	uint16          		getClientListenPort()			const; 
	const std::string     	getWorldServerIP()				const; 
	GXMISC::TPort_t         getWorldServerPort()			const; 
	const std::string		getRecordeServerIP()			const; 
	GXMISC::TPort_t			getRecordeServerPort()			const; 
	const std::string		getManagerServerIP()			const; 
	GXMISC::TPort_t			getManagerServerPort()			const; 
	const std::string		getGmListenIP()					const; 
	GXMISC::TPort_t			getGmListenPort()				const; 
	const std::string		getToClientListenIP()			const; 
	GXMISC::TPort_t			getToClientListenPort()			const; 
	const std::string		getResourceServerIP()			const; 
	GXMISC::TPort_t			getResourceServerPort()			const; 
	const std::string		getHttpListenIP()				const; 
	GXMISC::TPort_t			getHttpListenPort()				const; 

	const TSockExtAttr*		getClientListenSocketAttr()		const; 
	const TSockExtAttr*		getGmListenSocketAttr()			const; 
	const TSockExtAttr*		getWorldSvrSocketAttr()			const; 
	const TSockExtAttr*		getRecordeSvrSocketAttr()		const; 
	const TSockExtAttr*		getManagerSvrSocketAttr()		const; 
	const TSockExtAttr*		getResourceSvrSocketAttr()		const; 

	bool					getOpenGmCheck()				const; 
	bool					getOpenGmLog()					const; 
	uint8					getOpenRecordeServer()			const; 
	TServerID_t  			getMapServerID()				const; 
	EServerType  			getMapServerType()				const; 
	const TMapIDList		getMapIDs()						const; 
	sint32          		getRolePoolNum()				const; 
	std::string     		getConfigTblPath()				const; 
	uint8           		getProfileFrame()				const; 
	const std::string		getMapDataPath()				const; 
	uint8           		getRiskSceneNum()				const; 
	uint32          		getScenePoolNum( sint32 serverType = SERVER_TYPE_MAP_NORMAL, sint32 pkType = 0 )	const;
	bool					isDynamicMapServer()			const; 
	bool					isConfigRemotePath()			const; 

	std::string             getCheckTextFileName()          const; 
	bool getHttpCheck() const { return _httpCheck; }		
	void setHttpCheck(bool val) { _httpCheck = val; }		
private:
	TSockExtAttr			_clientListenSock;		// 客户端监听Socket
	TSockExtAttr			_worldSock;				// 世界Socket
	TSockExtAttr			_recordeSock;			// 日志Socket
	TSockExtAttr			_svrMgrSock;			// 管理Socket
	TSockExtAttr			_gmListenSock;			// GM管理监听
	TSockExtAttr			_resourceSock;			// 资源管理服务器

	std::string				_httpListenIP;			// http监听IP
	GXMISC::TPort_t			_httpListenPort;		// http监听端口
	std::string				_toClientListenIP;		// 对外开放的客户端监听IP
	GXMISC::TPort_t			_toClientListenPort;	// 对外开放的客户端监听端口

	uint8					_openRecordeServer;		// 是否开启日志服务器
	TServerID_t      		_serverID;				// 服务器ID
	sint32              	_serveType;             // 服务器类型
	TMapIDList          	_mapIDs;				// 启动的地图
	uint32              	_rolePoolNum;			// 最大角色数
	std::string         	_configTblPath;			// 配置目录
	uint8               	_profileFrame;          // 是否计算帧率
	std::string				_mapDataPath;			// 地图路径
	uint8               	_riskSceneNum;          // 最大可开启的副本数
	uint8					_isGmCheck;				// 开启GM权限检测
	uint8					_isGmLog;				// 开启GM日志
	uint8					_configRemotePath;		// 配置文件是否远程路径
	bool					_httpCheck;				// Http命令检测
	std::string             _filterFileName;	    // 过滤字文件
};

#endif