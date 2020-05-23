#include "core/game_exception.h"

#include "world_server.h"
#include "game_rand.h"
#include "tbl_loader.h"
#include "game_config.h"
#include "gm_log.h"
#include "stat_log.h"
#include "error_log.h"
#include "module_def.h"
#include "crypt_util.h"
#include "game_socket_packet_handler.h"
#include "world_player_handler.h"
#include "world_map_server_handler.h"
#include "game_server_socket_packet_handler.h"
#include "world_map_player_mgr.h"
#include "world_player_mgr.h"

#include "new_role_tbl.h"
#include "world_all_user.h"
#include "dirty_word_filter.h"
#include "rand_name_tbl.h"
#include "world_login_player_mgr.h"
#include "world_user_mgr.h"
#include "world_db_server_handler.h"
#include "db_name_define.h"
#include "scene_manager.h"
#include "map_manager.h"
#include "constant_define.h"
#include "world_sql_manager.h"
#include "constant_tbl.h"
#include "world_login_server_handler.h"

#include "world_script_engine.h"
#include "world_manager_server_handler.h"
#include "world_charging_server_handler.h"
#include "http_default_handler.h"
#include "socket_packet_handler.h"

#include "core/time/date_time.h"
#include "../../core/core/src/file_system_util.h"

CWorldServer* g_WorldServer;
GXMISC::CDatabaseConnMgr *g_WorldDbMgr = NULL;
GXMISC::CNetModule *g_WorldNetMgr = NULL;

CWorldServer::CWorldServer(const std::string& serverName) 
	: GXMISC::GxService(&_config, serverName), _config(serverName)
{
	g_WorldServer = this;
	g_WorldDbMgr = getDbMgr();
	g_WorldNetMgr = getNetMgr();

	CWorldPlayerHandler::Setup();
	CWorldMapServerHandler::Setup();
	CGameSocketPacketHandler::Setup();
	CWorldLoginServerHandler::Setup();
	CWorldManagerServerHandler::Setup();
	CWorldChargingServerHandler::Setup();

	initTimer(DTimeManager.nowSysTime());

	clear();

	setMainScriptName("script/MapServiceMainScript.lua");
	setNewServiceFunctionName("NewMainServer");
}

CWorldServer::~CWorldServer()
{
	clear();
}

bool CWorldServer::load(const std::string& serverName)
{
	DIFFALSE(TBaseType::load(serverName));

	std::string fileName = "WorldServerRemote.ini";
// 	std::string fileData;
// 	if (!GXMISC::MyReadStringFile(fileName, fileData))
// 	{
// 		gxError("Can't read config file!FileName={0}", fileName);
// 		return false;
// 	}
// 
// 	DIFFALSE(TBaseType::addLoad(serverName));
	TBaseType::addLoad(fileName);
	gxInfo("Add load config success!FileName={0}", fileName);

	return true;
}

bool CWorldServer::init()
{
	if(!TBaseType::init())
	{
		return false;
	}

	addLogger(new CErrorFileLog(false, (getModuleName()+"Err").c_str()));
	addLogger(new CStatFileLog(false, (getModuleName()+"Stat").c_str()));
	addLogger(new CGmFileLog(false, (getModuleName()+"GM").c_str()));

	return true;
}

void CWorldServer::onBreath(GXMISC::TDiffTime_t diff)
{
	TBaseType::onBreath(diff);

	DLoginPlayerMgr.update(diff);
	DWorldPlayerMgr.update(diff);
	DWorldServerData.update(diff);

	updateTimer(diff);
	_stopTimer.update(diff);
}

bool CWorldServer::onAcceptSocket( GXMISC::CSocket* socket, GXMISC::CSocketHandler* sockHandler, GXMISC::ISocketPacketHandler* packetHandler, sint32 tag )
{
	TBaseType::onAcceptSocket(socket, sockHandler, packetHandler, tag);
	TSockExtAttr attrs;
	gxInfo("Client connect!IP={0},Port={1}, RemoteIP={2},RemotePort={3}", sockHandler->getLocalIp(), sockHandler->getLocalPort(), 
		sockHandler->getRemoteIp(), sockHandler->getRemotePort());
	switch(tag)
	{
	case SOCKET_TAG_WCL:
		{
			CGameSocketPacketHandler* pHandler = dynamic_cast<CGameSocketPacketHandler*>(packetHandler);
			if(NULL == pHandler)
			{
				return false;
			}
			attrs = *_config.getClientSocketAttr();
			pHandler->setAttr(&attrs);
			if(g_GameConfig.maxSocketHandlerPackNumPerSec > 0)
			{
				pHandler->setUnpacketNum(g_GameConfig.maxSocketHandlerPackNumPerSec);
			}
		}break;
	case SOCKET_TAG_WML:
		{
			CGameServerSocketPacketHandler* pHandler = dynamic_cast<CGameServerSocketPacketHandler*>(packetHandler);
			if(NULL == pHandler)
			{
				return false;
			}
			attrs = *_config.getMapServerSocketAttr();
			pHandler->setAttr(&attrs);
		}break;
	case SOCKET_TAG_WHL:
		{
			CHttpDefaultHandler* pHttpHandler = (CHttpDefaultHandler*)sockHandler;
			pHttpHandler->setScriptEngine(CWorldScriptEngine::GetPtrInstance());
		}break;
	default:
		{
			return false;
		}break;
	}


	return true;
}

