#include "core/debug.h"
#include "core/db_single_conn_manager.h"
#include "core/game_exception.h"
#include "core/ucstring.h"
#include "core/database_conn_mgr.h"
#include "core/socket_event_loop_wrap_mgr.h"

#include "world_player.h"
#include "game_util.h"
#include "world_server_util.h"
#include "game_define.h"
#include "world_player_handler.h"
#include "world_player_mgr.h"
#include "world_user.h"
#include "world_user_mgr.h"
#include "world_map_player.h"
#include "world_map_player_mgr.h"
#include "world_login_player_mgr.h"
#include "dirty_word_filter.h"
#include "scene.h"
#include "scene_manager.h"
#include "module_def.h"
#include "game_misc.h"
#include "world_all_user.h"
#include "game_config.h"
#include "world_db_handler.h"
#include "limit_manager.h"
#include "world_server_util.h"
#include "world_server.h"
#include "new_role_tbl.h"
#include "world_login_server_mgr.h"
#include "world_login_server_handler.h"
#include "db_table_def.h"

#define DLoginFailed(ret, retPacket) \
	gxError("Login game request failed, has in invalid!{0}", toString()); \
	retPacket.setRetCode(ret); \
	sendPacket(retPacket); \
	cleanRole();

TAccountID_t CWorldPlayer::getAccountID() {
	return _accountID;
}

void CWorldPlayer::setAccountID(TAccountID_t accountID) {
	_accountID = accountID;
	CWorldPlayerHandler* player = getSocketHandler();
	if (player) {
		player->setAccountID(accountID);
	}
	genStrName();
}

CWorldPlayer::CWorldPlayer() 
{
	_accountID = INVALID_ACCOUNT_ID;
	_roleList.clean();
	_dbIndex = GXMISC::INVALID_UNIQUE_INDEX;
	_playerStatus = PS_IDLE;
	_mapServerID = INVALID_SERVER_ID;
	_lastHeartTime = DTimeManager.nowSysTime();
	_loginKey = INVALID_LOGIN_KEY;
	_sourceWay = INVALID_SOURCE_WAY_ID;
	_chisourceWay = INVALID_SOURCE_WAY_ID;
	_gmPower = 0;
	_valid = true;
	_queType = MGR_QUE_TYPE_INVALID;
	_unloadType = UNLOAD_ROLE_TYPE_QUIT;
	_changeLineWait.cleanUp();
	_changeLineWait.init(120, 120);
	_changeLineTempData.cleanUp();
	_rechargeFlag = false;
	_logintime = GXMISC::MAX_GAME_TIME;
	_strName = "";
}

CWorldPlayer::~CWorldPlayer() {
}

void CWorldPlayer::getRoleList(TPackLoginRoleArray& roleList)
{
	_roleList.getRoleList(roleList);
}

bool CWorldPlayer::selectRole(TRoleUID_t roleUID) 
{
	if (false == _roleList.selectRole(roleUID)) 
	{
		return false;
	}

	_changeLineWait.objUID = getCurrentObjUID();

	genStrName();
	return true;
}

bool CWorldPlayer::hasRole(TRoleUID_t roleUID) 
{
	return _roleList.isRole(roleUID);
}

void CWorldPlayer::quit(bool isForce, const char* quitReason)
{
	if((uint32)strlen(quitReason) != 0)
	{
		gxInfo("WorldPlayer quit!Reason={0}, {1}", quitReason, toString());
	}
	else
	{
		gxInfo("WorldPlayer quit!{0}", toString());
	}

	if (!isForce)
	{
		if (isAccountVerifyStatus())
		{
			// 登陆状态直接退出
			cleanAll();
		}
		else
		{
			// 非登陆状态
			if(!(isRequstStatus() || getLoginManager()->isLogin() || getLoginManager()->isLogout()))
			{
				// 释放角色数据
				if (isDataNeedFreeStatus())
				{
					if (!unloadRoleDataReq(UNLOAD_ROLE_TYPE_QUIT))
					{
						cleanAll();
					}
					setPlayerStatus(PS_QUIT_REQ);
				}
				else
				{
					cleanAll();
				}
			}
			else
			{	// 请求未响应, 等待响应返回

				gxError("Role is request status!{0}", toString());
				
				// 添加一个登出等待请求
			//	getLoginManager().push(UNLOAD_ROLE_TYPE_QUIT, true, getSocketIndex());
			}
		}
	}
	else
	{
		cleanAll();
	}
}

void CWorldPlayer::setSocketIndex(GXMISC::TSocketIndex_t socketIndex) {
	_socketIndex = socketIndex;
	genStrName();
}

GXMISC::TUniqueIndex_t CWorldPlayer::getSocketIndex() {
	return _socketIndex;
}

CWorldPlayerHandler* CWorldPlayer::getSocketHandler(bool logFlag /* = true */) {
	GXMISC::CSocketHandler* socketHandler = DWorldNetMgr->getSocketHandler(getSocketIndex());
	if ((NULL == socketHandler) && logFlag) {
		gxWarning("Can't find CSocketHandler! {0}", toString());
	}

	return dynamic_cast<CWorldPlayerHandler*>(socketHandler);
}

const char* CWorldPlayer::toString() const
{
	return _strName.c_str();
}

void CWorldPlayer::setDbIndex(GXMISC::TDbIndex_t index) 
{
	_dbIndex = index;
	genStrName();
}

GXMISC::TUniqueIndex_t CWorldPlayer::getDbIndex()
{
	return _dbIndex;
}

CWorldDbHandler* CWorldPlayer::getDbHandler(bool logFlag /* = true */) {
	CWorldDbHandler* handler =
		dynamic_cast<CWorldDbHandler*>(DWorldDbMgr->getUser(_dbIndex));
	if (NULL == handler && logFlag) {
		gxWarning("Can't find CWorldDbHandler! {0}", toString());
	}

	return handler;
}

bool CWorldPlayer::isMaxRoleNum()
{
	return _roleList.isMaxRoleNum();
}

void CWorldPlayer::quitBySocketClose()
{
	setInvalid(UNLOAD_ROLE_TYPE_QUIT);
	gxInfo("Socket close! {0}", toString());
	if(!isRequstStatus())
	{
		quit(false, "Socket close!");
	}
}

void CWorldPlayer::quitByDbClose() 
{
	setInvalid(UNLOAD_ROLE_TYPE_QUIT);
	gxInfo("DB close! {0}", toString());
	if(!isRequstStatus())
	{
		quit(false, "Db close!");
	}
}

void CWorldPlayer::quitByMapServerClose() 
{
	gxInfo("MapServer close! {0}", toString());
	setInvalid(UNLOAD_ROLE_TYPE_QUIT);
	setPlayerStatus(PS_QUIT);
	quit(true, "MapServer close!");
}

void CWorldPlayer::clean() {
	_changeLineWait.cleanUp();
	gxInfo("Delete player!{0}", toString());
	DWorldPlayerMgr.delPlayer(getAccountID());
}

void CWorldPlayer::cleanSocketHandler()
{
	CWorldPlayerHandler* socketHandler = getSocketHandler(false);
	if (NULL != socketHandler) {
		gxInfo("Clean socket handler!{0}", toString());
		socketHandler->quit();
// 		_dbIndex = GXMISC::INVALID_DB_INDEX;
// 		_socketIndex = GXMISC::INVALID_DB_INDEX;
 	}
//	else{
// 		gxAssert(_socketIndex == GXMISC::INVALID_SOCKET_INDEX);
// 		gxAssert(_dbIndex == GXMISC::INVALID_DB_INDEX);
// 	}
}

