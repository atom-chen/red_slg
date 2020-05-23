#include "core/game_exception.h"

#include "role.h"
#include "module_def.h"
#include "new_role_tbl.h"
#include "role_manager.h"
#include "packet_mw_base.h"
#include "map_world_handler_base.h"
#include "map_scene.h"
#include "map_db_player_handler.h"
#include "map_player_handler.h"
#include "map_data_tbl.h"
#include "map_world_handler.h"
#include "packet_cm_base.h"
#include "scene_manager.h"
#include "game_config.h"

CMapDbPlayerHandler* CRole::getDbHandler(bool isLogErr)
{
	return dynamic_cast<CMapDbPlayerHandler*>(getDbHandlerBase(isLogErr));
}
CMapPlayerHandler* CRole::getPlayerHandler(bool logFlag /* = true */ )
{
	return dynamic_cast<CMapPlayerHandler*>(getPlayerHandlerBase(logFlag));
}

CRoleScriptObject* CRole::getScriptHandler()
{
	return &_scriptObject;
}
void CRole::leaveScene(bool exitFlag)
{
	FUNC_BEGIN(ROLE_MOD);

	CMapScene* pScene = dynamic_cast<CMapScene*>(getScene());
	if(NULL != pScene)
	{
		pScene->leave(this, exitFlag);
	}

	FUNC_END(DRET_NULL);
}

bool CRole::enterScene( TMapID_t mapID )
{
	FUNC_BEGIN(SCENE_MOD);

	// 查找空的场景
	CMapScene* pScene = dynamic_cast<CMapScene*>(DSceneMgr.getLeastScene(mapID));
	if(NULL == pScene)
	{
		gxError("Can't find scene! SceneID={0}", getLoadWaitData()->destSceneID);
		return false;
	}

	// 进入场景
	gxAssert(getScene() == NULL);
	if( !pScene->enter(this) )
	{
		gxError("Can't enter scene!!! {0}, sceneID = {1}", toString(), pScene->getSceneID());
		return false;
	}

	return true;

	FUNC_END(false);
}

bool CRole::enterScene( TSceneID_t sceneID )
{
	FUNC_BEGIN(SCENE_MOD);

	// 找到场景
	CMapScene* pScene = dynamic_cast<CMapScene*>(DSceneMgr.findScene(getLoadWaitData()->destSceneID));
	if(NULL == pScene)
	{
		gxError("Can't find scene! SceneID={0}", getLoadWaitData()->destSceneID);
		return false;
	}

	// 进入场景
	gxAssert(getScene() == NULL);
	if( !pScene->enter(this) )
	{
		gxError("Can't enter scene!!! {0}, sceneID = {1}", toString(), pScene->getSceneID());
		return false;
	}

	return true;

	FUNC_END(false);
}

TRoleSceneRecord* CRole::getSceneRecord()
{
	return &_sceneRecord;
}

void CRole::kick(bool needSave, sint32 sockWaitTime, const std::string reason)
{
	FUNC_BEGIN(ROLE_MOD);

	gxError("Kick role!{0},{1}", toString(),reason);

	toWorldKick();

	_changeLineWait.cleanUp();

	if(needSave)
	{
		offlineSave(false, SAVE_ROEL_TYPE_OFFLINE);
	}

	setQuitRet(false);
	quit(true, "Kick!");
	resetLogoutTime(0);

	FUNC_END(DRET_NULL);
}

void CRole::toWorldKick()
{
	FUNC_BEGIN(ROLE_MOD);

	MWRoleKick roleKick;
	roleKick.accountID = getAccountID();
	roleKick.roleUID = getRoleUID();
	roleKick.socketIndex = getLoginPlayerSocketIndex();
	SendToWorld(roleKick);

	FUNC_END(DRET_NULL);
}