bool CWorldServer::onConnectSocket( GXMISC::CSocket* socket, GXMISC::CSocketHandler* sockHandler, GXMISC::ISocketPacketHandler* packetHandler, sint32 tag )
{
	FUNC_BEGIN(WORLD_SERVER_MOD);

	TBaseType::onConnectSocket(socket, sockHandler, packetHandler, tag);

	switch(tag)
	{
	case SOCKET_TAG_WMC:
		{
			CWorldManagerServerHandler* pManagerHandler = (CWorldManagerServerHandler*)sockHandler;
			pManagerHandler->sendRegiste();
		}break;
	default:
		{
			//return false;
		}break;
	}

	return true;

	FUNC_END(false);
}

bool CWorldServer::initFromDb() 
{
	DIFFALSE(_newLoginDbHandler());
	DIFFALSE(_newGameDbHandler());
	DIFFALSE(_newServerListDbHandler());

	// 加载当前服务器信息
// 	if(!DSqlConnectionMgr.loadServerInfo()){
// 		gxError("Can't load server info!");
// 		return false;
// 	}

	// 加载所有玩家
	DIFFALSE(DWorldAllUserMgr.loadAll());

	// 获取当前服务器数据
	DIFFALSE(getGameDbHandler()->sendGameInitTask());

	// 得到服务器数据
	DIFFALSE(getServerListDbHandler()->sendServerInitTask());

	// 加载登陆服务器数据
//	DIFFALSE(getServerListDbHandler()->sendLoadLoginServers());

	return true;
}

void CWorldServer::clear()
{
	_initDataSuccess = false;
	_loginDbHandler = NULL;
	_gameDbHandler = NULL;
	_serverListDbHandler = NULL;
}

bool CWorldServer::initServer( const TServerPwdInfo* pwdInfo )
{
	_initDataSuccess = true;
	if(!_initServerConfig(*pwdInfo))
	{
		return false;
	}

	if(!_initServerMgrData())
	{
		return false;
	}

	if(!_initSockets())
	{
		return false;
	}

	if(!_initServerData())
	{
		return false;
	}

	if(!_ininServerLogicMod())
	{
		return false;
	}

	return true;
}

bool CWorldServer::_initServerMgrData()
{
	RebuildStringConstant();

	DRandGen.reset((CRandGen::TSeedType)time(NULL)%100000000);
	DIFFALSE(DWorldMapPlayerMgr.init(10));
	DIFFALSE(DWorldPlayerMgr.init(_config.getClientNum()));
	DIFFALSE(DLoginPlayerMgr.init(_config.getLoginPlayerNum()));
	DIFFALSE(DWorldAllUserMgr.init());
	DIFFALSE(DCheckText.init(_config.getCheckTextFileName()));
	DIFFALSE(DWorldUserMgr.init(_config.getClientNum()));
//	DIFFALSE(DWorldScriptEngine.initScript("script/WorldServiceMainScript.lua"));
	if(false == DSceneMgr.init(MAX_MAP_SERVER*MAX_SCENE_NUM))
	{
		gxError("Can't init scene mgr!");
		return false;
	}
	if(false == DMapMgr.init(MAX_SCENE_NUM))
	{
		gxError("Can't init map mgr!");
		return false;
	}
	return true;
}