void CWorldPlayer::cleanDbHandler() {
	gxInfo("Clean db handler!{0}", toString());
	CWorldDbHandler* dbHandler = getDbHandler(false);
	if (NULL != dbHandler) {
		dbHandler->quit();
	}
}

void CWorldPlayer::genStrName() 
{
	_strName = GXMISC::gxToString("SocketIndex=%"I64_FMT"u,AccountID=%u, DbIndex=%"I64_FMT"u,Status=%u,%s",
		getSocketIndex(), getAccountID(), getDbIndex(), (uint32)_playerStatus, _roleList.toString());
}

TRoleUID_t CWorldPlayer::getCurrentRoleUID() {
	return _roleList.getCurrentRoleUID();
}

TObjUID_t CWorldPlayer::getCurrentObjUID() {
	return _roleList.getCurrentObjUID();
}

void CWorldPlayer::cleanRole() 
{
	gxInfo("Clean role!{0}", toString());
	CWorldMapPlayer* mapPlayer = DWorldMapPlayerMgr.findMapPlayer(_mapServerID);
	if(NULL != mapPlayer)
	{
		mapPlayer->leave(this);
	}

	if (DWorldUserMgr.isExistByRoleUID(getCurrentRoleUID())) 
	{
		DWorldUserMgr.delUserByRoleUID(getCurrentRoleUID());
	}

	_changeLineWait.cleanUp();
	_mapServerID = INVALID_SERVER_ID;
	if (_roleList.getCurrentObjUID() != INVALID_OBJ_UID) {
		// 退出角色
		_roleList.clean();
	} else {
		gxWarning("Player not a current role! {0}", toString());
	}
}

void CWorldPlayer::doLoginVerify() {
	gxAssertEx(_playerStatus == PS_VERIFY_PASS, "PlayerStatus={0}", (uint32)_playerStatus);
	WCVerifyConnectRet verifyRet;
	verifyRet.roleUID = _roleList.getFirstRoleUID();
	verifyRet.setRetCode(RC_SUCCESS);

	sendPacket(verifyRet);

	cleanRole();
}

void CWorldPlayer::loginSuccess() {
	gxInfo("Player login success! {0}", toString());

	gxAssertEx(_playerStatus == PS_IDLE, "PlayerStatus={0}", (uint32)_playerStatus);
	setPlayerStatus(PS_VERIFY_PASS);
	doLoginVerify();

// 	if (getRoleNum() <= 0)
// 	{
// 		DCWRecordeManager.handleCreateBeforeRecorde(this);
// 	}
}

void CWorldPlayer::createRoleReq(TRoleName_t& tempName, TRoleProtypeID_t typeID)
{
	WCCreateRoleRet ret;
	ret.setRetCode(RC_LOGIN_CREATE_ROLE_FAILED);

	// 请求检测
	EGameRetCode retCode = onBeforeRequst(PA_CREATE_ROLE_REQ);
	if(!IsSuccess(retCode))
	{
		ret.setRetCode(retCode);
		sendPacket(ret);
		gxError("Create role request, can't pass request check!{0}", toString());
		return;
	}

	// 检测状态
	if(!checkRequest())
	{
		sendPacket(ret);
		gxError("Create role request, has in request status!{0}", toString());
		return;
	}

	if (isMaxRoleNum()) 
	{
		gxWarning("Up to max role num! {0}", toString());
		ret.setRetCode(RC_LOGIN_MAX_ROLE_NUM);
		sendPacket(ret);
		return;
	}

	TRoleName_t name = DWorldPlayerMgr.genRoleName();

	/*
	uint32 size = GXMISC::gxUtf8StringSize((char*)name.toString().c_str(), name.size());
	if(size < ROLE_NAME_MIN_CHAR_NUM || size > ROLE_NAME_MAX_CHAR_NUM)
	{
		gxWarning("invalid role name len! {0}",toString());
		ret.setRetCode(RC_LOGIN_ROLE_NAME_INVALID);
		sendPacket(ret);
		return;
	}

	if ( !IsSuccess(DCheckText.isTextPass(name.toString())) )
	{
		gxWarning("invalid role name! {0}",toString());
		ret.setRetCode(RC_LOGIN_ROLE_NAME_INVALID);
		sendPacket(ret);
		return;
	}
	*/

	CWorldDbHandler* dbHandler = getDbHandler();
	if (dbHandler) 
	{
		if (false == dbHandler->sendCreateRoleTask(name.toString().c_str(), typeID, getSourceWay(), getChisourceWay())) 
		{
			sendPacket(ret);
		}
		else
		{
			setPlayerStatus(PS_CREATE_ROLE_REQ);
		}
	}
	else 
	{
		sendPacket(ret);
	}
}

EGameRetCode CWorldPlayer::createRoleSuccess(TRetCode_t retCode, TLoginRole* role) 
{
	setPlayerStatus(PS_VERIFY_PASS);

	WCCreateRoleRet createRoleRetPack;
	createRoleRetPack.setRetCode(retCode);

	if (createRoleRetPack.getRetCode() == RC_SUCCESS)
	{
		if ( role->objUID == INVALID_OBJ_UID )
		{
			gxError("Add new user!!! But the objuid is invalid!!!!");
			gxAssert(false);
			createRoleRetPack.setRetCode(RC_FAILED);
		}
		// 创建角色成功
		_roleList.addRole(role);
		
		DWorldAllUserMgr.addUser(role);
		createRoleRetPack.roleUID = role->roleUID;
	}

	sendPacket(createRoleRetPack);

	return RC_SUCCESS;
}

void CWorldPlayer::createRoleFailed( TLoginRole* role )
{
	// @TODO
}

// void CWorldPlayer::deleteRoleReq(TRoleUID_t roleUID)
// {
// 	FUNC_BEGIN(LOGIN_MOD);
// 	WCDeleteRoleRet ret;
// 	ret.setRetCode(RC_LOGIN_DELETE_ROLE_FAILED);
// 
// 	gxInfo("Delete role req!%s,RoleUID=%"I64_FMT"u", toString(), roleUID);
// 	if(!checkRequest())
// 	{
// 		sendPacket(ret);
// 		gxError("Delete role quest, has in request status!%s", toString());
// 		return;
// 	}
// 
// 	if (_roleList.size() <= MIN_ROLE_NUM) 
// 	{
// 		gxInfo("Delete role quest, need min role!%s", toString());
// 		ret.setRetCode(RC_LOGIN_MIN_ROLE_NUM);
// 		sendPacket(ret);
// 		return;
// 	}
// 
// 	if(!DSqlConnectionMgr.delRole(roleUID, toString()))
// 	{
// 		sendPacket(ret);
// 		return;
// 	}
// 	ret.roleUID = roleUID;
// 	ret.setRetCode(RC_SUCCESS);
// 	sendPacket(ret);
// 	_roleList.delRole(roleUID);
// 	gxInfo("Delete role success!%s,RoleUID=%"I64_FMT"u", toString(), roleUID);
// 
// 	FUNC_END(DRET_NULL);
// }