void CRole::directKick( bool needSave, bool delFromMgr, bool needRet, EKickType kickType )
{
	FUNC_BEGIN(ROLE_MOD);

	sendKickMsg(kickType);

	gxError("Direct kick role!{0}", toString());
	_changeLineWait.cleanUp();

	if(needSave)
	{
		offlineSave(false, SAVE_ROEL_TYPE_OFFLINE);
	}

	if(!needRet)
	{
		setQuitRet(false);
	}
	TRoleUID_t roleUID = getRoleUID();
	quit(true, "Direct kick!", 1);
	if(!delFromMgr)
	{
		resetLogoutTime(0);
	}
	else
	{
		DRoleManager.delRole(roleUID);
	}

	FUNC_END(DRET_NULL);
}

void CRole::quit(bool forceQuit, const char* quitResult, sint32 sockWaitTime)
{
	FUNC_BEGIN(ROLE_MOD);

	if(forceQuit)
	{
		setQuitRet(false);
	}

	_changeLineWait.cleanUp();

	if(isLogout())
	{
		cleanAll(sockWaitTime);
		return;
	}

	if(isReady())
	{
		// 添加到退出队列中
		addRoleToLogout();
		resetLogoutTime(0);
		return;
	}

	// 将角色移动到登出队列
	if(quitResult != NULL)
	{
		gxInfo("Role quit!Result={0},{1}", quitResult, toString());
	}
	else
	{
		gxInfo("Role quit!{0}", toString());
	}

	// 本地登陆, 无需返回
	if (_isLocalServerLogin)
	{
		setQuitRet(false);
	}

	if(!forceQuit)		// @todo force quit!考虑强制退出时多线程访问更新数据
	{
		switch (getStatus())
		{
		case ROLE_STATUS_LOAD:			// 数据加载成功
			{
				quitOnLoadData();
			}break;
		case ROLE_STATUS_ENTER:			// 进入游戏状态
			{
				quitOnEnter();
			}break;
		case ROLE_STATUS_ENTER_SCENE:	// 进入场景状态
			{
				quitOnEnterScene();
			}break;
		case ROLE_STATUS_CHANGE_MAP:	// 切换地图
			{
				quitOnChangeMap();
			}break;
		case ROLE_STATUS_SAVE:			// 保存数据
			{
				quitOnSave();
			}break;
		case ROLE_STATUS_QUIT_REQ:      // 退出请求
			{
				quitOnQuitReq();
			}break;
		case ROLE_STATUS_QUTI:			// 退出
			{
				quitOnQuit();
			}break;
		case ROLE_STATUS_INVALID:
			{
				quitSuccess();
			}break;
		default:
			{
				gxAssertEx(false, "Role status={0}", (uint32)getStatus());
				offlineSave(getQuitRet(), SAVE_ROEL_TYPE_OFFLINE);
			}
		}
	}
	else
	{
		quitSuccess();
		resetLogoutTime(0);
	}

	addRoleToLogout();

	if(!getQuitRet())
	{
		resetLogoutTime(0);
	}

	setActive(false);
	leaveScene(false);

	FUNC_END(DRET_NULL);
}

/**
 * 退出处理
 * 1. 离开场景
 * 2. 保存数据
 * 3. 添加到登出队列
 */
void CRole::onQuitHandle(ESaveRoleType roleType)
{
	FUNC_BEGIN(ROLE_MOD);

	if(isLogout())
	{
		// 登出队列处理
		gxAssert(getScene() == NULL);
		gxAssert(!isActive());
		return;
	}

	if(isReady())
	{
		// 准备队列处理
		gxAssert(getScene() == NULL);
		if(getScene() != NULL)
		{
			leaveScene(true);
		}
		gxAssert(!isActive());
		if(!isActive())
		{
			setActive(false);
		}
		addRoleToLogout();
		return;
	}

	if(isEnter())
	{
		// 登入队列处理
		offlineSave(true, roleType);
		if(getScene() != NULL)
		{
			leaveScene(true);
			setActive(false);
		}
		
		addRoleToLogout();
	}

	FUNC_END(DRET_NULL);
}

bool CRole::isWaitOffline()
{
	FUNC_BEGIN(ROLE_MOD);

	return getStatus() == ROLE_STATUS_CHANGE_MAP;

	FUNC_END(false);
}