bool CWorldServer::_initSockets()
{
	// 管理服务器连接
// 	if ( false == openServerConnector<CWorldManagerServerHandler, CGameServerSocketPacketHandler>(
// 		_config.getManagerServerIP(), _config.getManagerServerPort(), 500000, SOCKET_TAG_WMC, false))
// 	{
// 		gxError("Can't open listen! RecordeServerIP = {0}, RecordeServerPort = {1}",
// 			_config.getRecordeServerIP(), _config.getRecordeServerPort());
// 		return false;
// 	}

	// 客户端监听
	if (false == openServerListener<CWorldPlayerHandler, CGameSocketPacketHandler>
		(_config.getClientListenIP(), _config.getClientListenPort(), SOCKET_TAG_WCL))
	{
		gxError("Can't open client listen! ListenIP = {0}, ListenPort = {1}", _config.getClientListenIP(), _config.getClientListenPort());
		return false;
	}

	// 地图服务器监听
	if (false == openServerListener<CWorldMapServerHandler, CGameServerSocketPacketHandler>
		(_config.getMapListenIP(), _config.getMapListenPort(), SOCKET_TAG_WML))
	{
		gxError("Can't open map server listen! ListenIP = {0}, ListenPort = {1}", _config.getMapListenIP(), _config.getMapListenPort());
		return false;
	}

	// 日志服务器监听
// 	if ( false == openServerListener<CWorldRecordServerHandle, CGameServerSocketPacketHandler>(
// 		_config.getRecordeServerIP(), _config.getRecordeServerPort(), SOCKET_TAG_WRL))
// 	{
// 		gxError("Can't open record server listen! RecordeServerIP = {0}, RecordeServerPort = {1}",
// 			_config.getRecordeServerIP(), _config.getRecordeServerPort());
// 		return false;
// 	}

	// 充值服务器监听
	if ( false == openServerListener<CWorldChargingServerHandler, CGameServerSocketPacketHandler>(
		_config.getBillListenIP().c_str(), _config.getBillListenPort(), SOCKET_TAG_WBC))
	{
		gxError("Can't open charging server listen! ChargingListenIP = {0}, ChargingListenPort = {1}",
			_config.getBillListenIP(), _config.getBillListenPort());
		return false;
	}

	// 登陆服务器监听
	if(false == openServerListener<CWorldLoginServerHandler, CGameServerSocketPacketHandler>
		(getConfig()->getLoginServerIP(), getConfig()->getLoginServerPort(), SOCKET_TAG_WLC))
	{
		gxError("Can't open login server listen! ServerIP = {0}, ServerPort = {1}", 
			getConfig()->getLoginServerIP(), getConfig()->getLoginServerPort());
		return false;
	}

	// HTTP监听
	if(false == openServerListener<CHttpDefaultHandler, GXMISC::CEmptyPacketHandler>
		(_config.getHttpListenIP().c_str(), _config.getHttpListenPort(), SOCKET_TAG_WHL)){
		gxError("Can't open http listen!HttpIP = {0}, HttpPort = {1}", _config.getHttpListenIP(), _config.getHttpListenPort());
		return false;
	}

	return true;
}

bool CWorldServer::_initServerData()
{
	if (false == DSqlConnectionMgr.start(_config.getDbName(), _config.getDbHostIP(), _config.getDbUser(), _config.getDbPwd(), _config.getDbPort() ))
	{
		gxError("Can't init sql connection manager!");
		return false;
	}

	if(!initFromDb()){
		return false;
	}

	_stopTimer.setScriptEngine(CWorldScriptEngine::GetPtrInstance());
	_stopTimer.setService(this);

	return true;
}

bool CWorldServer::_initServerConfig( const TServerPwdInfo& pwdInfo )
{
	CCconfigLoaderParam configLoaderParam;
	configLoaderParam.remotePath = false;
	configLoaderParam.encrypt = false;
	if(_config.isConfigRemotePath())
	{
		configLoaderParam.remotePath = true;
		configLoaderParam.encrypt = true;
	}
	else
	{
		g_GameConfig.urlPath = "";
	}

	configLoaderParam.loginName = pwdInfo.userName.c_str();
	configLoaderParam.loginPwd = pwdInfo.userPwd.c_str();
	configLoaderParam.encryptKey = pwdInfo.parsePwd.c_str();

	// 加载配置文件
	DLoaderConfig(NewRole);
	DLoaderConfig(RandRoleName);
	DLoaderConfig(Constant);

	DIFFALSE(checkTblConfig());

	return true;
}

void CWorldServer::onStat()
{
	FUNC_BEGIN(WORLD_SERVER_MOD);

	FUNC_END(DRET_NULL);
}

bool CWorldServer::onAfterStart()
{
	FUNC_BEGIN(WORLD_SERVER_MOD);

	if(!TBaseType::onAfterStart()){
		return false;
	}

	return true;

	FUNC_END(false);
}