void CWorldPlayer::loginGameReq(TRoleUID_t roleUID, bool enterDynamicMapFlag)
{
	WCLoginGameRet retPacket;
	retPacket.setRetCode(RC_LOGIN_FAILED);

	if(getLoginManager()->isLogin())
	{
		gxError("Login game request failed, has in request!{0}", toString());
		retPacket.setRetCode(RC_LOGIN_REQUEST_WAIT);
		sendPacket(retPacket);
		return;
	}

	if(isRequstStatus())
	{
		gxError("Login game request failed, has in request!{0}", toString());
		retPacket.setRetCode(RC_LOGIN_REQUEST_WAIT);
		sendPacket(retPacket);
		return;
	}

	if(!isValid())
	{
		gxError("Login game request failed, has in invalid!{0}", toString());
		retPacket.setRetCode(RC_LOGIN_REQUEST_FAILED);
		sendPacket(retPacket);
		quit(false, "Login game request invalid!");
		return;
	}

	EGameRetCode retCode = onBeforeRequst(PA_LOGIN_GAME_REQ);
	if(!IsSuccess(retCode))
	{
		gxError("Login game request failed, can't pass before request!{0}", toString());
		retPacket.setRetCode(retCode);
		sendPacket(retPacket);
		return;
	}

	// 验证状态
	if (!isVerifyPass()) 
	{
		gxWarning("Can't login game, has select role enter! Status = {0}, {1}", (uint32)_playerStatus, toString());
		sendPacket(retPacket);
		return;
	}

	// 选择角色
	if (false == selectRole(roleUID))
	{
		gxError("Cant select role!{0}", toString());
		retPacket.setRetCode(RC_LOGIN_NO_ROLE);
		sendPacket(retPacket);
		return;
	}

	// 获取当前角色
	TLoginRole* pLoginRole = _roleList.getCurrentRole();
	gxAssert(NULL != pLoginRole);
	if(NULL == pLoginRole)
	{
		gxError("Cant get current role!{0}", toString());
		DLoginFailed(RC_LOGIN_NO_ROLE, retPacket);
		return;
	}

// 	if ( DLimitManager.checkLimitLogin(pLoginRole->roleUID) )
// 	{
// 		gxError("Login failed, login limit!{0}", pLoginRole->toString());
// 		DLoginFailed(RC_LOGIN_LIMIT, retPacket);
// 		return ;
// 	}

	if(IsHasLoginServer())
	{
		GetLoginServer(true)->sendRoleLogin(getLoginKey(), getAccountID(), getCurrentRoleUID(), pLoginRole->name.toString(), DWorldServer->getWorldServerID(), getSocketHandler()->getRemoteIp());
	}

	CNewRoleTbl* pNewRoleRow = DNewRoleTblMgr.find(pLoginRole->protypeID);
	if(NULL == pNewRoleRow){
		gxError("Login failed, can't get role row!ProtypeID={0}, {1}, {2}", (sint32)pLoginRole->protypeID, pLoginRole->toString(), toString());
		DLoginFailed(RC_LOGIN_FAILED, retPacket);
		return ;
	}

	CWorldMapPlayer* mapPlayer = NULL;
	TSceneID_t sceneID = INVALID_SCENE_ID;
	CScene* pScene = NULL;
	TMapID_t mapID = INVALID_MAP_ID;
	TAxisPos pos = INVALID_AXIS_POS_T;
	// 获取场景
	{
		// 正常进入游戏
		pScene = DSceneMgr.findScene(pLoginRole->getSceneID());
		// 暂做负载均衡
		if( true || NULL == pScene || !pScene->canEnter(pLoginRole->logoutTime) || !enterDynamicMapFlag)  // 无法进入到上次下线的场景
		{
			// @TODO 无法进入正常场景，进入指定场景
			gxWarning("Can't enter other scene!SceneID={0}, {1}", pLoginRole->sceneID, toString());
			mapID = pLoginRole->getMapID();
// 			CServerParamConfigTbl* serverParamConfig = DServerParamTblMgr.getConfig();
// 			if ( serverParamConfig == NULL )
// 			{
// 				gxError("Can't find server param config!!!");
// 				gxAssert(false);
// 				DLoginFailed(RC_LOGIN_NO_MAP, retPacket);
// 				return ;
// 			}
// 			if ( mapID == INVALID_MAP_ID )
// 			{
// 				mapID = serverParamConfig->exceptionPos.mapID;
// 				pLoginRole->pos = serverParamConfig->exceptionPos.pos;
// 			}
// 			else if ( pLoginRole->isDynamicMap() )
// 			{
// 				// 处于动态场景中, 则获取踢出坐标
// 				CMapConfigTbl* mapConfig = DWorldMapTblMgr.find(mapID);
// 				if ( mapConfig == NULL || mapConfig->kickPos.size() < 2 )
// 				{
// 					gxError("Can't find mapID in map config table OR kick pos param is less than 2!!! mapID = %u", mapID);
// 					gxAssert(false);
// 					DLoginFailed(RC_LOGIN_NO_MAP, retPacket);
// 					return ;
// 				}
// 				uint8 index = 0;
// 				if ( pLoginRole->level > serverParamConfig->transmitLevel )
// 				{
// 					index = 1;
// 				}
// 				TMapIDRangePos& tempKickPos = mapConfig->kickPos[index];
// 				mapID = tempKickPos.mapID;
// 				pLoginRole->pos = tempKickPos.pos;
// 			}
// 
			pScene = DSceneMgr.getEmptyScene(mapID);
			if(NULL == pScene)
			{
				gxError("Can't find scene!{0},MapID={1},{2}", pLoginRole->toString(), pLoginRole->getMapID(), toString());
				mapID = pNewRoleRow->mapID;
				pScene = DSceneMgr.getEmptyScene(mapID);
			}
			if(NULL == pScene)
			{
				DLoginFailed(RC_LOGIN_NO_MAP, retPacket);
				return;
			}

			gxAssert(CGameMisc::GetMapID(pScene->getSceneID()) == mapID);
		}
		gxAssert(pLoginRole->pos.isValid());
		// 获取地图服务器
		mapPlayer = DWorldMapPlayerMgr.findMapPlayer(pScene->getMapServerID());
		pos = pLoginRole->pos;
	}

	if(NULL != pScene)
	{
		sceneID = pScene->getSceneID();
		mapID = CGameMisc::GetMapID(pScene->getSceneID());
		gxInfo("Get scene!SceneID={0},{1},{2}", pScene->getSceneID(), toString(), pos.toString());
	}

	if (NULL == mapPlayer)
	{
		gxError("Can't find map server!{0}", toString());
		DLoginFailed(RC_LOGIN_NO_MAP_SERVER, retPacket);
		return;
	}

	// 进入对应的地图服务器
	if(!mapPlayer->enter(pScene, sceneID, this))
	{
		gxError("Can't enter scene!{0}", pLoginRole->toString());
		DLoginFailed(RC_LOGIN_NO_MAP, retPacket);
		return;
	}

	gxInfo("Player request role enter game!{0}", toString());

	loadRoleDataReq(mapPlayer, LOAD_ROLE_TYPE_LOGIN, sceneID, pos, pScene == NULL, mapID);
	setPlayerStatus(PS_LOGIN_GAME_REQ);
}