void CRole::sendUnloadRet(EGameRetCode ret)
{
	if(!getQuitRet())
	{
		return;
	}

	gxInfo("Send unload ret!{0}", toString());

	EUnloadRoleType unloadType = UNLOAD_ROLE_TYPE_QUIT;
	switch (getStatus())
	{
	case ROEL_STATUS_KICK_BY_OTHER:
		{
			unloadType = UNLOAD_ROLE_TYPE_KICK_BY_OTHER;
		}break;
	case ROLE_STATUS_CHANGE_MAP:
		{
			unloadType = UNLOAD_ROLE_TYPE_CHANGE_LINE;
		}break;
	default:
		{
		}
	}

	if (!_isLocalServerLogin)
	{
		if (CMapWorldServerHandlerBase::IsActive())
		{
			DMapWorldPlayer->sendUnloadDataRet(unloadType, getAccountID(), getRoleUID(), getLoginPlayerSocketIndex());
		}
		else
		{
			gxError("Send unload return, map world handler is unactive!{0}", toString());
		}
	}
	else
	{
		gxAssert(getQuitRet() == false);
	}

	setQuitRet(false);
}

void CRole::quitGame()
{
	if(CMapWorldServerHandlerBase::IsActive())
	{
		if(!isWaitOffline() && !isLogout() && getStatus() != ROLE_STATUS_QUIT_REQ)
		{
			DMapWorldPlayer->sendRoleQuit(getAccountID(), getObjUID(), getRoleUID(), getLoginPlayerSocketIndex());
			setStatus(ROLE_STATUS_QUIT_REQ);
		}
		else
		{
			gxError("Wait offline or logout!{0}", toString());
		}
	}
	else
	{
		quit(true, "World server close!");
	}

	_changeLineWait.cleanUp();
}

void CRole::onUnloadRole( EUnloadRoleType unloadType, bool needRet )
{
	// 发送通知消息
	if(unloadType == UNLOAD_ROLE_TYPE_KICK_BY_OTHER)
	{
		sendKickMsg(KICK_TYPE_BY_OTHER);
	}
	else if(unloadType == UNLOAD_ROLE_TYPE_GM)
	{
		sendKickMsg(KICK_TYPE_BY_GM);
	}
	else
	{
		sendKickMsg(KICK_TYPE_ERR);
	}

	setQuitRet(needRet);
	switch(unloadType)
	{
	case UNLOAD_ROLE_TYPE_CHANGE_LINE:      // 切线释放数据
		{
			onChangeLineUnload();
		}break;
	case UNLOAD_ROLE_TYPE_QUIT:             // 正常退出
		{
			onQuitUnload();
		}break;
	case  UNLOAD_ROLE_TYPE_KICK_BY_OTHER:   // 被其他玩家挤下线
		{
			onKickByOtherUnload();
		}break;
	case UNLOAD_ROLE_TYPE_GM:				// GM封号
		{
		}break;
	case UNLOAD_ROLE_TYPE_SYS_CHECK:        // 系统检测
		{
			if(!isLogout())
			{
				onQuitUnload();
			}
		}break;
	default:
		{
		}
	}
}

void CRole::cleanAll(sint32 sockWaitTime)
{
	leaveScene(false);
	_changeLineWait.cleanUp();
	closeDbHandler();
	closeSocketHandler(sockWaitTime);
}

void CRole::heartToWorld(GXMISC::TDiffTime_t diff)
{
	FUNC_BEGIN(ROLE_MOD);

	if(!_heartToWorldTimer.update(diff))
	{
		return;
	}
	_heartToWorldTimer.reset();

//	if(isEnter() || isReady())
	{
// 		MWRoleHeart roleHeart;
// 		roleHeart.accountID = getAccountID();
// 		roleHeart.roleUID = getRoleUID();
// 
// 		SendToWorld(roleHeart);
	}

	FUNC_END(DRET_NULL);
}

