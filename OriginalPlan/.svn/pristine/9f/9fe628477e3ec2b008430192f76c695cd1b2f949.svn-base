#include "core/game_exception.h"

#include "role.h"
#include "module_def.h"
#include "new_role_tbl.h"
#include "role_manager.h"
#include "packet_mw_base.h"
#include "map_world_handler_base.h"
#include "map_scene.h"
#include "map_db_player_handler.h"
#include "scene_manager.h"
#include "map_data.h"
#include "map_data_manager.h"
#include "packet_cm_base.h"
#include "map_db_role_data.h"
#include "map_tbl_header.h"
#include "game_struct.h"
#include "levelup_tbl.h"
#include "script_engine.h"
#include "map_scene.h"
#include "game_config.h"
#include "packet_cm_base.h"
#include "announcement.h"
#include "announcement_define.h"
#include "map_server_data.h"
#include "map_player_handler.h"

void CRole::setHummanDBData( CHumanDBData* dbData )
{
	_humanDb.initData(dbData);
}

CHumanDBData* CRole::getHumanDBData() const
{
	return _humanDb.getHumanDbData();
}

CHumanDB* CRole::getHumanDB() const
{
	return const_cast<CHumanDB*>(&_humanDb);
}

CHumanBaseData* CRole::getHumanBaseData() const
{
	return &(getHumanDBData()->baseData);
}

TLoadWaitEnter* CRole::getLoadWaitData() const
{
	return const_cast<TLoadWaitEnter*>(&_loadWaitData);
}

bool CRole::isNeedInit()
{
	return !_initFlag;
}

uint16 CRole::getShapeData( char* data, uint32 maxSize )
{
//	gxAssert(maxSize >= sizeof(TPackRoleShape));
// 	GXMISC::CMemOutputStream outStream;
// 	TPackRoleShape shape;
// 	getShapeData(&shape);
// 	outStream.init(maxSize, data);
// 	outStream.serial(shape);
// 	return outStream.size();

	gxAssert(maxSize >= sizeof(TRoleDetail));
	TRoleDetail* pRoleDetail = (TRoleDetail*)data;
	getRoleDetailData(pRoleDetail);
	return sizeof(TRoleDetail);
}

TPackLen_t CRole::getShapeData(TPackRoleShape* shape)
{
	shape->objUID = getObjUID();
	shape->protypeID = getProtypeID();
	shape->name = getHumanBaseData()->getRoleName();
	shape->level = getHumanBaseData()->getLevel();
	shape->xPos = getHumanBaseData()->getMapPos()->x;
	shape->yPos = getHumanBaseData()->getMapPos()->y;
	shape->moveSpeed = GetConstant<TMoveSpeed_t>(ROLE_MOVE_SPEED);

	return 0;
}

void CRole::onLoginTimeout()
{
	if (isFight())
	{
		onFightFinish(false, 0);
		sendTimerUpdateData(true, SAVE_ROEL_TYPE_OFFLINE);
	}

	kick(false,1,"Login time out!");
}

void CRole::onLogoutTimeout()
{
	sendUnloadRet(RC_SUCCESS);
	cleanAll(3);
}

void CRole::sendAllData()
{
	FUNC_BEGIN(ROLE_MOD);

//	_sendDetailData();
//	_sendBagItemList();
//	_sendMissionData();

	_scriptObject.vCall("sendAllData");

	FUNC_END(DRET_NULL);
}

void CRole::getRoleDetailData( TRoleDetail* detail )
{
	FUNC_BEGIN(ROLE_MOD);

	DZeroPtr(detail);
	detail->roleUID = getRoleUID();
	CNewRoleTbl* pNewRole = DNewRoleTblMgr.find(getProtypeID());
	if(NULL != pNewRole)
	{
		// 基础属性
		detail->objUID = getObjUID();
		detail->protypeID = getProtypeID();
		detail->name = getRoleName();
		detail->level = getLevel();
		detail->sex = pNewRole->sex;
		detail->maxExp = getMaxExp(getLevel());
		detail->exp = getExp();
		detail->gold = getGameMoney();
		detail->rmb = getAllRmb();
		detail->mapID = getMapID();
		detail->xPos = getAxisPos()->x;
		detail->yPos = getAxisPos()->y;
		detail->dir = DIR2_LEFT;

//		detail->vipLevel = getVipLevel();

		// 战斗属性
		detail->moveSpeed = getMoveSpeed();
		detail->maxHp = getMaxHp()+1000;
		detail->curHp = getHp() + 1000;
		detail->maxEnergy = getMaxEnergy();
		detail->curEnergy = getEnergy();
		detail->power = getPower();
		detail->agility = getAgility();
		detail->wisdom = getWisdom();
		detail->physical = getStrength();
		detail->attack = getPhysicAttck();
		detail->skillAttack = getSkillAttack();
		detail->damage = getDamage();
		detail->crit = getCrit();
		detail->defense = getPhysicDefense();
		detail->dodge = getDodge();

		_scriptObject.vCall("getRoleDetailData", &detail);
	}

	FUNC_END(DRET_NULL);
}

