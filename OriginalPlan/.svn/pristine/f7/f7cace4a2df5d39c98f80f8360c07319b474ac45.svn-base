#include "core/game_exception.h"

#include "map_server.h"
#include "map_server_event.h"

#include "game_rand.h"
#include "error_log.h"
#include "gm_log.h"
#include "stat_log.h"
#include "game_config.h"
#include "game_extend_socket_handler.h"
#include "game_socket_packet_handler.h"
#include "game_server_socket_packet_handler.h"
#include "map_player_handler.h"
#include "map_world_handler.h"
#include "map_server_util.h"
#include "map_tbl_header.h"
#include "map_server_instance.h"
#include "map_data_manager.h"
#include "scene_manager.h"
#include "role_manager.h"
#include "module_def.h"
#include "gm_manager.h"
#include "constant_define.h"
#include "script_engine.h"
#include "dirty_word_filter.h"
#include "map_http_handler.h"
#include "module_def.h"
#include "map_server_data.h"
#include "db_name_define.h"
#include "map_db_server_handler.h"
#include "announcement.h"
#include "http_default_handler.h"
#include "stop_event.h"
#include "npc_tbl.h"
#include "tbl_test.h"
#include "announcement_tbl.h"
#include "gm_string_parse.h"
#include "item_mod/item_manager.h"
#include "item_mod/item_property.h"

CMapServer::CMapServer(const std::string& serverName) : TBaseType(serverName, &_config), _config(serverName)
{
	g_MapServer = this;
	g_MapServerConfig = &_config;

	CGameSocketPacketHandler::Setup();
	CMapWorldServerHandler::Setup();
	CMapPlayerHandler::Setup();
	setScriptEngine(&DScriptEngine);
	setMainScriptName("script/MapServiceMainScript.lua");
	setNewServiceFunctionName("NewMainServer");
}

CMapServer::~CMapServer()
{
}

void CMapServer::onBreath( GXMISC::TDiffTime_t diff )
{
	TBaseType::onBreath(diff);

	DRoleManager.update(diff);
	DSceneMgr.update(diff);
	DMapServerData.update(diff);
	updateTimer(diff);
	updateBroad(diff);

	_stopTimer.update(diff);
	if(_timer.update(diff)){
		onTimer();
		_timer.reset();
	}
}

void CMapServer::onStat()
{
	TBaseType::onStat();
}

bool CMapServer::init()
{
	if(!TBaseType::init())
	{
		return false;
	}

	CServiceStopEvent* stopEvent = new CServiceStopEvent();
	stopEvent->setScriptEngine(CScriptEngine::GetPtrInstance());
	stopEvent->setService(this);
	DGxContext.setStopHandler(stopEvent);

	return true;
}

const CMapServerConfig* CMapServer::getServerConfig() const
{
	return &_config;
}

void CMapServer::onLoopBefore()
{
	TBaseType::onLoopBefore();
	if(_config.getProfileFrame() == 1)
	{
		gxInfo("=======Map server loop before========");
	}
	if(_scriptObject.isExistMember("GetServerTimerInterval")){
		int val = _scriptObject.call<int>("GetServerTimerInterval", 5000);
		if(val < 5000){
			val = 5000;
		}

		_timer.init(val);
	}
}

void CMapServer::onLoopAfter()
{
	if(_config.getProfileFrame() == 1)
	{
		gxInfo("=======Map server loop after========");
	}
}

bool CMapServer::onAfterLoad()
{
	if(false == TBaseType::onAfterLoad())
	{
		gxError("Can't do after load!");
		return false;
	}

	// @TODO 检测参数是否合法
	if(_config.getRolePoolNum() > getNetMgr()->getMaxConnNum())
	{
		gxError("Role num must less than max connect num! RoleNum={0}, MaxConnNum={1}", _config.getRolePoolNum(), getNetMgr()->getMaxConnNum());
		return false;
	}

	return true;
}

void CMapServer::onIdle()
{
}

void CMapServer::onTimer()
{
	// 隔一定时间一定会调用的定时器
	//	DRoleManager.updateRoleIdle();
	_scriptObject.vCall("onTimer", _timer.getMaxSecs());
}