bool CWorldServer::onLoad(const std::string& inData, std::string& outData)
{
	FUNC_BEGIN(WORLD_SERVER_MOD);

	// 解密ini文件
// 	if(!g_GameConfig.iniFileUncrypt)
// 	{
// 		std::string fileData;
// 		byte aesKey[CryptoPP::AES::DEFAULT_KEYLENGTH];  //密钥
// 		memset(aesKey, 0, sizeof(aesKey));
// 		strcpy((char*)aesKey, "axjhgameconfig");
// 		if(false == AESDecryptFile(aesKey, CryptoPP::AES::DEFAULT_KEYLENGTH, fileName, fileData))
// 		{
// 			return false;
// 		}
// 
// 		return iniFile.open(fileData.c_str(), (sint32)fileData.size());
// 	}
// 	else
// 	{
// 		std::string tempFileName = fileName + ".tmp";
// 		return iniFile.open(tempFileName.c_str());
// 	}
// 
// 	return false;

	outData = inData;

	return true;

	FUNC_END(false);
}

CWorldServerConfig* CWorldServer::getConfig()
{
	FUNC_BEGIN(WORLD_SERVER_MOD);

	return &_config;

	FUNC_END(NULL);
}

TWorldServerID_t CWorldServer::getWorldServerID() const
{
	return _config.getWorldServerID();
}

GXMISC::TGameTime_t CWorldServer::getStartTime() const
{
	return _serverStartTime;
}

EServerStatus CWorldServer::getServerStatus()
{
	return INVALID_SERVER_STATUS;
}

GXMISC::TGameTime_t CWorldServer::getFirstStartTime() const
{
	return _serverInfo.getFirstStartTime();
}

GXMISC::TGameTime_t CWorldServer::getOpenTime() const
{
	return _serverInfo.getOpenTime();
}

const CWorldServerInfo* CWorldServer::getServerInfo() const
{
	return &_serverInfo;
}

CWorldServerInfo* CWorldServer::getServerInfo()
{
	return &_serverInfo;
}

void CWorldServer::onFirstLoop()
{
	FUNC_BEGIN(WORLD_SERVER_MOD);

	TBaseType::onFirstLoop();

	if(_config.isConfigRemotePath())
	{
		// TODO:
	}
	else
	{
		TServerPwdInfo info;
		if(!initServer(&info)){
			setStop();
			return;
		}
	}

	FUNC_END(DRET_NULL);
}

bool CWorldServer::_ininServerLogicMod()
{
	return true;
}

bool CWorldServer::_newLoginDbHandler()
{
	FUNC_BEGIN(WORLD_SERVER_MOD);

	_loginDbHandler = getDbMgr()->addUser<CWorldDbServerHandler>(DB_LOGIN);
	if (NULL == _loginDbHandler) {
		gxError("Can't add CWorldDbServerHandler!");
		return false;
	}
	
	return true;

	FUNC_END(false);
}

bool CWorldServer::_newGameDbHandler()
{
	FUNC_BEGIN(WORLD_SERVER_MOD);
	
	_gameDbHandler = getDbMgr()->addUser<CWorldDbServerHandler>(DB_GAME);
	if (NULL == _gameDbHandler) {
		gxError("Can't add CWorldDbServerHandler!");
		return false;
	}

	return true;

	FUNC_END(false);
}

bool CWorldServer::_newServerListDbHandler()
{
	FUNC_BEGIN(WORLD_SERVER_MOD);

	_serverListDbHandler = getDbMgr()->addUser<CWorldDbServerHandler>(DB_SERVER);
	if (NULL == _serverListDbHandler) {
		gxError("Can't add CWorldDbServerHandler!");
		return false;
	}

	return true;

	FUNC_END(false);
}


CWorldDbServerHandler* CWorldServer::getLoginDbHandler()
{
	return _loginDbHandler;
}

CWorldDbServerHandler* CWorldServer::getGameDbHandler()
{
	return _gameDbHandler;
}

bool CWorldServer::checkTblConfig()
{
	for(TTblLoaderVec::iterator iter = _tblLoaders.begin(); iter != _tblLoaders.end(); ++iter)
	{
		DIFFALSE((*iter)->checkConfig());
	}

	return true;
}

CWorldDbServerHandler* CWorldServer::getServerListDbHandler()
{
	return _serverListDbHandler;
}

void CWorldServer::onPassHour()
{
}

void CWorldServer::onPassDay()
{
	gxInfo("World server pass day!");
}

CStopTimer* CWorldServer::getStopTimer()
{
	return &_stopTimer;
}