void CRole::_sendDetailData()
{
	FUNC_BEGIN(ROLE_MOD);

// 	MCRoleDetail detailData;
// 	getRoleDetailData(detailData.detailData);
// 	sendPacket(detailData);

	FUNC_END(DRET_NULL);
}

CRole::CRole() : CRoleBase()
{
	// 模块初始化
	_bagMod.init(this);
	_bufferMod.init(this);
	_chatMod.init(this);
	_missionMod.init(this);

	_isLocalServerLogin = false;

	_heartToWorldTimer.init((g_GameConfig.maxWorldRoleHeartOutTime/2)*GXMISC::MILL_SECOND_IN_SECOND);
	_humanDBDataSaveTimer.init(10*GXMISC::MILL_SECOND_IN_MINUTE);
	_fiveSecTimer.init(5*GXMISC::MILL_SECOND_IN_SECOND);
}

CRole::~CRole()
{
}

bool CRole::update( GXMISC::TDiffTime_t diff )
{
	FUNC_BEGIN(ROLE_MOD);

	TBaseType::update(diff);

	if(isEnter())
	{
		_humanDBDataSaveTimer.update(diff);
		sendTimerUpdateData(false, SAVE_ROLE_TYPE_TIMER);

		if(_fiveSecTimer.update(diff))
		{
			onFiveSecondTimer();
			_fiveSecTimer.reset();
		}

		//_bufferMod.update(diff);
		_chatMod.update(diff);
	}

	//heartToWorld(diff);
	updateLimitManger(diff);

	return true;

	FUNC_END(false);
}

void CRole::loadDataOk(TLoadRoleData* pLoadData)
{
	if (!_scriptObject.bCall("onLoadDataOk", _humanDb.getDataBuffer(), getPlayerHandler(true)->getScriptObject()))
	{
		return;
	}
}