EGameRetCode CWorldPlayer::loginGameRes( CWorldUserData* data, TServerID_t mapServerID )
{
	gxAssertEx(_playerStatus == PS_LOGIN_GAME_REQ, "PlayerStatus={0}", (uint32)_playerStatus);
	gxInfo("Login response, player load role data ok!{0}", toString());
	CWorldUser* pUser = DWorldUserMgr.addUser(getCurrentObjUID(), mapServerID, data);
	if (NULL == pUser) {
		gxError("Can't add CWorldUser! {0}", data->toString());
		setPlayerStatus(PS_VERIFY_PASS);
		return RC_LOGIN_NO_MAP;
	}

	setPlayerStatus(PS_LOGIN_GAME);
	_mapServerID = mapServerID;
	_lastHeartTime = DTimeManager.nowSysTime();

// 	for(sint32 i = 0; i < 10; ++i)
// 	{
// 		DRecordeFuncMgr.saveTestLogin(DBR_LOGINDATAEX_TBL, DTimeManager.nowSysTime());
// 	}

//	DCWRecordeManager.handleLoginInsterData(this);

	return RC_SUCCESS;
}

void CWorldPlayer::transLimitInfo(void)
{
	if( IsHasLoginServer() )
	{
		GetLoginServer(true)->sendRoleLimit(getAccountID(), getCurrentRoleUID(), DWorldServer->getWorldServerID() );
	}
	return ;
}

void CWorldPlayer::loadRoleDataReq( CWorldMapPlayer* mapPlayer, ELoadRoleType loadType, TSceneID_t sceneID, TAxisPos& pos, bool needOpenMap, TMapID_t mapID )
{
	gxAssert(pos.isValid());
	gxAssert((sceneID != INVALID_SCENE_ID && mapID != INVALID_MAP_ID && needOpenMap == false) 
		|| (sceneID == INVALID_SCENE_ID && needOpenMap == true && mapID != INVALID_MAP_ID));

	TObjUID_t objUID = getCurrentObjUID();
	onBerforeLoadRoleData(objUID, sceneID, mapID);

	// 请求登陆地图服务器
	WMLoadRoleData loadPacket;
	loadPacket.loadData.accountID = getAccountID();
	loadPacket.loadData.roleUID = getCurrentRoleUID();
	loadPacket.loadData.objUID = objUID;
	loadPacket.loadData.loadType = loadType;
	loadPacket.loadData.sceneID = sceneID;
	loadPacket.loadData.pos = pos;
	loadPacket.loadData.mapID = mapID;
	loadPacket.loadData.needOpenMap = needOpenMap;
	loadPacket.socketIndex = getSocketIndex();

	memcpy(&loadPacket.changeLineTempData, &_changeLineTempData, sizeof(_changeLineTempData));

	gxAssert(pos.isValid());
	_changeLineTempData.cleanUp();
	gxInfo("Send load role data pack request!{0},MapServerID={1},MapID={2}", toString(), mapPlayer->getServerID(), mapID);
	mapPlayer->sendPacket(loadPacket);

//	getLoginManager().push(LOAD_ROLE_TYPE_LOGIN, getSocketIndex());
}

EGameRetCode CWorldPlayer::loadRoleDataSuccess(CWorldUserData* data, TServerID_t mapServerID, TMapID_t mapID)
{
	CWorldMapPlayer* pMapServer = DWorldMapPlayerMgr.findMapPlayer(getMapServerID());
	if(NULL == pMapServer)
	{
		gxError("Can't find world map server!{0}", toString());
		return RC_LOGIN_FAILED;
	}

	pMapServer->setRoleSceneID(getCurrentRoleUID(), data->sceneID);

	switch(_playerStatus)
	{
	case PS_LOGIN_GAME_REQ:
		{
			return loginGameRes(data, mapServerID);
		}break;
	case PS_CHANGE_LINE_LOAD_REQ:
		{
			return changeLineLoadRes(data, mapServerID, mapID);
		}break;
	default:
		{
		}
	}

	return RC_SUCCESS;
}

bool CWorldPlayer::loadRoleDataFailed(const TLoadRoleData* loadData, EGameRetCode retCode)
{
	gxWarning("Load role data failed!{0},{1}", toString(), loadData->toString());

	// 获取地图服务器对象
	CWorldMapPlayer* mapPlayer = DWorldMapPlayerMgr.findMapPlayer(getMapServerID());
	if (NULL != mapPlayer) 
	{
		mapPlayer->leave(this);
	}
	else
	{
		gxError("Can't find world map player!{0}", toString());
		gxAssert(false);
	}
	// @TODO 进入动态场景
// 	CMapConfigTbl* pMapConfig = DWorldMapTblMgr.find(CGameMisc::GetMapID(loadData.sceneID));
// 	if(isLoadRoleDataStatus() && NULL != pMapConfig && CGameMisc::IsDynamicMap((ESceneType)pMapConfig->mapType) && getCurrentRoleUID() != INVALID_ROLE_UID)
// 	{
// 		// 进入动态地图加载角色数据失败
// 		switch(_playerStatus)
// 		{
// 		case PS_CHANGE_LINE_LOAD_REQ:
// 			{
// 				// 换线失败, 直接T掉
// 				setPlayerStatus(PS_QUIT);
// 				return false;
// 			}
// 			break;
// 		case PS_LOGIN_GAME_REQ:
// 			{
// 				// 选择角色登陆, 尝试进入普通地图
// 				gxInfo("First login failed, retry login!%s,%s", toString(), loadData.toString().c_str());
// 				setPlayerStatus(PS_VERIFY_PASS);
// 				loginGameReq(getCurrentRoleUID(), false);
// 				return true;
// 			}break;
// 		default:
// 			{
// 
// 			}
// 		}
// 
// 		return false;
// 	}
//	else
	{
		WCLoginGameRet loginGameRet;
		loginGameRet.setRetCode(retCode);
		// 进入普通地图失败, 直接返回
		setPlayerStatus(PS_VERIFY_PASS);
		sendPacket(loginGameRet);
		return true;
	}

	return false;
}

void CWorldPlayer::loginQuitReq()
{
	WCLoginQuitRet loginQuitRet;
	if(isRequstStatus())
	{
		gxError("Login game quit failed, is in request!{0}", toString());
		loginQuitRet.setRetCode(RC_LOGIN_REQUEST_WAIT);
		sendPacket(loginQuitRet);
		return;
	}

	if(!isValid())
	{
		gxError("Login game quit failed, player is invalid!{0}", toString());
		loginQuitRet.setRetCode(RC_LOGIN_REQUEST_FAILED);
		sendPacket(loginQuitRet);
		quit(false, "Login game quit invalid!");
		return;
	}

//	gxAssertEx(_playerStatus == PS_LOGIN_GAME || _playerStatus == PS_PLAYING_GAME, "PlayerStatus={0}", (uint32)getPlayerStatus());

	//     EGameRetCode retCode = onBeforeRequst(PA_LOGIN_QUIT_REQ);
	//     if(!IsSuccess(retCode))
	//     {
	//         gxError("Login game quit failed, can't pass before request check!%s", toString());
	//         loginQuitRet.setRetCode(retCode);
	//         sendPacket(loginQuitRet);
	//         return;
	//     }

	gxInfo("Play request login quit!{0}", toString());
	if (isLoginGame())
	{
		loginQuitRet.setRetCode(RC_SUCCESS);
		sendPacket(loginQuitRet);
		cleanSocketHandler();
		setPlayerStatus(PS_PLAYING_GAME);
	}
	else
	{
		quit(false, "Login quit failed");
	}
}

