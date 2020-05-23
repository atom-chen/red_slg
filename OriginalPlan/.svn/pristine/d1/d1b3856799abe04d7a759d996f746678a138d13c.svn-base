#include "core/debug.h"

#include "world_server_config.h"
#include "game_config.h"


#define DReadIniStr(str, var) \
if (!configs->readTypeIfExist(_moduleName.c_str(), str, var)) \
{ \
	gxError("Can't read {0}! ModuleName = {1}", str, _moduleName.c_str()); \
	return false; \
}

#define DReadIniStrNoErr(str, var)	\
	configs->readTypeIfExist(_moduleName.c_str(), str, var)

#define DReadIniNum(str, var) \
if (!configs->readTypeIfExist(_moduleName.c_str(), str, var)) \
{ \
	gxError("Can't read {0}! ModuleName = {1}", str, _moduleName.c_str()); \
	return false; \
}

#define DReadIniNumNoErr(str, var) \
	configs->readTypeIfExist(_moduleName.c_str(), str, var)

#define DReadIniSockAttr(str, var)	\
	{	\
	std::string	tempStr;	\
	DReadIniStrNoErr(str, tempStr);	\
	if(!tempStr.empty() && !var.parse(tempStr.c_str()))	\
		{	\
		gxError("Can't read {0}! ModuleName = {1}", str, _moduleName.c_str()); \
		return false;	\
		}	\
	}

bool CWorldServerConfig::onLoadConfig(const GXMISC::CConfigMap* configs)
{
	if (false == CGxServiceConfig::onLoadConfig(configs)) {
		gxError("Can't load CGxServiceConfig config!");
		return false;
	}

	DReadIniSockAttr("ClientListenSocket", _clientListenSocket);
	DReadIniSockAttr("SvrMgrListenSocket", _svrMgrListenSocket);
	DReadIniSockAttr("RecordeListenSocket", _recordeListenSocket);
	DReadIniSockAttr("BillListenSocket", _billListenSocket);
	DReadIniSockAttr("MapServerListenSocket", _mapServerListenSocket);
	DReadIniSockAttr("ResourceSocket", _resourceSocket);

	DReadIniSockAttr("LoginServerSocket", _loginSocket);
	DReadIniStrNoErr("ToClientIP", _toClientIP);
	DReadIniNumNoErr("ToClientPort", _toClientPort);
	DReadIniNumNoErr("ConfigRemotePath", _configRemotePath);
	DReadIniNumNoErr("WorldServerID", _serverID);
	DReadIniNumNoErr("ClientNum", _clientNum);
	DReadIniNumNoErr("LoginPlayerNum", _loginPlayerNum);
	DReadIniNumNoErr("MapServerNum", _mapServerNum);
	DReadIniStrNoErr("FilterName", _filterFileName);
	DReadIniStrNoErr("WorldDbHost", _dbHostIP);
	DReadIniNumNoErr("WorldDbPort", _dbPort);
	DReadIniStrNoErr("WorldDbName", _dbName);
	DReadIniStrNoErr("WorldDbUser", _dbUser);
	DReadIniStrNoErr("WorldDbPass", _dbPwd);
	DReadIniStrNoErr("ConfigTblPath", _configTblPath);
	DReadIniNumNoErr("PackSendHandle", g_GameConfig.packSendHandle);
	DReadIniNumNoErr("PackReadHandle", g_GameConfig.packReadHandle);	
	DReadIniStrNoErr("HttpListenIP", _httpListenIP);
	DReadIniNumNoErr("HttpListenPort", _httpListenPort);
	DReadIniNumNoErr("GmCheck", _gmCheck);
	DReadIniNumNoErr("HttpAuth", _httpCheck);

	g_GameConfig.loginPlayerNum = 50;							// 每g_GameConfig.loginPlayerInterval时间内可以登陆的玩家数
	g_GameConfig.loginPlayerInterval = 5;						// 登陆玩家间隔
	g_GameConfig.maxWServerStatTime = 10;						// 10s统计一次
	g_GameConfig.maxWorldRoleHeartOutTime = 60;					// 世界服务器角色心跳断线时间
	g_GameConfig.urlPath = "http://stest.axjh.yaowan.com/";		// 资源路径
	g_GameConfig.iniFileUncrypt = true;							// 配置文件加密

	return true;
}

const char* CWorldServerConfig::getClientListenIP() const {
	return _clientListenSocket.ip.c_str();
}

GXMISC::TPort_t CWorldServerConfig::getClientListenPort() const {
	return _clientListenSocket.port;
}

