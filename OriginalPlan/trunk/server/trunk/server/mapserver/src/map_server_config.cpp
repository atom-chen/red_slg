#include "core/string_parse.h"

#include "game_util.h"
#include "game_define.h"
#include "game_config.h"

#include "map_server_config.h"
#include "map_server_data.h"

#define DReadIniStr(str, var) \
if (!configs->readTypeIfExist(_moduleName.c_str(), str, var)) \
{ \
	gxError("Can't read {0}! ModuleName = {1}", str, _moduleName.c_str()); \
	return false; \
}

#define DReadIniNum(str, var) \
if (!configs->readTypeIfExist(_moduleName.c_str(), str, var)) \
{ \
	gxError("Can't read {0}! ModuleName = {1}", str, _moduleName.c_str()); \
	return false; \
}

#define DReadIniBoolean(str, var) \
	sint32 vv = -1;	\
if (!configs->readTypeIfExist(_moduleName.c_str(), str, vv)) \
{ \
	gxError("Can't read {0}! ModuleName = {1}", str, _moduleName.c_str()); \
	return false; \
} \
	var = vv;

#define DReadIniSockAttr(str, var)	\
	{	\
	std::string	tempStr;	\
	DReadIniStr(str, tempStr);	\
	if(!var.parse(tempStr.c_str()))	\
		{	\
		gxError("Can't read {0}! ModuleName = {1}", str, _moduleName.c_str()); \
		return false;	\
		}	\
	}

CGameConfig g_GameConfig;

bool CMapServerConfig::onLoadConfig(const GXMISC::CConfigMap* configs)
{
	if (false == CGxServiceConfig::onLoadConfig(configs))
	{
		gxError("Can't load CGxServiceConfig config!");
		return false;
	} 

	// 场景
	std::string scensStr;
	if (!configs->readTypeIfExist(_moduleName.c_str(), "Scenes", scensStr))
	{
		gxWarning("Can't read map, will load all maps! ModuleName = {0}", _moduleName.c_str());
	}
	GXMISC::CStringParse<TMapID_t> parse(",");
	parse.parse(scensStr);
	_mapIDs = parse.getValueList();

	// 配置文件是否远程路径
	configs->readTypeIfExist(_moduleName.c_str(), "ConfigRemotePath", _configRemotePath);

	DReadIniSockAttr("ClientListenSock", _clientListenSock);
	DReadIniSockAttr("RecordListenSock", _recordeSock);
	DReadIniSockAttr("WorldSock", _worldSock);
	DReadIniSockAttr("ServerManagerSock", _svrMgrSock);
	DReadIniSockAttr("ResourceSocket", _resourceSock);

	DReadIniStr("ToClientListenIP", _toClientListenIP);
	DReadIniNum("ToClientListenPort", _toClientListenPort);
	DReadIniStr("HttpListenIP", _httpListenIP);
	DReadIniNum("HttpListenPort", _httpListenPort);
	DReadIniNum("MapServerID", _serverID);
	DReadIniNum("MapServerType", _serveType);
	DReadIniNum("OpenRecordeServer", _openRecordeServer);
	DReadIniNum("RolePoolNum", _rolePoolNum);
	DReadIniNum("ConfigTblPath", _configTblPath);
	DReadIniNum("ProfileFrame", _profileFrame);
	DReadIniNum("MapDataPath", _mapDataPath);
	DReadIniNum("RiskSceneNum", _riskSceneNum);
	DReadIniNum("GmCheck", _isGmCheck);
	DReadIniNum("GmLog", _isGmLog);
	DReadIniBoolean("HttpAuth", _httpCheck);
	DReadIniStr("FilterName", _filterFileName);
	DReadIniNum("ViewBlockRange", g_GameConfig.blockSize);
	DReadIniNum("PackSendHandle", g_GameConfig.packSendHandle);
	DReadIniNum("PackReadHandle", g_GameConfig.packReadHandle);

	// 全局配置
	g_GameConfig.urlPath = "http://stest.axjh.yaowan.com/";		// 远程配置目录
	g_GameConfig.maxSceneRoleNum = 1024;						// 一个场景中的最大角色数目
	g_GameConfig.maxWorldRoleHeartOutTime = 60;					// 世界服务器角色心跳断线时间
	g_GameConfig.monDamageCheckTime = 2;						// 怪物伤害检测间隔
	g_GameConfig.monRandMoveTime = 10;							// 怪物随机移动时间
	g_GameConfig.maxMonRandMoveRange = 10;						// 怪物随机移动范围
	g_GameConfig.useAssistSkillAddHate = 20;					// 使用辅助技能增加的仇恨值
	g_GameConfig.skillAttackBackRange = 5;						// 技能击退的距离
	g_GameConfig.broadcastRange = 2;							// 广播范围
	g_GameConfig.maxMonApproachDis = 20;						// 怪物超过多远不再追击
	g_GameConfig.randKillRoleStateTime = 3;						// 乱杀的持续时间

	setRecordeSize();

	onAfterLoad();

	return true;
}