bool CRole::onLoad(TRoleManageInfo* info, CHumanDBBackup* hummanDB, TLoadRoleData* loadData, TChangeLineTempData* tempData, bool isAdult)
{
	FUNC_BEGIN(ROLE_MOD);

	_humanDb.initHumanDBBackup(hummanDB);
	
	CNewRoleTbl* pNewRoleRow = DNewRoleTblMgr.find(getHumanBaseData()->getProtypeID());
	if(NULL == pNewRoleRow)
	{
		gxError("Can't find CNewRoleConfigTbl!AccountID = {0},RoleUID={1},ProtypeID={2}", getAccountID(), getRoleUID(), (uint32)getProtypeID());
		return false;
	}

	// 基本属性初始化
	{
		if(getHumanBaseData()->isNewRole())
		{
			// 新角色赋值
			getHumanBaseData()->setLevel(MIN_LEVEL);
			getHumanBaseData()->bagOpenGridNum = GetConstInt(BAG_INIT_GRIDNUM);
		}

		setStatus(ROLE_STATUS_LOAD);
		setAccountID(getHumanBaseData()->getAccountID());
		setRoleUID(getHumanBaseData()->getRoleUID());
		setObjUID(getHumanBaseData()->getObjUID());
		setLevel(getHumanBaseData()->getLevel());
		setObjType(OBJ_TYPE_ROLE);
		setSex(pNewRoleRow->sex);

		// 判断玩家离线有没有过天
		sint32 offlineDays = getOfflineOverrunDays();
		if( offlineDays > 0 )
		{
			onOfflineOverrunDays(offlineDays);
		}

		_changeLineWait.objUID = loadData->objUID;
	}

	//_bagMod.onLoad();
	//_bufferMod.onLoad();
	//_missionMod.onLoad();
	//_chatMod.onLoad();
	if (!_scriptObject.bCall("onDBLoad", _humanDb.getDataBuffer()))
	{
		return false;
	}

	setQuitRet(true);
	setLoginTime(DTimeManager.nowSysTime());
	setIsAdult(isAdult);

	// 	gxAssert(loadData.objUID == getHumanBaseData()->getObjUID());
	// 	gxAssert(loadData.roleUID == getHumanBaseData()->getRoleUID());
	// 	gxAssert(loadData.accountID == getHumanBaseData()->getAccountID());
	// 
	// 	if(loadData.objUID != getHumanBaseData()->getObjUID()
	// 		|| loadData.roleUID != getHumanBaseData()->getRoleUID()
	// 		|| loadData.accountID != getHumanBaseData()->getAccountID())
	// 	{
	// 		gxError("Load role data is not equal need load role data!{0},RoleUID={1}", loadData.toString(), getHumanBaseData()->getRoleUID());
	// 		return false;
	// 	}

	// 初始化工作
	{
		if(getHumanBaseData()->isNewRole())
		{
			getHumanBaseData()->setLoginCountOneDay(1);
		}
		else
		{
			if(getOfflineOverrunDays() > 0)
			{
				getHumanBaseData()->setLoginCountOneDay(1);
			}
			else
			{
				getHumanBaseData()->setLoginCountOneDay(getHumanBaseData()->getLoginCountOneDay()+1);
			}
		}
	}

	// 场景初始化
	{
		getHumanBaseData()->setSceneID(CGameMisc::GenSceneID(INVALID_SERVER_ID, SCENE_TYPE_NORMAL, pNewRoleRow->mapID, INVALID_COPY_ID));
	}

	// 切线处理
	{
		if (loadData->loadType == LOAD_ROLE_TYPE_CHANGE_LINE)
		{
			if(!onAfterChangeLine(tempData, TELEPORT_TYPE_SYS))		// @todo
			{
				return false;
			}
		}

	}

	// 新旧角色回调函数
	{
		if(getHumanBaseData()->isNewRole())
		{
			if(!onNewLogin())
			{
				return false;
			}
		}
		else
		{
			if(!onOldLogin())
			{
				return false;
			}
		}

		//refreshFast(false);
	}

	/*
	// 登陆地图位置处理
	{
// 		if(getHumanBaseData()->isNewRole())
// 		{
// 			// 新角色
// 			if (loadData->needOpenMap)
// 			{
// 			}
// 		}

		// @TODO 处理loadData->needOpenMap

		CMapScene* pMapScene = DSceneMgr.findScene(loadData->sceneID);
		if(NULL == pMapScene){
			gxWarning("Can't find scene!SceneID={0}, {1}", loadData->sceneID, toString());
		}
		if (NULL == pMapScene)
		{
			pMapScene = (CMapScene*)DSceneMgr.getLeastScene(loadData->mapID);
		}
		if (NULL == pMapScene)
		{
			gxError("Can't find scene!SceneID={0}, {1}", loadData->sceneID, toString(), loadData->mapID);
			return false;
		}

		if (!pMapScene->canEnter())
		{
			gxError("Scene can't enter!{0},{1}", toString(), pMapScene->toString());
			return false;
		}
		loadData->sceneID = pMapScene->getSceneID();

		setMapID(CGameMisc::GetMapID(loadData->sceneID));
		TAxisPos pos = loadData->pos;
		setAxisPos(&pos);

		// 查找一个可行走点
		CMap* pMap = DMapDataMgr.findMap(getMapID());
		if(NULL == pMap)
		{
			gxError("Can't find map!{0},MapID={1}", toString(), getMapID());
			return false;
		}
		if(!pMap->isCanWalk(getAxisPos()))
		{
			gxAssert(pMap->isCanWalk(pMap->getEmptyPos()));
			setAxisPos(pMap->getEmptyPos());
		}

// 		_loadWaitData.loadType = loadData->loadType;
// 		_loadWaitData.destSceneID = loadData->sceneID;
// 		_loadWaitData.pos = loadData->pos;
// 		_loadWaitData.needSendAll = true;		// @TODO 切线后的处理
		setLoadWaitInfo(loadData->loadType, loadData->sceneID, &loadData->pos, true);
	}
	*/
	//refreshFast(false);

	// 保存角色数据
	{
		sint32 loadSaveFlag = DScriptEngine.call("GetRoleLoadSaveFlag", 0);
		if(loadSaveFlag == 1)
		{
			sendTimerUpdateData(true, SAVE_ROLE_TYPE_TIMER);
		}
	}

	_lastCheckMovePos = *getAxisPos();


	if (!_scriptObject.bCall("onAfterDBLoad"))
	{
		return false;
	}

	return true;

	FUNC_END(false);
}

bool CRole::onSave( bool offLineFlag )
{
	FUNC_BEGIN(ROLE_MOD);

	if(offLineFlag)
	{
		setStatus(ROLE_STATUS_SAVE);
	}

	if(offLineFlag)
	{
		//gxAssert(isEnter());
	}
	//getBagMod()->onSave(offLineFlag);
	//getBufferMod()->onSave(offLineFlag);
	//getMissionMod()->onSave(offLineFlag);
	if (!_scriptObject.bCall("onDBSave", offLineFlag))
	{
		return false;
	}
	getHumanBaseData()->setLogoutTime(DTimeManager.nowSysTime());

	return true;

	FUNC_END(false);
}