bool CWorldPlayer::isAccountVerifyStatus() {
	if (_playerStatus == PS_INVALID
		|| _playerStatus == PS_IDLE
		|| _playerStatus == PS_VERIFY_PASS) 
	{
		return true;
	}

	return false;
}

bool CWorldPlayer::isEnterGame()
{
	if ((_playerStatus == PS_LOGIN_GAME
		|| _playerStatus == PS_PLAYING_GAME
		|| _playerStatus == PS_CHANGE_LINE_WAIT)) 
	{
		return true;
	}

	return false;
}

bool CWorldPlayer::isDataNeedFreeStatus() 
{
	if ((_playerStatus == PS_LOGIN_GAME
		|| _playerStatus == PS_PLAYING_GAME
		|| _playerStatus == PS_CHANGE_LINE_WAIT)
		) 
	{
		return true;
	}

	return false;
}

bool CWorldPlayer::unloadRoleDataReq(EUnloadRoleType unloadType, bool flag)
{
	gxAssertEx(!isRequstStatus(), "{0}", toString());
	gxAssert(_playerStatus == PS_LOGIN_GAME || _playerStatus == PS_PLAYING_GAME || _playerStatus == PS_CHANGE_LINE_WAIT);
	if(!flag)
	{
		gxAssertEx(isDataNeedFreeStatus(), "{0}", toString());
		if(!isDataNeedFreeStatus())
		{
			gxError("Data is not need unload!{0}", toString());
			return true;
		}
	}

	CWorldUser* user = DWorldUserMgr.findUserByObjUID(getCurrentObjUID());
	if (NULL == user) 
	{
		gxError("Can't find User! {0}, ObjUID={1}", toString(), getCurrentObjUID());
		return false;
	}

	CWorldMapPlayer* mapPlayer = DWorldMapPlayerMgr.findMapPlayer(user->getMapServerID());
	if (NULL == mapPlayer)
	{
		gxError("Can't find MapPlayer! {0}, MapServerID={1}", toString(), (uint32)user->getMapServerID());
		return false;
	}

	gxInfo("Unload role data: {0}", toString());

	if(!(getLoginManager()->isLogin() || getLoginManager()->isLogout()))
	{
		// 没有登陆或者退出请求, 直接让服务器退出
		WMUnloadRoleData unloadPacket;
		unloadPacket.socketIndex = getSocketIndex();
		unloadPacket.unloadType = unloadType;
		unloadPacket.accountID = _accountID;
		unloadPacket.roleUID = getCurrentRoleUID();
		unloadPacket.objUID = getCurrentObjUID();
		unloadPacket.needRet = flag;
		mapPlayer->sendPacket(unloadPacket);
	}
	
	_unloadType = unloadType;			// @TODO 成员函数

	switch( unloadType )
	{
	case UNLOAD_ROLE_TYPE_CHANGE_LINE:
		{
			setPlayerStatus(PS_CHANGE_LINE_UNLOAD_REQ);
		}break;
	case UNLOAD_ROLE_TYPE_KICK_BY_OTHER:
	case  UNLOAD_ROLE_TYPE_QUIT:
	default:
		setPlayerStatus(PS_QUIT_REQ);
		break;
	}
//	getLoginManager().push(unloadType, true, getSocketIndex());	// @TODO 仔细考虑切线流程

	return true;
}

EGameRetCode CWorldPlayer::unloadRoleDataSuccess(TRoleUID_t roleUID) 
{
	gxInfo("Unload role data ret! {0}", toString());

	switch(_playerStatus)
	{
	case PS_QUIT_REQ:
		{
			quitGameRes();
		}break;
	case PS_CHANGE_LINE_UNLOAD_REQ:
		{
			changeLineUnloadRes();
		}break;
	default:
		{
			quit(true, "");
		}
	}

	return RC_SUCCESS;
}

void CWorldPlayer::unloadRoleDataFailed( TRoleUID_t roleUID )
{
	gxError("Unload role data failed!{0}", toString());
	switch(_playerStatus)
	{
	case PS_QUIT_REQ:
	case PS_CHANGE_LINE_UNLOAD_REQ:
		{
			setPlayerStatus(PS_QUIT);
		}
		break;
	default:
		{

		}
	}

	quit(true, "Unload failed!");
}

TServerID_t CWorldPlayer::getMapServerID() {
	return _mapServerID;
}

void CWorldPlayer::setMapServerID(TServerID_t mapServerID) {
	_mapServerID = mapServerID;
}

void CWorldPlayer::addRole(TLoginRole* role) {
	_roleList.addRole(role);
}

sint32 CWorldPlayer::getRoleNum()
{
	return _roleList.size();
}

void CWorldPlayer::onQuit(TAccountID_t accountID) {
	CLoginPlayer* loginPlayer = DLoginPlayerMgr.findByAccountID(accountID);
	if (NULL != loginPlayer) {
		loginPlayer->otherPlayerOffline();
	}
}

void CWorldPlayer::cleanAll() 
{
	gxInfo("Clear all player data! {0}", toString());
	TAccountID_t accountID = getAccountID();
	gxAssert(isDataHasFreedStatus());
	if (!isDataHasFreedStatus()) 
	{
		gxError("Player data is not freed! {0}", toString());
	}
	unloadRoleDataAll();
	cleanRole();
	cleanSocketHandler();
	cleanDbHandler();
	clean();
	onQuit(accountID);
}

void CWorldPlayer::setInvalid(EUnloadRoleType unloadType)
{
	_valid = false;
	_unloadType = unloadType;
}

bool CWorldPlayer::isValid()
{
	return _valid;
}

bool CWorldPlayer::isDataHasFreedStatus()
{
	if (isAccountVerifyStatus() || _playerStatus == PS_QUIT)
	{
		return true;
	}

	return false;
}

bool CWorldPlayer::isLoadRoleDataReq()
{
	return _playerStatus == PS_QUIT_REQ;
}

bool CWorldPlayer::kickByOtherPlayer()
{
	gxWarning("Kick old player!{0}", toString());

	setInvalid(UNLOAD_ROLE_TYPE_KICK_BY_OTHER);

	if(isRequstStatus())
	{
		// 处于请求状态, 需要等待请求返回才能继续
		gxWarning("Kick by other, player is request status!{0}", toString());
		return false;
	}

	if(isDataNeedFreeStatus())
	{
		unloadRoleDataReq(UNLOAD_ROLE_TYPE_KICK_BY_OTHER, true);
		return false;
	}

	return true;
}

void CWorldPlayer::setPlayerStatus( EPlayerStatus status )
{
	//    gxWarning("Change status!OldStatus=%u,NewStatus=%u,%s", _playerStatus, status, toString());
	_playerStatus = status;
	genStrName();
}

bool CWorldPlayer::isVerifyPass()
{
	return _playerStatus == PS_VERIFY_PASS;
}

bool CWorldPlayer::isPlaying()
{
	return _playerStatus == PS_PLAYING_GAME;
}

bool CWorldPlayer::isLoginGame()
{
	return _playerStatus == PS_LOGIN_GAME;
}

bool CWorldPlayer::isIdle()
{
	return _playerStatus == PS_IDLE;
}