bool CMapServerConfig::getOpenGmCheck() const
{
	return _isGmCheck == 1;
}


bool CMapServerConfig::getOpenGmLog() const
{
	return _isGmLog == 1;
}

const std::string CMapServerConfig::getClientListenIP() const
{
	return _clientListenSock.ip.toString();
}

GXMISC::TPort_t CMapServerConfig::getClientListenPort() const
{
	return _clientListenSock.port;
}

CMapServerConfig::CMapServerConfig( const std::string& moduleName ) : CGxServiceConfig(moduleName)
{
	_configRemotePath = 0;
}

CMapServerConfig::~CMapServerConfig()
{

}

TServerID_t CMapServerConfig::getMapServerID() const
{
	return _serverID;
}

EServerType CMapServerConfig::getMapServerType() const
{
	return (EServerType)_serveType;
}

const std::string CMapServerConfig::getWorldServerIP() const
{
	return _worldSock.ip.toString();
}

uint16 CMapServerConfig::getWorldServerPort() const
{
	return _worldSock.port;
}

const std::string CMapServerConfig::getRecordeServerIP() const
{
	return _recordeSock.ip.toString();
}

GXMISC::TPort_t CMapServerConfig::getRecordeServerPort() const
{
	return _recordeSock.port;
}

const std::string CMapServerConfig::getManagerServerIP() const
{
	return _svrMgrSock.ip.toString();
}

GXMISC::TPort_t CMapServerConfig::getManagerServerPort() const
{
	return _svrMgrSock.port;
}

uint8 CMapServerConfig::getOpenRecordeServer() const
{
	return _openRecordeServer;
}

const TMapIDList CMapServerConfig::getMapIDs() const
{
	return _mapIDs;
}

sint32 CMapServerConfig::getRolePoolNum() const
{
	return _rolePoolNum;
}

std::string CMapServerConfig::getConfigTblPath() const
{
	return _configTblPath;
}

uint8 CMapServerConfig::getProfileFrame() const
{
	return _profileFrame;
}

const std::string CMapServerConfig::getMapDataPath() const
{
	return _mapDataPath;
}

bool CMapServerConfig::check()
{
	if(false == CGxServiceConfig::check())
	{
		gxError("Can't pass check!");
		return false;
	}

	return true;
}

const std::string CMapServerConfig::getToClientListenIP() const
{
	return _toClientListenIP;
}

GXMISC::TPort_t CMapServerConfig::getToClientListenPort() const
{
	return _toClientListenPort;
}

const std::string CMapServerConfig::getResourceServerIP() const
{
	return _resourceSock.ip.toString();
}

GXMISC::TPort_t CMapServerConfig::getResourceServerPort() const
{
	return _resourceSock.port;
}

uint8 CMapServerConfig::getRiskSceneNum() const
{
	return _riskSceneNum;
}

void CMapServerConfig::onAfterLoad()
{
}

uint32 CMapServerConfig::getScenePoolNum( sint32 sceneType /* = MAP_SERVER_TYPE_NORMAL */, sint32 pkType /* = 0 */ ) const
{
	if(_serveType == SERVER_TYPE_MAP_NORMAL)
	{
		return (uint32)_mapIDs.size();
	}
	else if(_serveType == SERVER_TYPE_MAP_DYNAMIC )
	{
		return _riskSceneNum;
	}

	return 0;
}

bool CMapServerConfig::isDynamicMapServer() const
{
	return _serveType == SERVER_TYPE_MAP_DYNAMIC;
}

const TSockExtAttr* CMapServerConfig::getClientListenSocketAttr() const
{
	return &_clientListenSock;
}

const TSockExtAttr* CMapServerConfig::getWorldSvrSocketAttr() const
{
	return &_worldSock;
}

const TSockExtAttr* CMapServerConfig::getRecordeSvrSocketAttr() const
{
	return &_recordeSock;
}

const TSockExtAttr* CMapServerConfig::getManagerSvrSocketAttr() const
{
	return &_svrMgrSock;
}

const TSockExtAttr* CMapServerConfig::getResourceSvrSocketAttr() const
{
	return &_resourceSock;
}

const TSockExtAttr* CMapServerConfig::getGmListenSocketAttr() const
{
	return &_gmListenSock;
}

void CMapServerConfig::setFrameNum( sint32 num )
{
	_frameNum = num;
}

const std::string CMapServerConfig::getGmListenIP() const
{
	return _gmListenSock.ip.toString();
}

GXMISC::TPort_t CMapServerConfig::getGmListenPort() const
{
	return _gmListenSock.port;
}

bool CMapServerConfig::isConfigRemotePath() const
{
	return _configRemotePath == 1;
}

std::string CMapServerConfig::getCheckTextFileName() const
{
	return _filterFileName;
}

const std::string CMapServerConfig::getHttpListenIP() const
{
	return _httpListenIP;
}

GXMISC::TPort_t CMapServerConfig::getHttpListenPort() const
{
	return _httpListenPort;
}

void CMapServerConfig::setRecordeSize()
{
}