void CRole::setHummanDBBuffer(const char* buff, sint32 len)
{
	getHumanDB()->setDataBuffer(buff, len);
}

bool CRole::isDbModBusy()
{
	CMapDbPlayerHandler* dbPlayer = getDbHandler(false);
	if(NULL == dbPlayer)
	{
		return true;
	}

	return dbPlayer->getDbWrap()->getTaskQueueWrap()->getOutputTaskNum() > 10;
}

void CRole::sendTimerUpdateData( bool forceFlag, ESaveRoleType saveType )
{
	FUNC_BEGIN(ROLE_DB_MOD);

	if(!forceFlag)
	{
		if(!(_humanDBDataSaveTimer.isPassed() ||
			(DTimeManager.nowSysTime()%DRoleManager.getSaveSec()==getDbSaveIndex() 
			&& DTimeManager.nowSysTime() != getLastSaveTime() && !isDbModBusy())))
		{
			return;
		}
	}
	setLastSaveTime(DTimeManager.nowSysTime());
	_humanDBDataSaveTimer.reset();
	setUpdateSaveDirty(false);

	CMapDbPlayerHandler* dbHandler = getDbHandler();
	if(NULL == dbHandler)
	{
		gxError("Can't find db handler!{0}", toString());
		gxAssert(false);
		return ;
	}

	ERoleStatus roleStatus = getStatus();
	if(saveType == SAVE_ROEL_TYPE_OFFLINE){
		onSave(true);
	}
	else{
		onSave(false);
	}
	dbHandler->sendUpdateRoleData(getHumanDB(), saveType);
	setStatus(roleStatus);

	FUNC_END(DRET_NULL);
}

bool CRole::onNewLogin()
{
	gxInfo("New role login!!!ObjUID={0},RoleUID={1},RoleName={2}", getObjUID(), getRoleUID(), getHumanBaseData()->getRoleName());

	CNewRoleTbl* pNewRowTbl = DNewRoleTblMgr.find(getProtypeID());
	if(NULL == pNewRowTbl)
	{
		gxError("Can't find new role row!{0},RoleUID={0},ProtypeID={0}", toString(), getRoleUID(), (uint32)getProtypeID());
		return false;
	}

	setHp(0);
	setMoveSpeed(0);
	setExp(0);
	getHumanBaseData()->setBindRmb(0);
	getHumanBaseData()->setRmb(0);
	setHp(getMaxHp());
	initCharacter();
	genStrName();
	
	// 初始化属性
	setVipLevel(0);
	setVipExp(0);
	addStrength(pNewRowTbl->strength);
	addExp(pNewRowTbl->exp);
	handleAddMoneyPort(ATTR_MONEY, pNewRowTbl->gameMoney, RECORD_NEW_ROLE_AWARD);
	handleAddMoneyPort(ATTR_RMB, pNewRowTbl->bindRmb, RECORD_NEW_ROLE_RMB);
	setLevel(pNewRowTbl->level);	
	// 新角色赠送物品
	//for(TItemRewardVec::iterator iter = pNewRowTbl->items.begin(); iter != pNewRowTbl->items.end(); ++iter){
	//	handleAddTokenOrItem(&(*iter), ITEM_RECORD_NEW_ROLE);
	//}

	// 任务
	//getMissionMod()->setLastFinishMissionID(INVALID_MISSION_TYPE_ID);
	_scriptObject.bCall("onNewLogin");

	return true;
}

bool CRole::onOldLogin()
{
	initCharacter();
	genStrName();

	gxInfo("Old role online!! offlineDays = {0}, loginOutTime = {1}, curTime = {2}, loginOutDay = {3}, curDay = {4},"
		"objUID = {5}, roleUID = {6}, roleName = {7}", getOfflineOverrunDays(), getHumanBaseData()->getLogoutTime(), DTimeManager.nowSysTime(),
		GXMISC::CTimeManager::ToLocalTime(getHumanBaseData()->getLogoutTime())/GXMISC::SECOND_IN_DAY, GXMISC::CTimeManager::ToLocalTime(DTimeManager.nowSysTime())/GXMISC::SECOND_IN_DAY, getObjUID(), getRoleUID(),
		getHumanBaseData()->getRoleName());
	

	logTotalAttr(true);

	return true;
}