bool CMapServer::onAcceptSocket( GXMISC::CSocket* socket, GXMISC::CSocketHandler* sockHandler, GXMISC::ISocketPacketHandler* packetHandler, sint32 tag )
{
	if (!TBaseType::onAcceptSocket(socket, sockHandler, packetHandler, tag))
	{
		return false;
	}

	TSockExtAttr attrs;
	switch(tag)
	{
	case SOCKET_TAG_MCL:
		{
			CGameSocketPacketHandler* pHandler = dynamic_cast<CGameSocketPacketHandler*>(packetHandler);
			if(NULL == pHandler)
			{
				return false;
			}
			attrs = *_config.getClientListenSocketAttr();
			pHandler->setAttr(&attrs);
		}break;
	case SOCKET_TAG_MMCL:
		{
			CGameServerSocketPacketHandler* pHandler = dynamic_cast<CGameServerSocketPacketHandler*>(packetHandler);
			if(NULL == pHandler)
			{
				return false;
			}
			attrs = *_config.getManagerSvrSocketAttr();
			pHandler->setAttr(&attrs);
		}break;
	case SOCKET_TAG_MRCL:
		{
			CGameServerSocketPacketHandler* pHandler = dynamic_cast<CGameServerSocketPacketHandler*>(packetHandler);
			if(NULL == pHandler)
			{
				return false;
			}
			attrs = *_config.getRecordeSvrSocketAttr();
			pHandler->setAttr(&attrs);
		}break;
	case SOCKET_TAG_MHL:
		{
			CHttpDefaultHandler* httpSocketHandler=(CHttpDefaultHandler*)sockHandler;
			httpSocketHandler->setScriptEngine(DScriptEngine.GetPtrInstance());
		}break;
	default:
		{
			return false;
		}
	}

	return true;
}

bool CMapServer::onConnectSocket( GXMISC::CSocket* socket, GXMISC::CSocketHandler* sockHandler, GXMISC::ISocketPacketHandler* packetHandler, sint32 tag )
{
	if (!TBaseType::onConnectSocket(socket, sockHandler, packetHandler, tag))
	{
		return false;
	}

	TSockExtAttr attrs;
	switch(tag)
	{
	case SOCKET_TAG_MWC:
		{
			CGameServerSocketPacketHandler* pHandler = dynamic_cast<CGameServerSocketPacketHandler*>(packetHandler);
			if(NULL == pHandler)
			{
				return false;
			}
			attrs = *_config.getWorldSvrSocketAttr();
			pHandler->setAttr(&attrs);
		}break;
	case SOCKET_TAG_MRSCL:
		{
			CGameServerSocketPacketHandler* pHandler = dynamic_cast<CGameServerSocketPacketHandler*>(packetHandler);
			if(NULL == pHandler)
			{
				return false;
			}
			attrs = *_config.getResourceSvrSocketAttr();
			pHandler->setAttr(&attrs);
		}break;
	default:
		{
			return false;
		}
	}

	return true;
}

bool CMapServer::onInitSocket()
{
// 	if(false == openServerConnector<CMapWorldServerHandler, CGameServerSocketPacketHandler>(
// 		_config.getWorldServerIP().c_str(), _config.getWorldServerPort(), 5000, true, SOCKET_TAG_MWC))
// 	{
// 		gxError("Can't open connector!WorldServerIP = {0}, WorldServerPort = {1}", _config.getWorldServerIP(), _config.getWorldServerPort());
// 		return false;
// 	}

	if (false == openServerListener<CHttpDefaultHandler, GXMISC::CEmptyPacketHandler>(_config.getHttpListenIP().c_str(), _config.getHttpListenPort(), SOCKET_TAG_MHL)){
		gxError("Can't open http listen!HttpIP = {0}, HttpPort = {1}", _config.getHttpListenIP(), _config.getHttpListenPort());
		return false;
	}

	if (_scriptObject.isExistMember("onInitSocket"))
	{
		if (!_scriptObject.bCall("onInitSocket"))
		{
			return false;
		}
	}

	return true;
}

bool CMapServer::onAfterStart()
{
	if(!TBaseType::onAfterStart())
	{
		return false;
	}

	doTest();
	
	return true;
}

bool CMapServer::onAfterInitServer()
{
	if (_scriptObject.isExistMember("onAfterInitServer"))
	{
		if (!_scriptObject.bCall("onAfterInitServer"))
		{
			return false;
		}
	}

	if(false == openServerListener<CMapPlayerHandler, CGameSocketPacketHandler>(
		_config.getClientListenIP().c_str(), _config.getClientListenPort(), SOCKET_TAG_MCL))
	{
		gxError("Can't open listener!ClientListenIP = {0}, ClientListenPort = {1}", _config.getClientListenIP(), _config.getClientListenPort());
		setStop();
		return false;
	}

	return true;
}

bool CMapServer::isDynamicServer() const
{
	return getServerConfig()->getMapServerType() == SERVER_TYPE_MAP_DYNAMIC;
}