void CWorldPlayer::onBeforeLogin( TServerID_t mapServerID )
{
	gxAssert(mapServerID != INVALID_SERVER_ID);
	_mapServerID = mapServerID;
	gxInfo("Player is before login!{0}", toString());
//	GetLoginServer()->sendRoleLogin(getLoginKey(), getAccountID(), getCurrentRoleUID(), getCurrentUser()->getName(), DWorldServer->getWorldServerID());
}

void CWorldPlayer::onAfterLogin( TServerID_t mapServerID)
{
	_mapServerID = mapServerID;
	gxInfo("Player is after login!{0}", toString());
}

bool CWorldPlayer::isRequstStatus()
{
	return _playerStatus == PS_CREATE_ROLE_REQ
		|| _playerStatus == PS_DELETE_ROLE_REQ
		|| _playerStatus == PS_LOGIN_GAME_REQ
		|| _playerStatus == PS_CHANGE_LINE_LOAD_REQ
		|| _playerStatus == PS_CHANGE_LINE_UNLOAD_REQ
		|| _playerStatus == PS_QUIT_REQ;
}

EGameRetCode CWorldPlayer::onBeforeRequst(EWPlayerActionType requstType)
{
	// 退出游戏请求直接返回
	if(requstType == PA_QUIT_GAME_REQ)
	{
		return RC_SUCCESS;
	}

	// 在当前状态下哪些请求可以执行
	switch(_playerStatus)
	{
	case PS_INVALID:
	case PS_IDLE:
		return RC_LOGIN_REQUEST_FAILED;
	case PS_VERIFY_PASS:	// 允许创建和删除角色及登陆游戏
		if(!(requstType == PA_CREATE_ROLE_REQ || requstType == PA_DELETE_ROEL_REQ || requstType == PA_LOGIN_GAME_REQ))
		{
			return RC_LOGIN_REQUEST_FAILED;
		}
		break;
	case PS_CREATE_ROLE_REQ:
	case PS_DELETE_ROLE_REQ:
	case PS_LOGIN_GAME_REQ:
		return RC_LOGIN_REQUEST_WAIT;
	case PS_LOGIN_GAME:
		if(requstType != PA_LOGIN_QUIT_REQ)
		{
			return RC_LOGIN_REQUEST_FAILED;
		}break;
	case PS_PLAYING_GAME:
		{
			// 处于游戏状态, 登陆流程不能再执行
			if(requstType == PA_CREATE_ROLE_REQ || requstType == PA_DELETE_ROEL_REQ || requstType == PA_LOGIN_GAME_REQ || requstType == PA_LOGIN_QUIT_REQ)
			{
				return RC_LOGIN_REQUEST_FAILED;
			}
		}break;
	case PS_CHANGE_LINE_UNLOAD_REQ:
	case PS_CHANGE_LINE_LOAD_REQ:
	case PS_CHANGE_LINE_WAIT:
		{
			return RC_LOGIN_REQUEST_FAILED;
		}break;
	case PS_QUIT_REQ:
	case PS_QUIT:
		{
			return RC_LOGIN_REQUEST_FAILED;
		}break;
	default:
		{
			gxAssert(false);
		}
	}

	return RC_SUCCESS;
}

EGameRetCode CWorldPlayer::onBeforeResponse(EWPlayerActionType requstType)
{
	gxAssertEx(isRequstStatus(), "{0}", toString());

	if(!isValid())
	{
		setPlayerStatus(PS_QUIT);
		quit(true, "Player is invalid!");
		return RC_FAILED;
	}

	return RC_SUCCESS;
}

void CWorldPlayer::onBerforeLoadRoleData( TObjUID_t objUID, TSceneID_t sceneID, TMapID_t mapID )
{
}

bool CWorldPlayer::onAddToEnter()
{
	_logintime	= DTimeManager.nowSysTime();
	_queType = MGR_QUE_TYPE_ENTER;
	_lastHeartTime = DTimeManager.nowSysTime();
	return true;
}

bool CWorldPlayer::onAddToReady()
{
	_queType = MGR_QUE_TYPE_READY;
	return true;
}

bool CWorldPlayer::onAddToLogout()
{
	_queType = MGR_QUE_TYPE_LOGOUT;
	return true;
}

void CWorldPlayer::onRemoveFromEnter()
{
	_queType = MGR_QUE_TYPE_INVALID;
}

void CWorldPlayer::onRemoveFromReady()
{
	_queType = MGR_QUE_TYPE_INVALID;
}

void CWorldPlayer::onRemoveFromLogout()
{
	_queType = MGR_QUE_TYPE_INVALID;
}

EManagerQueType CWorldPlayer::getQueType()
{
	return _queType;
}

EGameRetCode CWorldPlayer::changeLineReq( TSceneID_t sceneID, TAxisPos& pos, TServerID_t mapServerID, 
	TSceneID_t lastSceneID, TAxisPos& lastPos, TServerID_t lastMapServerID, TChangeLineTempData* tempData )
{
	FUNC_BEGIN(CHANGELINE_MOD);

	if(!checkRequest())
	{
		gxError("Change line request, hash in request!{0}", toString());
		return RC_MAP_CHANGE_LINE_FAILED;
	}

	if(_changeLineWait.changeLineFlag)
	{
		gxError("Open risk request, has in change line!{0}, {1}", toString(), _changeLineWait.toChangeLineString().c_str());
		return RC_MAP_CHANGE_LINE_WAIT;
	}

	if(_changeLineWait.openDynaMapFlag)
	{
		gxError("Open risk request, has in open dynamic map!{0}, {1}", toString(), _changeLineWait.toOpenMapString().c_str());
		return RC_MAP_OPENING_DYNAMAP;
	}

	// 切线流程: 1. 请求源服务器释放角色数据 2. 请求目标服务器加载角色数据
	// 查找目标地图
	CScene* pScene = DSceneMgr.findScene(sceneID);
	if(NULL == pScene)
	{
		pScene = DSceneMgr.getLeastScene(CGameMisc::GetMapID(sceneID), getMapServerID());
		if(NULL != pScene)
		{
			mapServerID = pScene->getMapServerID();
		}
	}
	if(NULL == pScene)
	{
		gxWarning("Can't find scene!{0}", toString());
		return RC_CHANGE_LINE_ROLE_FULL;
	}
	if(pScene->getMapServerID() != mapServerID)
	{
		gxWarning("Can't find map server!{0}", toString());
		return RC_CHANGE_LINE_ROLE_FULL;
	}

	CWorldUser* pUser = DWorldUserMgr.findUserByObjUID(getCurrentObjUID());
	if(NULL == pUser)
	{
		gxWarning("Can't find user!{0}", toString());
		return RC_CHANGE_LINE_ROLE_FULL;
	}

	EGameRetCode retCode = changeLineUnloadReq();
	if(!IsSuccess(retCode))
	{
		return retCode;
	}

	_changeLineTempData = *tempData;
	pUser->onBeforeChangeLine(&_changeLineTempData, pScene->getSceneType(), CGameMisc::GetMapID(sceneID));
	_changeLineWait.cleanUpChangeLine();
	_changeLineWait.startChangeLine(lastMapServerID, CGameMisc::GetMapID(lastSceneID), 
		lastSceneID, lastPos, pScene->getMapServerID(), pScene->getSceneID(), pos);
	gxInfo("Change line, source map server request!{0},{1}", toString(), _changeLineWait.toChangeLineString().c_str());
	setPlayerStatus(PS_CHANGE_LINE_UNLOAD_REQ);

	return RC_SUCCESS;

	FUNC_END(RC_FAILED);
}