void CRole::getRoleUserData( CWorldUserData* data )
{
	getHumanDBData()->getUserData(data);
	data->sceneID = _changeLineWait.destSceneID;
	data->offOverDay = getIsOffOverDay();
	setIsOffOverDay(false);
}


void CRole::onOfflineOverrunDays( uint32 days )
{
	// 离线过天, 登陆次数还原
	getHumanBaseData()->setLoginCountOneDay(1);
	setIsOffOverDay(true);
}

uint32 CRole::getOfflineOverrunDays()
{
	return getOfflineOverrunDays(0,0,0);
}

uint32 CRole::getOfflineOverrunDays( sint32 hour, sint32 min )
{
	return getOfflineOverrunDays(hour, min, 0);
}

uint32 CRole::getOfflineOverrunDays( sint32 hour, sint32 min, sint32 seconds )
{
	return getHumanBaseData()->getOfflineOverunDays(hour, min, seconds);
}

uint32 CRole::getOfflineHours( )
{
	if(getHumanBaseData()->isNewRole())
	{
		return 0;
	}

	return (getLoginTime() - getHumanBaseData()->getLogoutTime())/GXMISC::SECOND_IN_HOUR;
}

uint32 CRole::getOfflineMins()
{
	if(getHumanBaseData()->isNewRole())
	{
		return 0;
	}

	return (getLoginTime() - getHumanBaseData()->getLogoutTime())/GXMISC::SECOND_IN_MINUTE;
}

void CRole::on0Timer()
{
	gxInfo("0 timer pass! objUID = {0}, roleUID = {1}, roleName = {2}", getObjUID(), getRoleUID(), getHumanBaseData()->getRoleName());
	
}

void CRole::on12Timer()
{

}

sint32   CRole::getLoginsDay()
{
	return getHumanBaseData()->getLoginCountOneDay();
}

bool CRole::isFirstLoginInDay()
{
	return getLoginsDay() == 1;
}

GXMISC::TDiffTime_t CRole::getOnlineTime()
{
	return DTimeManager.nowSysTime()-getLoginTime();
}

GXMISC::TDiffTime_t CRole::getOnlineMins()
{
	return getOnlineTime()/GXMISC::SECOND_IN_MINUTE;
}

void CRole::_sendBagItemList()
{
	FUNC_BEGIN(ROLE_MOD);

	_bagMod.onSendData();

	FUNC_END(DRET_NULL);
}

void CRole::onEnterScene( CMapSceneBase* pScene )
{
	FUNC_BEGIN(SCENE_MOD);

	TBaseType::onEnterScene(pScene);
	gxInfo("Role enter scene!{0}", toString());
	onScene((CMapScene*)pScene);
	_sceneRecord.enterSceneNum++;

	FUNC_END(DRET_NULL);
}

void CRole::onLeaveScene( CMapSceneBase* pScene )
{
	FUNC_BEGIN(SCENE_MOD);

	getHumanBaseData()->setLastMapID(pScene->getMapID());
	getHumanBaseData()->setLastMapPos(getAxisPos());
	getHumanBaseData()->setLastSceneID(pScene->getSceneID());

	TBaseType::onLeaveScene(pScene);

	FUNC_END(DRET_NULL);
}

void CRole::onMove( const TAxisPos* pos )
{
	TBaseType::onMove(pos);
}

TVipLevel_t CRole::addVipLevel(TVipLevel_t val, bool logFlag  )
{
	TVipLevel_t vipLevel = getVipLevel();
	setVipLevel(vipLevel+val);
	refreshFast(true);
	if(logFlag)
	{
		gxInfo("Add vipLevel!OldVipLevel={0},NewVipLevel={1},{2},RoleUID={3},AccountID={4},ObjectUID={5}",
			sint32(vipLevel), sint32(getVipLevel()), toString(), getRoleUID(), getAccountID(), getObjUID());
	}

	CAnnouncement::BroadToAll(AET_ROLE_VIP_UP, getVipLevel(), ANNOUNCEMENT_SYS_INVALID, CAnnouncement::GetRoleName(this), CAnnouncement::GetNumber(getVipLevel()));

	return getVipLevel();
}


TVipExp_t CRole::addVipExp( TVipExp_t  val, bool logFlag )
{
	TVipExp_t vipExp = getVipExp();
	setVipExp(vipExp+val);
	refreshFast(true);
	if(logFlag)
	{
		gxInfo("Add vipExp!OldExp={0},NewVipLevel={1},{2},RoleUID={3},AccountID={4},ObjectUID={5}",
			vipExp, getVipExp(), toString(), getRoleUID(), getAccountID(), getObjUID());
	}
		
	return getVipExp();
}