bool CMapServer::isConfigRemotePath() const
{
	return _config.isConfigRemotePath();
}

bool CMapServer::onInitServerData()
{
	if (_scriptObject.isExistMember("onInitServerData"))
	{
		if (!_scriptObject.bCall("onInitServerData"))
		{
			return false;
		}
	}

	RebuildStringConstant();

	DIFFALSE(DMapDataMgr.init(_config.getMapDataPath()));
	DIFFALSE(DSceneMgr.init(&_config));
	DIFFALSE(addNpcToMap());
	DIFFALSE(addTransportToMap());
	DIFFALSE(DCheckText.init(_config.getCheckTextFileName()) );
	DGmCmdMgr.init("gm");
	DIFFALSE(DRoleManager.initRolePool(_config.getRolePoolNum()));
	DIFFALSE(DScriptEngine.bCall("InitServerConfig", &g_GameConfig));
	DIFFALSE(checkTblConfig());
	addSysBroad();
	_stopTimer.setService(this);
	_stopTimer.setScriptEngine(CScriptEngine::GetPtrInstance());
	DRoleManager.setNewRoleScriptFunctionName("NewRole");

	return true;
}

bool CMapServer::checkTblConfig()
{
	for(TTblLoaderVec::iterator iter = _tblLoaders.begin(); iter != _tblLoaders.end(); ++iter)
	{
		DIFFALSE((*iter)->checkConfig());
	}

	return true;
}

bool CMapServer::onBeforeInitServer()
{
	if (_scriptObject.isExistMember("onBeforeInitServer"))
	{
		if (!_scriptObject.bCall("onBeforeInitServer"))
		{
			return false;
		}
	}

	return true;
}

bool CMapServer::onLoadTblConfig( CCconfigLoaderParam& configLoaderParam )
{
	if (_scriptObject.isExistMember("onLoadTblConfig"))
	{
		if (!_scriptObject.bCall("onLoadTblConfig"))
		{
			return false;
		}
	}

    //现在存在加载表会检查里面的配置，存在依赖问题，所有，加载表有顺序要求 
	DLoaderConfig(NewRole);
	DLoaderConfig(Item);
	DLoaderConfig(Map);
	DLoaderConfig(Constant);
	DLoaderConfig(Transport);	
	DLoaderConfig(LevelUp);
	DLoaderConfig(Mission);
	DLoaderConfig(Dhm);
	DLoaderConfig(Npc);
	DLoaderConfig(Announcement);

	return true;
}

EServerType CMapServer::getServerType()
{
	return _config.getMapServerType();
}

sint32 CMapServer::getMaxRoleNum()
{
	return _config.getRolePoolNum();
}

TServerID_t CMapServer::getServerID()
{
	return _config.getMapServerID();
}

std::string CMapServer::getToClientListenIP()
{
	return _config.getToClientListenIP();
}

GXMISC::TPort_t CMapServer::getToClientListenPort()
{
	return _config.getToClientListenPort();
}

const TMapIDList CMapServer::getMapIDs() const
{
	return _config.getMapIDs();
}

void CMapServer::doTest()
{
}

bool CMapServer::addNpcToMap()
{
	FUNC_BEGIN(SCENE_MOD);

	for(CNpcTblLoader::Iterator iter = DNpcTblMgr.begin(); iter != DNpcTblMgr.end(); ++iter)
	{
		CMap* pMap = DMapDataMgr.findMap(iter->second->mapID);
		if(NULL == pMap)
		{
			continue;
		}

		pMap->pushNpc(iter->second->id);
	}

	return true;

	FUNC_END(false);
}

bool CMapServer::addTransportToMap()
{
	FUNC_BEGIN(SCENE_MOD);

	for(CTransportTblLoader::Iterator iter = DTransportTblMgr.begin(); iter != DTransportTblMgr.end(); ++iter)
	{
		CMap* pMap = DMapDataMgr.findMap(iter->second->mapID);
		if(NULL == pMap)
		{
			continue;
		}

		if(iter->second->isShow)
		{
			pMap->pushTransport(iter->second->id);
		}
	}

	return true;

	FUNC_END(false);
}

bool CMapServer::isGmLog()
{
	return _config.getOpenGmLog();
}

GXMISC::TGameTime_t CMapServer::getFirstStartTime() const
{
	return DTimeManager.nowSysTime();
}

GXMISC::TGameTime_t CMapServer::getOpenTime() const
{
	return DTimeManager.nowSysTime();
}