EGameRetCode CWorldPlayer::changeLineUnloadRes()
{
	gxAssert(PS_CHANGE_LINE_UNLOAD_REQ == _playerStatus);
	// 释放源服务器角色数据成功
	EGameRetCode retCode = changeLineLoadReq();
	if(!IsSuccess(retCode))
	{
		gxError("Change line clean!{0}", toString());
		_changeLineWait.cleanUpChangeLine();
	}

	return retCode;
}

EGameRetCode CWorldPlayer::changeLineLoadRes(CWorldUserData* data, TServerID_t mapServerID, TMapID_t mapID)
{
	gxAssert(PS_CHANGE_LINE_LOAD_REQ == _playerStatus);
	EGameRetCode retCode = changeLineRes(mapServerID, mapID);
	if(!IsSuccess(retCode))
	{
		gxError("Change line clean!{0}", toString());
		_changeLineWait.cleanUpChangeLine();
	}

	return retCode;
}

EGameRetCode CWorldPlayer::changeLineLoadReq()
{
	FUNC_BEGIN(CHANGELINE_MOD);

	CScene* pScene = DSceneMgr.findScene(_changeLineWait.destSceneID);
	if(NULL == pScene)
	{
		gxError("Can't find scene!{0}, SceneID={1}", toString(), _changeLineWait.destSceneID);
		_changeLineWait.cleanUpChangeLine();
		return RC_MAP_NO_FIND_DEST_MAP;
	}

	CWorldMapPlayer* mapPlayer = DWorldMapPlayerMgr.findMapPlayer(pScene->getMapServerID());
	if(NULL == mapPlayer)
	{
		gxError("Can't find map server!{0}, MapServerID={1}", toString(), (uint32)pScene->getMapServerID());
		_changeLineWait.cleanUpChangeLine();
		return RC_LOGIN_NO_MAP_SERVER;
	}
	gxInfo("Change line, load role to destination map server!{0}, {1}", toString(), changeLineString().c_str());

	loadRoleDataReq(mapPlayer, LOAD_ROLE_TYPE_CHANGE_LINE, _changeLineWait.destSceneID, _changeLineWait.destPos, false, CGameMisc::GetMapID(_changeLineWait.destSceneID));
	setPlayerStatus(PS_CHANGE_LINE_LOAD_REQ);
	return RC_SUCCESS;

	FUNC_END(RC_FAILED);
}

EGameRetCode CWorldPlayer::changeLineUnloadReq()
{
	if(false == unloadRoleDataReq(UNLOAD_ROLE_TYPE_CHANGE_LINE))
	{
		gxWarning(CHANGELINE_MOD"Can't unload role data!{0}", toString());
		return RC_CHANGE_LINE_ROLE_FULL;
	}

	return RC_SUCCESS;
}

EGameRetCode CWorldPlayer::changeLineRes(TServerID_t mapServerID, TMapID_t mapID)
{
	FUNC_BEGIN(CHANGELINE_MOD);

	// 通过源服务器返回给客户端
	WMChangeLineRet changeLineRet;
	changeLineRet.setRetCode(RC_CHANGE_LINE_ROLE_FULL);
	changeLineRet.objUID = getCurrentObjUID();
	changeLineRet.mapID = CGameMisc::GetMapID(_changeLineWait.destSceneID);

	CWorldMapPlayer* srcMapPlayer = DWorldMapPlayerMgr.findMapPlayer(_changeLineWait.srcMapServerID);
	if(NULL == srcMapPlayer)
	{
		gxError("Can't find map server player!{0},{1}", toString(), changeLineString().c_str());
		return RC_CHANGE_LINE_ROLE_FULL;
	}

	CScene* pScene = DSceneMgr.findScene(_changeLineWait.destSceneID);
	if(NULL == pScene)
	{
		gxWarning("Can't find scene!{0},{1}", toString(), changeLineString().c_str());
		return RC_CHANGE_LINE_ROLE_FULL;
	}
	CWorldMapPlayer* mapPlayer = DWorldMapPlayerMgr.findMapPlayer(_changeLineWait.destMapServerID);
	if(NULL == mapPlayer)
	{
		gxError("Can't find map server player!{0},{1}", toString(), changeLineString().c_str());
		return RC_CHANGE_LINE_ROLE_FULL;
	}
	changeLineRet.setRetCode(RC_SUCCESS);
	changeLineRet.clientListenIP = mapPlayer->getClientListenIP();
	changeLineRet.clientListenPort = mapPlayer->getClientListenPort();
	sendToMapServer(changeLineRet);

	srcMapPlayer->leave(this);
	// 处理目标服务器的逻辑
	_mapServerID = _changeLineWait.destMapServerID;
	// 进入对应的地图服务器
	if(!mapPlayer->enter(pScene, _changeLineWait.destSceneID, this))
	{
		gxError("Can't enter scene!{0},{1}", toString(), changeLineString());
		return RC_CHANGE_LINE_ROLE_FULL;
	}
	gxAssert(CGameMisc::GetMapID(_changeLineWait.destSceneID) == mapID);
	gxAssert(_changeLineWait.destMapServerID == mapServerID);
	CWorldUser* pUser = DWorldUserMgr.findUserByObjUID(getCurrentObjUID());
	if(NULL != pUser)
	{
		pUser->setMapServerID(_mapServerID);
		pUser->onAfterChangeLine();
	}
	else
	{
		gxWarning("Can't find user!{0}", toString());
	}

	gxInfo("Change line, load dest map server role data success!{0},{1}", changeLineString(), toString());

	// 清除数据
	_changeLineWait.cleanUpChangeLine();
	_changeLineTempData.cleanUp();
	setPlayerStatus(PS_CHANGE_LINE_WAIT);           // 切线等待状态

	return RC_SUCCESS;

	FUNC_END(RC_FAILED);
}

// 开启副本请求
// EGameRetCode CWorldPlayer::openDynamicMapReq( TMapID_t mapID, ESceneType sceneType )
// {
// 	FUNC_BEGIN(SCENE_MOD);
// 
// 	if(_changeLineWait.changeLineFlag)
// 	{
// 		gxError("Open risk request, has in change line!%s, %s, MapID=%u,SceneType=%u", toString(), _changeLineWait.toChangeLineString().c_str(), mapID, sceneType);
// 		return RC_MAP_CHANGE_LINE_WAIT;
// 	}
// 
// 	if(_changeLineWait.openDynaMapFlag)
// 	{
// 		gxError("Open risk request, has in open dynamic map!%s, %s, MapID=%u,SceneType=%u", toString(), _changeLineWait.toOpenMapString().c_str(), mapID, sceneType);
// 		return RC_MAP_OPENING_DYNAMAP;
// 	}
// 
// 	if(!checkRequest())
// 	{
// 		gxError("Open risk request, hash in request!%s, MapID=%u,SceneType=%u", toString(), mapID, sceneType);
// 		return RC_MAP_CHANGE_LINE_FAILED;
// 	}
// 
// 	if(isChangeLineStatus())
// 	{
// 		gxError("Player is change line status!%s, MapID=%u,SceneType=%u", toString(), mapID, sceneType);
// 		return RC_MAP_CHANGE_LINE_WAIT;
// 	}
// 
// 	CWorldMapPlayer* player = DWorldMapPlayerMgr.getLeastDynamicServer();
// 	if(NULL == player)
// 	{
// 		gxError("Can't find risk map server!%s, MapID=%u,SceneType=%u", toString(), mapID, sceneType);
// 		return RC_FAILED;
// 	}
// 
// 	DSceneMgr.openDynamicScene(mapID, getCurrentObjUID());
// 	gxInfo("Send open dynamic map!MapID=%u,MapServerID=%u", mapID, player->getServerID());
// 	_changeLineWait.startOpenMap(mapID);
// 
// 	return RC_SUCCESS;
// 
// 	FUNC_END(RC_MAP_CHANGE_LINE_FAILED);
// }