TRmb_t CRole::addBindRmb( TRmb_t val, bool logFlag )
{
	TRmb_t rmb = getBindRmb();
	rmb = rmb+val;
	getHumanBaseData()->setBindRmb(rmb);
	if(logFlag)
	{
		gxInfo("Add bind rmb!OldBindRmb={0},NewBindRmb={1},{2},RoleUID={3},AccountID={4},ObjectUID={5}",
			rmb, getBindRmb(), toString(), getRoleUID(), getAccountID(), getObjUID());
	}
	refreshFast(true);
	return getBindRmb();
}

TRmb_t CRole::getAllRmb() const
{
	return getBindRmb()+getRmb();
}

TRmb_t CRole::descAllRmb( TRmb_t val, bool logFlag )
{
	gxAssertEx(val <= getAllRmb(), "Rmb not enough!{0}", toString());
	gxAssert(val >= 0);

	TRmb_t oldAllRmb = getAllRmb();
	TRmb_t oldRmb = getRmb();
	TRmb_t oldBindRmb = getBindRmb();
	// 先扣绑定元宝, 再扣元宝
	if(getBindRmb() >= val)
	{
		addBindRmb(-val);
	}else if(getBindRmb() < val){
		TRmb_t rmb = getBindRmb();
		getHumanBaseData()->setBindRmb(0);
		val -= rmb;
		rmb = getRmb();
		getHumanBaseData()->setRmb(rmb-val);
	}
	if(logFlag)
	{
		gxInfo("Desc all rmb!OldAllRmb={0},NewAllRmb={1},{2},RoleUID={3},AccountID={4},ObjectUID={5},OldRmb={6},OldBindRmb={7},NewRmb={8},NewBindRmb={9}",
			oldAllRmb, getAllRmb(), toString(), getRoleUID(), getAccountID(), getObjUID(),oldRmb,oldBindRmb,getRmb(),getBindRmb());
	}
	refreshFast(true);
	return getAllRmb();
}

TExp_t CRole::getMaxExp( TLevel_t lvl /*= 0*/ ) const
{
	CLevelUpTbl* pLevelUpRow = DLevelUpTblMgr.find(lvl);
	if(NULL == pLevelUpRow)
	{
		return 0;
	}

	return pLevelUpRow->exp;
}

TLevel_t CRole::getMaxLevel() const
{
	return MAX_LEVEL;
}

void CRole::onLevelChanged( uint32 sLvl, uint32 dLvl )
{
	TBaseType::onLevelChanged(sLvl, dLvl);

	_addLevelAward(dLvl);
	refreshFast();

	CAnnouncement::BroadToAll(AET_ROLE_LEVEL_UP, getLevel(), ANNOUNCEMENT_SYS_INVALID, CAnnouncement::GetRoleName(this), CAnnouncement::GetNumber(getLevel()));
}

TGold_t CRole::addGameMoney( TGold_t val, bool logFlag )
{
	TGold_t gameMoney = getGameMoney();
	setGameMoney(gameMoney+val);
	if(logFlag)
	{
		gxInfo("Add game money!OldGameMoney={0},NewGameMoney={1},{2},RoleUID={3},AccountID={4},ObjectUID={5}",
			gameMoney, getGameMoney(), toString(), getRoleUID(), getAccountID(), getObjUID());
	}
	refreshFast(true);
	return getGameMoney();
}

void CRole::refreshFast( bool sendFlag /*= true*/ )
{
	FUNC_BEGIN(ROLE_MOD);

	_attrBackup.init();

	// 经验
	if(!_attrBackup.isEqual(ATTR_EXP, getExp()))
	{
		_attrBackup.setValue(ATTR_EXP, getExp());
	}
	// 金钱
	if (!_attrBackup.isEqual(ATTR_MONEY, getGameMoney()))
	{
		_attrBackup.setValue(ATTR_MONEY, getGameMoney());
	}
	// 元宝
	if (!_attrBackup.isEqual(ATTR_RMB, getAllRmb()))
	{
		_attrBackup.setValue(ATTR_RMB, getAllRmb());
	}
	// 等级
	if (!_attrBackup.isEqual(ATTR_LEVEL, getLevel()))
	{
		_attrBackup.setValue(ATTR_LEVEL, getLevel());
	}
	// 移动速度
	if (!_attrBackup.isEqual(ATTR_MOVE_SPEED, getMoveSpeed()))
	{
		_attrBackup.setValue(ATTR_MOVE_SPEED, getMoveSpeed());
	}
	// vip等级
	if (!_attrBackup.isEqual(ATTR_VIP_LEVEL, getVipLevel()))
	{
		_attrBackup.setValue(ATTR_VIP_LEVEL, getVipLevel());
	}
	// vip经验值
	if (!_attrBackup.isEqual(ATTR_VIP_EXP, getVipExp()))
	{
		_attrBackup.setValue(ATTR_VIP_EXP, getVipExp());
	}
	// 最大经验值
	if (!_attrBackup.isEqual(ATTR_MAX_EXP, getMaxExp(getLevel())))
	{
		_attrBackup.setValue(ATTR_MAX_EXP, getMaxExp(getLevel()));
	}

	_scriptObject.vCall("refreshFast");

	if(_attrBackup.isDirty() && sendFlag)
	{
		sendPacket(*_attrBackup.getSyncData());
	}
	_attrBackup.init();

	FUNC_END(DRET_NULL);
}