void CRole::saveRet()
{
	FUNC_BEGIN(ROLE_MOD);

	gxInfo("Role save ret!{0}", toString());
	quitSuccess();

	FUNC_END(DRET_NULL);
}

void CRole::offlineSave(bool saveNeedRet, ESaveRoleType saveType)
{
	FUNC_BEGIN(ROLE_MOD);

	if(isReady())
	{
		gxError("Offline save, but in ready queue!{0}", toString());
		gxAssertEx(false, "{0}", toString());
		return;
	}

	if(isLogout())
	{
		gxError("Offline save, but in logout queue!{0}", toString());
		return;
	}

	gxInfo("Role save data! {0}", toString());

	// 保存角色数据到数据库
	CMapDbPlayerHandler* dbHandler = getDbHandler();
	if(NULL == dbHandler)
	{
		return;
	}
	onSave(true);
	// 保存角色数据
	dbHandler->sendSaveRoleData(getHumanDB(), getLoginPlayerSocketIndex(), saveNeedRet, saveType);

	FUNC_END(DRET_NULL);
}

void CRole::quitSuccess()
{
	FUNC_BEGIN(ROLE_MOD);

//	gxAssert(isLogout() || isReady());

	if(isEnter())
	{
		offlineSave(false, SAVE_ROEL_TYPE_OFFLINE);
		addRoleToLogout();
	}

	if(isWaitOffline())
	{
		gxAssert(getQuitRet() == true);
		resetLogoutTime(MAX_ROLE_LOGOUT_TIME*5);
	}
	else
	{
		_changeLineWait.cleanUp();
		resetLogoutTime(0);
	}

	closeDbHandler();
	if(getQuitRet())
	{
		sendUnloadRet(RC_SUCCESS);
	}

	onQuit();

	FUNC_END(DRET_NULL);
}

void CRole::onChangeLineUnload()
{
	gxInfo("Change line unload role data!{0}", _changeLineWait.toChangeLineString().c_str());
	_changeLineWait.cleanUp();
	// 检测角色状态 @todo
	quit(false, "Change line unload!");
	setStatus(ROLE_STATUS_CHANGE_MAP);
	resetLogoutTime(MAX_ROLE_LOGOUT_TIME*5);
}

void CRole::onQuitUnload()
{
	// 检测角色状态 @todo
	quit(false, "Unload quit!");
	setStatus(ROLE_STATUS_QUTI);
}

void CRole::onKickByOtherUnload()
{
	// 检测角色状态 @todo
	quit(false, "Kick by other!");
	setStatus(ROEL_STATUS_KICK_BY_OTHER);
}

void CRole::closeSocketHandler(sint32 sockWaitTime)
{
	CMapPlayerHandler* playerHandler = getPlayerHandler(false);
	if(NULL == playerHandler)
	{
		return;
	}
	gxInfo("Close socket handler! {0}", toString());
	playerHandler->quit(sockWaitTime);
	setSocketIndex(GXMISC::INVALID_SOCKET_INDEX);
}

void CRole::closeDbHandler()
{
	CMapDbPlayerHandler* dbHandler = getDbHandler(false);
	if(NULL == dbHandler)
	{
		return;
	}
	gxInfo("Close database handler!{0}", toString());
	dbHandler->quit();
	setDbIndex(GXMISC::INVALID_DB_INDEX);
}

void CRole::quitOnLoadData()
{
	quitSuccess();
}

void CRole::quitOnEnter()
{
	quitSuccess();
}

void CRole::quitOnEnterScene()
{
	offlineSave(getQuitRet(), SAVE_ROEL_TYPE_OFFLINE);
}

void CRole::quitOnChangeMap()
{
	offlineSave(getQuitRet(), SAVE_ROEL_TYPE_OFFLINE);
}

void CRole::quitOnSave()
{
}

void CRole::quitOnQuit()
{
	quitSuccess();
	setStatus(ROLE_STATUS_INVALID);
}

void CRole::quitOnQuitReq()
{
	offlineSave(getQuitRet(), SAVE_ROEL_TYPE_OFFLINE);
}