CWorldServerConfig::CWorldServerConfig(const std::string& moduleName) : CGxServiceConfig(moduleName) {
	cleanUp();
}

CWorldServerConfig::~CWorldServerConfig() {
	cleanUp();
}

void CWorldServerConfig::cleanUp()
{
	_filterFileName = "";	
	_serverID = INVALID_WORLD_SERVER_ID;	
	_clientNum = 0;
	_loginPlayerNum = 0;
	_mapServerNum = 0;
	_dbHostIP = "";
	_dbPort = 0;
	_dbName = "";
	_dbUser = "";
	_dbPwd = "";
	_configTblPath = "";
	_configRemotePath = 0;
}

TWorldServerID_t CWorldServerConfig::getWorldServerID() const {
	return _serverID;
}

const char* CWorldServerConfig::getMapListenIP()  const{
	return _mapServerListenSocket.ip.c_str();
}

GXMISC::TPort_t CWorldServerConfig::getMapListenPort() const {
	return _mapServerListenSocket.port;
}

const char* CWorldServerConfig::getRecordeServerIP() const
{
	return _recordeListenSocket.ip.c_str();
}

GXMISC::TPort_t CWorldServerConfig::getRecordeServerPort() const
{
	return _recordeListenSocket.port;
}

uint32 CWorldServerConfig::getClientNum() const
{
	return _clientNum;
}

uint32 CWorldServerConfig::getLoginPlayerNum() const
{
	return _loginPlayerNum;
}

uint32 CWorldServerConfig::getMapServerNum() const
{
	return _mapServerNum;
}

const char* CWorldServerConfig::getDbHostIP() const
{
	return _dbHostIP.c_str();
}

GXMISC::TPort_t CWorldServerConfig::getDbPort() const
{
	return _dbPort;
}

const char* CWorldServerConfig::getDbName() const
{
	return _dbName.c_str();
}

const char* CWorldServerConfig::getDbUser() const
{
	return _dbUser.c_str();
}

const char* CWorldServerConfig::getDbPwd() const
{
	return _dbPwd.c_str();
}

std::string CWorldServerConfig::getConfigTblPath() const
{
	return _configTblPath;
}

const char* CWorldServerConfig::getGmListenIP() const
{
	return _gmListenSocket.ip.c_str();
}

GXMISC::TPort_t CWorldServerConfig::getGmListenPort() const
{
	return _gmListenSocket.port;
}

const char* CWorldServerConfig::getManagerServerIP() const
{
	return _svrMgrListenSocket.ip.c_str();
}

GXMISC::TPort_t CWorldServerConfig::getManagerServerPort() const
{
	return _svrMgrListenSocket.port;
}

const std::string CWorldServerConfig::getBillListenIP() const
{ 
	return _billListenSocket.ip.toString(); 
}

GXMISC::TPort_t CWorldServerConfig::getBillListenPort() const
{ 
	return _billListenSocket.port; 
}

const char* CWorldServerConfig::getPwdIP() const
{
	return _resourceSocket.ip.c_str();
}

GXMISC::TPort_t CWorldServerConfig::getPwdPort() const
{
	return _resourceSocket.port;
}

const TSockExtAttr* CWorldServerConfig::getClientSocketAttr() const
{
	return &_clientListenSocket;
}

const TSockExtAttr* CWorldServerConfig::getMapServerSocketAttr() const
{
	return &_mapServerListenSocket;
}

const TSockExtAttr* CWorldServerConfig::getSvrMgrSocketAttr() const
{
	return &_svrMgrListenSocket;
}

const TSockExtAttr* CWorldServerConfig::getGmSocketAttr() const
{
	return &_gmListenSocket;
}

const TSockExtAttr* CWorldServerConfig::getRecordeSocketAttr() const
{
	return &_recordeListenSocket;
}

const TSockExtAttr* CWorldServerConfig::getBillSocketAttr() const
{
	return &_billListenSocket;
}

const TSockExtAttr* CWorldServerConfig::getPwdSocketAttr() const
{
	return &_resourceSocket;
}

bool CWorldServerConfig::isConfigRemotePath() const
{
	return _configRemotePath == 1;
}

const std::string& CWorldServerConfig::getToClientIP() const
{
	return _toClientIP;
}

const GXMISC::TPort_t CWorldServerConfig::getToClientPort() const
{
	return _toClientPort;
}

std::string CWorldServerConfig::getCheckTextFileName() const
{
	return _filterFileName;
}

const char* CWorldServerConfig::getLoginServerIP() const
{
	return _loginSocket.ip;
}

GXMISC::TPort_t CWorldServerConfig::getLoginServerPort() const
{
	return _loginSocket.port;
}