void CWorldPlayer::quitGameReq( TRoleUID_t roleUID )
{
	FUNC_BEGIN(LOGIN_MOD);
	gxAssert(roleUID == getCurrentRoleUID());

	// 检查是否需要释放数据
	if(isRequstStatus())
	{
		gxInfo("Player is request status, set player invalid!{0}", toString());
		setInvalid(UNLOAD_ROLE_TYPE_QUIT);
		return;
	}

	if(isDataHasFreedStatus())
	{
		gxInfo("Player data is freed, quit!{0}", toString());
		quit(false, "Quit game request!");
		gxAssert(false);
		return;
	}

	if(isDataNeedFreeStatus())
	{
		gxInfo("Player data is need free, send unload request!{0}", toString());
		unloadRoleDataReq(UNLOAD_ROLE_TYPE_QUIT);
	}

	FUNC_END(DRET_NULL);
}

void CWorldPlayer::quitGameRes()
{
	gxAssert(PS_QUIT_REQ == _playerStatus);
	setPlayerStatus(PS_QUIT);
	quit(true, "Quit game success;");
}

static void UnloadRoleToAll(CWorldMapPlayer*& player, void* arg)
{
	WMUnloadRoleData* unloadPacket = (WMUnloadRoleData*)arg;
	if(NULL != player)
	{
		player->sendPacket(*unloadPacket);
	}
}

bool CWorldPlayer::unloadRoleDataAll()
{
	if(_playerStatus != PS_QUIT_REQ && _roleList.getCurrentRoleUID() != INVALID_ROLE_UID)
	{
		WMUnloadRoleData unloadPacket;
		unloadPacket.unloadType = UNLOAD_ROLE_TYPE_SYS_CHECK;
		unloadPacket.accountID = _accountID;
		unloadPacket.roleUID = getCurrentRoleUID();
		unloadPacket.objUID = getCurrentObjUID();
		unloadPacket.needRet = false;
		unloadPacket.socketIndex = GXMISC::INVALID_SOCKET_INDEX;

		DWorldMapPlayerMgr.traverse(&UnloadRoleToAll, &unloadPacket);
	}

	return true;
}

std::string CWorldPlayer::changeLineString()
{
	return GXMISC::gxToString("ChangeLineLastScene=%"I64_FMT"u,ChangeLineLastMapServer=%u,ChangeLineScene=%"I64_FMT"u,ChangeLineMapServer=%u"
		, _changeLineWait.srcSceneID, _changeLineWait.srcMapServerID, _changeLineWait.destSceneID, _changeLineWait.destMapServerID);
}

bool CWorldPlayer::isLoadRoleDataStatus()
{
	return _playerStatus == PS_LOGIN_GAME_REQ || PS_CHANGE_LINE_LOAD_REQ;
}

bool CWorldPlayer::isChangeLineStatus()
{
	return _playerStatus == PS_CHANGE_LINE_UNLOAD_REQ || _playerStatus == PS_CHANGE_LINE_LOAD_REQ || _playerStatus == PS_CHANGE_LINE_WAIT;
}

bool CWorldPlayer::checkRequest()
{
	FUNC_BEGIN(LOGIN_MOD);

	if(!isValid() || isRequstStatus())
	{
		return false;
	}

	return true;

	FUNC_END(false);
}

void CWorldPlayer::setChangeLine( TServerID_t mapServerID, TSceneID_t sceneID, const TAxisPos& pos )
{
	FUNC_BEGIN(LOGIN_MOD);

	_changeLineWait.destMapServerID = mapServerID;
	_changeLineWait.destSceneID = sceneID;
	_changeLineWait.destPos = pos;

	FUNC_END(DRET_NULL);
}

void CWorldPlayer::onUserLogin()
{
	FUNC_BEGIN(LOGIN_MOD);

	if(_playerStatus == PS_CHANGE_LINE_WAIT || _playerStatus == PS_LOGIN_GAME)
	{
		_playerStatus = PS_PLAYING_GAME;
	}

	FUNC_END(DRET_NULL);
}

void CWorldPlayer::onRoleHeart()
{
	FUNC_BEGIN(LOGIN_MOD);

	_lastHeartTime = DTimeManager.nowSysTime();
	std::string tempTime = (string)(GXMISC::CGameTime(_lastHeartTime));
//	gxDebug("Last heart time!Time={0}", tempTime);

	FUNC_END(DRET_NULL);
}

bool CWorldPlayer::heartOutTime()
{
	FUNC_BEGIN(LOGIN_MOD);
#ifndef OS_WINDOWS
	GXMISC::TGameTime_t curTime = DTimeManager.nowSysTime();
	if(getSocketHandler(false) != NULL)
	{
		// 与客户端的连接未断开, 等待断开
		if((curTime-_lastHeartTime) > g_GameConfig.maxWorldRoleHeartOutTime*10)
		{
			return true;
		}
	}
	else
	{
		// 与客户端的连接断开
		if((curTime-_lastHeartTime) > g_GameConfig.maxWorldRoleHeartOutTime)
		{
			std::string tempTime = (string)(GXMISC::CGameTime(_lastHeartTime));
			gxDebug("Last heart time!Time={0}", tempTime);
			return true;
		}
	}
#endif
	return false;

	FUNC_END(true);
}

TChangeLineWait* CWorldPlayer::getChangeLineWait()
{
	return &_changeLineWait;
}

void CWorldPlayer::update( GXMISC::TDiffTime_t diff )
{
	_changeLineWait.update();
}

bool CWorldPlayer::isRechargeStatus()
{
	return _rechargeFlag;
}

void CWorldPlayer::startRecharge()
{
	_rechargeFlag = true;
}

void CWorldPlayer::closeRecharge()
{
	_rechargeFlag = false;
}

EPlayerStatus CWorldPlayer::getPlayerStatus()
{
	return _playerStatus;
}


CWorldUser* CWorldPlayer::getCurrentUser()
{
	return DWorldUserMgr.findUserByRoleUID(getCurrentRoleUID());
}

void CWorldPlayer::setLoginKey( TLoginKey_t loginKey )
{
	_loginKey = loginKey;
}

TLoginKey_t CWorldPlayer::getLoginKey()
{
	return _loginKey;
}

TRoleUID_t CWorldPlayer::getFirstRoleUID()
{
	return _roleList.getFirstRoleUID();
}

void CWorldPlayer::setSourceWay( TSourceWayID_t sourceWay, TSourceWayID_t chisourceWay )
{
	_sourceWay = sourceWay;
	_chisourceWay = chisourceWay;
}