void CRole::initCharacter()
{
	FUNC_BEGIN(ROLE_MOD);
	
	refreshFast(false);

	TCharacterInit inits;
//	inits.dir = getHumanBaseData()->getDir();
//	inits.job = getHumanBaseData()->getJob();

	inits.axisPos = *getHumanBaseData()->getMapPos();
	inits.exp = getHumanBaseData()->getExp();
	inits.level = getHumanBaseData()->getLevel();
	inits.mapID = getHumanBaseData()->getMapID();
	inits.moveSpeed = GetConstant<TMoveSpeed_t>(ROLE_MOVE_SPEED);
	inits.objGUID = getRoleUID();
	inits.objUID = getObjUID();
	inits.type = OBJ_TYPE_ROLE;
	inits.die = false;

	init(&inits);

	FUNC_END(DRET_NULL);
}

void CRole::getScenData( CArray1<TNPCTypeID_t>* npcs, CArray1<TTransportTypeID_t>* trans )
{
	FUNC_BEGIN(ROLE_MOD);

	if(NULL == getScene()){
		return;
	}

	npcs->pushCont(*getScene()->getMapData()->getNpcs());
	trans->pushCont(*getScene()->getMapData()->getTransports());

	FUNC_END(DRET_NULL);
}

bool CRole::onScene(CMapScene* pScene)
{
	gxAssert(!isFight());

	getHumanBaseData()->setMapPos(&getLoadWaitData()->pos);
	getHumanBaseData()->setSceneID(pScene->getSceneID());
	setStatus(ROLE_STATUS_ENTER_SCENE);
	
	_changeLineWait.cleanUp();

	return true;
}

bool CRole::onEnter()
{
	setStatus(ROLE_STATUS_ENTER);
	CMapConfigTbl* mapConfig = DMapTblMgr.find(getMapID());
	if ( mapConfig == NULL )
	{
		gxError("Can't find map config!!! mapID = {0}", getMapID());
		return false;
	}
	return true;
}

bool CRole::onBeforeChangeMap( TSceneID_t sceneID, const TAxisPos* pos, ELoadRoleType changeType, ETeleportType type )
{
	onChangeMap(sceneID, pos, type);
	return true;
}

bool CRole::onChangeMap(TSceneID_t sceneID, const TAxisPos* pos, ETeleportType type)
{
	// 切线也会调用此函数, 此函数在切换前调用 ！！！
	setStatus(ROLE_STATUS_CHANGE_MAP);
	if(sceneID != getSceneID())
	{
		getHumanBaseData()->setLastSceneID(getSceneID());
		getHumanBaseData()->setLastMapID(CGameMisc::GetMapID(getSceneID()));
		getHumanBaseData()->setLastMapPos(getAxisPos());
	}
	return true;
}

bool CRole::onAfterChangeMap( TSceneID_t sceneID, const TAxisPos* pos, ELoadRoleType changeType, ETeleportType type )
{
	// @TODO 切换地图后
// 	_canMoveFlag = false;
// 	_initFlag = false;

	return true;
}

bool CRole::onQuit()
{
	setStatus(ROLE_STATUS_QUTI);
	return true;
}

bool CRole::onBeforeChangeLine( TChangeLineTempData* tempData, TMapID_t mapID, const TAxisPos* pos, TServerID_t mapServerID, ETeleportType type )
{
	FUNC_BEGIN(CHANGELINE_MOD);

	tempData->pos = *getAxisPos();
	tempData->mapID = getMapID();
	CMapConfigTbl* pMapConfig = DMapTblMgr.find(mapID);
	gxInfo("On before change line!!! beforeSrcPosX = {0}, beforeSrcPosY = {1}, beforeMapID = {2}, objUID = {3}, roleName = {4}",
		tempData->pos.x, tempData->pos.y, tempData->mapID, getObjUID(), getHumanBaseData()->getRoleName());

	onBeforeChangeMap(CGameMisc::GenSceneID(mapServerID,pMapConfig->mapType,mapID, INVALID_COPY_ID), pos, LOAD_ROLE_TYPE_CHANGE_LINE, type);

	return true;

	FUNC_END(false);
}