bool CMapServer::onInitServerDbData()
{
	FUNC_BEGIN(MAP_SERVER_MOD);

	CMapDbServerHandler* mapDbHandler = getDbMgr()->addUser<CMapDbServerHandler>(DB_LOGIN);
	if(NULL == mapDbHandler)
	{
		gxError("Can't add CMapDbServerHandler!");
		return false;
	}

	DMapServerData.setMapDbHandlerID(mapDbHandler->getUniqueIndex());

	if (!TBaseType::onInitServerDbData())
	{
		return false;
	}

	if (_scriptObject.isExistMember("onInitServerDbData"))
	{
		if (!_scriptObject.bCall("onInitServerDbData"))
		{
			return false;
		}
	}

	return true;

	FUNC_END(false);
}

void CMapServer::onPassMonth()
{
	if(_scriptObject.isExistMember("onInHour")){
		_scriptObject.bCall("onInHour");
	}
}

void CMapServer::onPassWeekday()
{
}

void CMapServer::onPassDay()
{
	gxInfo("Map server pass day!");
}

void CMapServer::onPassHour()
{
	gxInfo("Pass one hour!HourID={0}", DTimeManager.getHour());
	DRoleManager.updateTimer(DTimeManager.getHour());
}

bool CMapServer::OnCommand(char* szCmd)
{
//	TBaseType::OnCommand(szCmd);

	return DScriptEngine.bCall("HandleGmString2", szCmd);
}

void CMapServer::addSysBroad()
{
	for(CAnnouncementTblLoader::Iterator iter = DAnnouncementTblMgr.begin(); iter != DAnnouncementTblMgr.end(); ++iter)
	{
		CAnnouncementTbl* pRow = iter->second;
		if(NULL != pRow && pRow->type == 1)
		{
			TBroadInfo broadInfo;
			broadInfo._startTime = pRow->startTime;
			broadInfo._endTime = pRow->endTime;
			broadInfo._interval = pRow->refreshTime;

			_announcementSysMgr.addBroad(pRow->id, &broadInfo);
		}
	}
}

void CMapServer::addManagerBoard( std::string msg, sint32 interval /*= 5*/ )
{
	TBroadInfo broadInfo;
	broadInfo._startTime = 0;
	broadInfo._endTime = GXMISC::MAX_GAME_TIME;
	broadInfo._interval = interval;
	broadInfo._chatStr = msg;

	_announcementSysMgr.addBroad(&broadInfo);
}

void CMapServer::addManagerBoard( std::string msg, sint32 lastTime, sint32 interval )
{
	TBroadInfo broadInfo;
	broadInfo._startTime = DTimeManager.nowSysTime();
	broadInfo._endTime = broadInfo._startTime+lastTime;
	broadInfo._interval = interval;
	broadInfo._chatStr = msg;

	_announcementSysMgr.addBroad(&broadInfo);
}


void CMapServer::updateBroad( GXMISC::TDiffTime_t diff )
{
	TAnnouncementMsg msgs;
	_announcementSysMgr.update(diff, msgs);
	if(!msgs.empty())
	{
		for(TAnnouncementMsg::iterator iter = msgs.begin(); iter != msgs.end(); ++iter)
		{
			if(CAnnouncementSysManager::IsSystemID(iter->first))
			{
				// 系统公告
				CAnnouncement::BroadToAll(iter->first);
			}else
			{
				// 后台公告
				CAnnouncement::BroadSystem(INVALID_ANNOUNCEMENT_ID, iter->second);
			}
		}
	}
}

void CMapServer::onRegisteToWorld(TServerID_t serverID)
{
	TBaseType::onRegisteToWorld(serverID);

	DMapServerData.setWorldServerID(serverID);
}

void CMapServer::onWorldServerInfo( WMServerInfo* packet )
{
	TBaseType::onWorldServerInfo(packet);

	DMapServerData.initWorldServerInfo(packet->openTime, packet->firstStartTime);
}

void CMapServer::InitStaticInstanace(CScriptEngine::TScriptState* L)
{
	CScriptEngine* pScriptEngine = new CScriptEngine(L == NULL);
	if (L == NULL){
		L = pScriptEngine->getState();
	}
	pScriptEngine->init(L);

	new CRandGen;
	new CMapDataManager;
	new CSceneManager;
	new CRoleManager;
	new CGmCmdFunc;
	new CGmCmdParse;
	new CCheckText;
	new CMapServerData;
	new CItemManager;
	new CItemProperty;
}

bool CMapServer::canOpenDynamicMap() const
{
	return isDynamicServer() && DSceneMgr.getDynamicMapNum() < _config.getRiskSceneNum();
}