void CRole::loadBaseAttr(TBaseAttrs* baseAttr)
{
	FUNC_BEGIN(ROLE_MOD);

	_baseAttr.reset();
	_baseOddsAttr.reset();

	FUNC_END(DRET_NULL);
}

void CRole::setAxisPos( const TAxisPos* pos )
{
	TBaseType::setAxisPos(pos);
	getHumanBaseData()->setMapPos(pos);
}

void CRole::setMapID( TMapID_t mapID )
{
	TBaseType::setMapID(mapID);
	getHumanBaseData()->setMapID(mapID);
}

void CRole::setSceneID( TSceneID_t sceneID )
{
	TBaseType::setSceneID(sceneID);
	getHumanBaseData()->setSceneID(sceneID);
}

void CRole::onFiveSecondTimer()
{
	_scriptObject.vCall("onFiveSecondTimer");
}

bool CRole::onAddToReady()
{
	if(!TBaseType::onAddToReady())
	{
		return false;
	}

// 	if(!DScriptEngine.bCall("AddRole", this)){
// 		gxError("Can't add role to ready");
// 		return false;
// 	}

	if (_scriptObject.isExistMember("onAddToReady"))
	{
		DIFFALSE(_scriptObject.bCall("onAddToReady"));
	}

	sint32 readyLastTime = _scriptObject.call<sint32>("getRoleReadyLastTime", 0);
	setLoginLastTime(readyLastTime);

	return true;
}

bool CRole::onAddToLogout()
{
	if(!TBaseType::onAddToLogout()){
		return false;
	}

//	DScriptEngine.vCall("DeleteRole", this);

	return true;
}


void CRole::onRemoveFromLogout()
{
	FUNC_BEGIN(ROLE_MOD);

	TBaseType::onRemoveFromLogout();

	FUNC_END(DRET_NULL);
}

void CRole::onMissionSubmit( TMissionTypeID_t missionTypeID, EMissionType missionType, TOwnMission* mission )
{
	FUNC_BEGIN(MISSION_MOD);

	_scriptObject.vCall("onSubmitMission", &mission);


	FUNC_END(DRET_NULL);
}

void CRole::onMissionAccept( TMissionTypeID_t missionTypeID, EMissionType missionType, TOwnMission* mission )
{
	FUNC_BEGIN(MISSION_MOD);

	_scriptObject.vCall("onAcceptMission", &mission);

	FUNC_END(DRET_NULL);
}

void CRole::_sendMissionData()
{
	FUNC_BEGIN(MISSION_MOD);

	getMissionMod()->onSendData();

	FUNC_END(DRET_NULL);
}

CLevelUpTbl* CRole::getLevelRow() const
{
	FUNC_BEGIN(ROLE_MOD);

	return DLevelUpTblMgr.find(getLevel());

	FUNC_END(NULL);
}

CNewRoleTbl* CRole::getNewRoleRow() const
{
	FUNC_BEGIN(ROLE_MOD);

	return DNewRoleTblMgr.find(getProtypeID());

	FUNC_END(NULL);
}

std::string CRole::toRoleString()
{
	std::string str = _strName;
	str += GXMISC::gxToString("Name=%s,Account=%"I64_FMT"u,RoleUID=%"I64_FMT"u",
		getRoleName().toString().c_str(),getAccountID(), getRoleUID());
	return str;
}

void CRole::onHourTimer( sint8 hour )
{
	FUNC_BEGIN(ROLE_MOD);

// 	switch(hour)
// 	{
// 	default:
// 		break;
// 	}

	FUNC_END(DRET_NULL);
}

bool CRole::isOfflineDayTime( sint8 hour, sint8 mins /*= 0*/, sint8 seconds /*= 0*/ )
{
	FUNC_BEGIN(ROLE_MOD);

	FUNC_END(false);
}

bool CRole::isOfflineTime( GXMISC::TGameTime_t gameTime )
{
	FUNC_BEGIN(ROLE_MOD);

	FUNC_END(false);
}