bool CRole::onAfterChangeLine( TChangeLineTempData* tempData, ETeleportType type )
{
	FUNC_BEGIN(CHANGELINE_MOD);

	_changeLineWait.beforeChangeMapID = tempData->mapID;
	_changeLineWait.beforeChangePos = tempData->pos;	
	gxInfo("On after change line!!! beforeSrcPosX = {0}, beforeSrcPosY = {1}, beforeMapID = {2}, objUID = {3}, roleName = {4}",
		tempData->pos.x, tempData->pos.y, tempData->mapID, getObjUID(), getHumanBaseData()->getRoleName());

	onAfterChangeMap(getSceneID(), getAxisPos(), LOAD_ROLE_TYPE_CHANGE_LINE, type);

	return true;

	FUNC_END(false);
}

bool CRole::onLogin()
{
	FUNC_BEGIN(LOGIN_MOD);
	// 客户端已经初始化成功, 并且正式进入游戏
// 	if(!getIsAdult())		@TODO
// 	{
// 		sendAgainstIndulge();
// 	}

	if( (getHumanBaseData()->isNewRole() ))
	{
		//nothing
	}
	else
	{
	}

	return true;
	FUNC_END(false);
}

bool CRole::onLogout()
{
	FUNC_BEGIN(LOGIN_MOD);

	if(isEnter())
	{

	}

	return true;
	FUNC_END(false);
}

void CRole::onIdle()
{
	///< @TODO 发送心跳
}

bool CRole::reLogin()
{
	closeSocketHandler(1);
	setStatus(ROLE_STATUS_LOAD);
	return true;
}

void CRole::initClient()
{
// 	_canMoveFlag = true;		/// @TODO
// 	_initFlag = true;
	MWUserLogin userLogin;
	userLogin.objUID = getObjUID();
	if(getLoadWaitData()->isFirstLogin() || getLoadWaitData()->isChangeLine())
	{
		// 第一次登陆游戏(包括切线), 需要世界服务器将当前玩家对应的数据重新发送过来(如:邮件)
		//updateRoleData2W(true); @TODO
		if (getLoadWaitData()->isFirstLogin())
		{
			onLogin();
		}
		userLogin.firstLogin = true;
		SendToWorld(userLogin);
		gxInfo("Role first online!!! {0},{1}", toString(), toRoleString());
	}
// 	else if(getLoadWaitData().isChangeMap())		@TODO
// 	{
// 		// 切换地图
// 		updateRoleData2W(true); 
// 		userLogin.firstLogin = false;
// 		SendToWorld(userLogin);
// 	}

	setAxisPos(&getLoadWaitData()->pos);
}

bool CRole::move( TPackMovePosList* posList )
{
	// 	if(!_canMoveFlag)	@TODO
	// 	{
	// 		return false;
	// 	}

// 	if(getScene() == NULL)
// 	{
// 		resetPos(getAxisPos(), RESET_POS_TYPE_PULL_BACK, false, false);
// 		return false;
// 	}
// 	if(posList.empty() || !isInValidRadius(getMapID(), posList.front(), 1) || !(getScene()->getMapData()->isCanWalk(posList[0])))
// 	{
// 		resetPos(getAxisPos(), RESET_POS_TYPE_PULL_BACK, false, false);
// 		return false;
// 	}
// 
// 	uint32 i = 1;
// 	bool allWalkFlag = true;
// 	for(; i < posList.size(); ++i)
// 	{
// 		if(!getScene()->getMapData()->isCanWalk(posList[i]) || !isInValidRadius(getMapID(), posList[i-1].x, posList[i-1].y, posList[i].x, posList[i].y, 1))
// 		{
// 			onMove(posList[i]);
// 			allWalkFlag = false;
// 			break;
// 		}
// 	}
// 
// 	if(!allWalkFlag)
// 	{
// 		if(i == 0)
// 		{
// 			resetPos(getAxisPos(), RESET_POS_TYPE_PULL_BACK, false, false);
// 			return false;
// 		}
// 
// 		posList.resize(i);
// 	}
// 
// 	_totalMovePosNumInCheckTime += posList.size();

	setAxisPos(&(posList->back()));
	MCMoveBroad moveBroad;
	moveBroad.objUID = getObjUID();
	moveBroad.moveType = ROLE_MOVE_TYPE_MOVE;
	moveBroad.posList = *posList;
	getScene()->broadCast(moveBroad, this, false, g_GameConfig.broadcastRange);
	updateBlock();

// 	if(!allWalkFlag)
// 	{
// 		resetPos(getAxisPos(), RESET_POS_TYPE_PULL_BACK, false, false);
// 	}

	return true;
}