bool CRole::isOfflineTime( sint16 year, sint8 month, sint8 day, sint8 hour, sint8 mins, sint8 seconds )
{
	FUNC_BEGIN(ROLE_MOD);

	FUNC_END(false);
}

bool CRole::isFight() const
{
	return false;
}

void CRole::onFightFinish(bool victory, sint32 killNum)
{

}

void CRole::sendChat( const std::string& msg )
{
	MCChatBroad chatMsg;
	chatMsg.channelType = CHAT_CHANNEL_WORLD;
	chatMsg.objUid = getObjUID();
	chatMsg.roleName = getRoleName();
	chatMsg.msg = msg;
	chatMsg.perMsg = "";
	chatMsg.setRetCode(RC_SUCCESS);
	sendPacket(chatMsg);
}

void CRole::waitReconnect()
{
	FUNC_BEGIN(ROLE_MOD);

	_changeLineWait.cleanUp();
	if(isLogout()){
		gxError("Wait reconnect, role has in logout queue!{0}", toString());
		return;
	}

	if(isReady())
	{
		gxError("Wait reconnect, role has in ready queue!{0}", toString());
		return;
	}

	// 检测状态, 指定状态断开是需要退出的
	bool needQuit = false;
	switch (getStatus())
	{
	case ROLE_STATUS_ENTER_SCENE:	// 进入场景状态
	case ROLE_STATUS_CHANGE_MAP:	// 切换地图
		{
			needQuit = false;
		}break;
	default:
		{
			needQuit = true;
		}
	}

	// 保存玩家数据
	sendTimerUpdateData(true, SAVE_ROEL_TYPE_OFFLINE);

	CMapSceneBase* pScene = getScene();
	if (!isFight()){
		if (NULL == pScene){
			gxError("Role wait recconect, but scene is null!{0}", toString());
			addRoleToLogout(3);
			needQuit = true;
		}
		else
		{
			TLoadWaitEnter& loadData = _loadWaitData;
			loadData.loadType = LOAD_ROLE_TYPE_LOGIN;
			loadData.needSendAll = true;
			loadData.destSceneID = pScene->getSceneID();
			loadData.pos = *getAxisPos();

			setActive(false);
			leaveScene(false);
		}
	}
	else{
		gxWarning("Role is fight but disconnect!{0},{1}", toString(), toRoleString());
	}

	if(needQuit){
		gxInfo("Role wait reconnect!{0}", toString());
		quitGame();
	}else{
		// 添加到修登入队列中
		addRoleToLogout();
		addRoleToReady();

		setStatus(ROLE_STATUS_CHANGE_MAP);
	}

	FUNC_END(DRET_NULL);
}

bool CRole::renameName( const std::string& roleName )
{
	MWRenameRoleName renameRoleName;
	renameRoleName.roleName = roleName;
	sendToWorld(renameRoleName, true);

	return true;
}

const std::string CRole::randName()
{
	FUNC_BEGIN(ROLE_MOD);

	MWRandRoleName randRoleName;
	randRoleName.sex = getSex();
	sendToWorld(randRoleName, true);

	return "";

	FUNC_END("");
}

CMapServerData* CRole::getMapServerData() const
{
	return CMapServerData::GetPtrInstance();
}

void CRole::onRename(EGameRetCode retCode)
{
	TBaseType::onRename(retCode);
	MCRenameRoleNameRet renanmeRet;
	renanmeRet.setRetCode(retCode);
	renanmeRet.roleName = getRoleNameStr();
	sendPacket(renanmeRet);
}

void CRole::setSex( TSex_t val )
{
	_sex = val; 
	getHumanDBData()->baseData.sex = _sex;
}

void CRole::updateUserData( TW2MUserDataUpdate* pData )
{
	setGmPower(pData->gmPower);
}

void CRole::setLocalServerLogin(bool flag)
{
	_isLocalServerLogin = flag;
}

bool CRole::initScript(std::string functionName)
{
	_scriptObject.setScriptHandleClassName(functionName);

	return _scriptObject.initScript(DScriptEngine.GetPtrInstance(), this);
}

const TRoleAttrBackup* CRole::getRoleAttrBackup() const
{
	return &_attrBackup;
}

lua_tinker::s_object CRole::getScriptObject()
{
	return _scriptObject.getScriptObject();
}

lua_tinker::s_object CRole::getScriptObject1()
{
	return _scriptObject.getScriptObject();
}

void CRole::sendErrorCode(EGameRetCode retCode)
{
	MCCallBackRetCode pack;
	pack.setRetCode(retCode);
	sendPacket(pack);
}