bool CRole::roleMove(TPackMovePosList* posList, ERoleMoveType moveType)
{
	setAxisPos(&(posList->back()));
	MCMoveBroad moveBroad;
	moveBroad.objUID = getObjUID();
	moveBroad.moveType = moveType;
	moveBroad.posList = *posList;
	getScene()->broadCast(moveBroad, this, true, g_GameConfig.broadcastRange);
	updateBlock();

	return true;
}

bool CRole::isCanViewMe( const CGameObject *pObj )
{
	return TBaseType::isCanViewMe(pObj);
}

bool CRole::isNeedUpdateBlock()
{
	return getLoadWaitData()->destSceneID == INVALID_SCENE_ID;
}


void CRole::sendKickMsg( EKickType kickType )
{
	MCKickRole kickRole;
	kickRole.type = kickType;
	sendPacket(kickRole);
}

CLimitManager* CRole::getLimitManager()
{
	return &_limitMgr;
}

void CRole::updateLimitManger( GXMISC::TDiffTime_t diff )
{
// 	CMapPlayerHandler* pPlayer = getPlayerHandler(false);
// 	if(isEnter() && getPlayerHandler(false))
// 	{
// 		_limitMgr.update(diff);
// 		std::string ip = getPlayerHandler()->getRemoteIp();
// 		if(_limitMgr.checkLimitLogin(getAccountID()) || _limitMgr.checkLimitLogin(ip))
// 		{
// 			gxError("Role limit to login!{0},{1}", toString(), toRoleString());
// 			sendKickMsg(KICK_TYPE_BY_GM);
// 			kick(true, 3, "Kick by gm!");
// 		}
// 	}
}

void CRole::setLoadWaitInfo(ELoadRoleType loadType, TSceneID_t sceneID, const TAxisPos* pos, bool sendAllDataFlag)
{
	_loadWaitData.destSceneID = sceneID;
	_loadWaitData.pos = *pos;
	_loadWaitData.loadType = loadType;
	_loadWaitData.needSendAll = sendAllDataFlag;
}

bool CRole::isChangeLineWait()
{
	return _loadWaitData.loadType == LOAD_ROLE_TYPE_CHANGE_LINE;
}

bool CRole::isChangeLine()
{
	return isChangeLineWait() || _changeLineWait.changeLineFlag || _changeLineWait.openDynaMapFlag;
}

bool CRole::isChangeMap()
{
	return _loadWaitData.loadType == LOAD_ROLE_TYPE_CHANGE_MAP;
}

void CRole::addLimitChatInfo( TAccountID_t accountId, TRoleUID_t roleId, GXMISC::CGameTime	begintime, GXMISC::CGameTime endtime, TServerOperatorId_t uniqueId )
{
	TLimitChatInfo data;
	data.limitAccountID = accountId;
	data.limitRoleID    = roleId;
	data.begintime      = begintime;
	data.endtime        = endtime;
	data.uniqueId       = uniqueId;

	_limitMgr.addLimitChatMap( &data );
}

bool CRole::isForbbidChat( TAccountID_t accountId )
{
	return _limitMgr.isForbbidChat( accountId );
}