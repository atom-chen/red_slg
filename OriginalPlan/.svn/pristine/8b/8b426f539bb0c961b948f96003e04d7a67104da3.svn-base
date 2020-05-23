#include "role.h"
#include "transport_tbl.h"
#include "map_scene_base.h"
#include "map_data_manager.h"
#include "map_data_tbl.h"
#include "map_server_instance.h"
#include "map_server.h"
#include "map_server_task.h"
#include "scene_manager_base.h"
#include "scene_manager.h"
#include "map_world_handler_base.h"

EGameRetCode CRole::checkTelport(CTransportConfigTbl* tbl, bool isCheckPos, bool isCheckLevel, TMapIDRangePos* destPos, ETeleportType type)
{
	FUNC_BEGIN(SCENE_MOD);

	if (getStatus() != ROLE_STATUS_ENTER_SCENE)
	{
		return RC_MAP_CHANGE_LINE_WAIT;
	}

	CMapSceneBase* pScene = getScene();
	if (pScene == NULL)
	{
		gxError("Scene pointer is null!!!");
		gxAssert(false);
		return RC_MAP_NO_TELPORT;
	}

	if (tbl->mapID != getScene()->getMapID())
	{
		gxError("Transmit map id not equal current map id!%s", tbl->toString());
		return RC_MAP_NOT_EQUAL;
	}

	if (pScene->isDynamicScene() && pScene->getKickPos(destPos, this))
	{
		return RC_SUCCESS;
	}

	TAxisPos srcMapPos = tbl->pos;
	if (isCheckPos)
	{
		if (!isInValidRadius(getMapID(), &srcMapPos, 2))
		{
			gxError("Not in transmit!{0}", tbl->toString());
			return RC_MAP_NO_IN_TRANSMIT;
		}
	}

	destPos->mapID = tbl->mapID;
	destPos->pos = srcMapPos;

	return RC_SUCCESS;

	FUNC_END(RC_MAP_NO_TELPORT);
}

EGameRetCode CRole::checkChangeMap(TMapID_t mapID, const TAxisPos* pos, ETeleportType type)
{
	FUNC_BEGIN(SCENE_MOD);

	CMap* pMap = DMapDataMgr.findMap(mapID);
	if (NULL == pMap)
	{
		gxError("Can't find dest map data!MapID={0},{1}", mapID, toString());
		return RC_MAP_NO_FIND_DEST_MAP;
	}

	if (!pMap->isCanWalk(pos))
	{
		gxError("Dest pos not walk!MapID={0},{1}", mapID, pos->toString());
		return RC_MAP_DEST_POS_NOT_WALK;
	}

	return RC_SUCCESS;

	FUNC_END(RC_FAILED);
}

EGameRetCode CRole::checkEnterDynaMap(TMapID_t mapID)
{
	FUNC_BEGIN(SCENE_MOD);

	return RC_SUCCESS;

	FUNC_END(RC_FAILED);
}

// EGameRetCode CRole::changeMap(TTransportTypeID_t id, ETeleportType type, bool isCheckPos /*= true*/, bool isCheckLevel /*= true*/)
// {
// 	FUNC_BEGIN(SCENE_MOD);
// 
// 	CTransportConfigTbl* tbl = DTransportTblMgr.find(id);
// 	if (NULL == tbl)
// 	{
// 		gxError("Can't find transmit config!ID={0}", id);
// 		return RC_MAP_NO_TRANSMIT_ID;
// 	}
// 
// 	doMoveUpdate(getLogicTime(), MAX_MOVE_POS_NUM, true);
// 
// 	TMapIDRangePos TransmitPos;
// 	EGameRetCode ret = checkTelport(tbl, isCheckPos, isCheckLevel, &TransmitPos, type);
// 	if (!IsSuccess(ret))
// 	{
// 		return ret;
// 	}
// 
// 	return changeMap(TransmitPos.mapID, &TransmitPos.pos, type);
// 
// 	FUNC_END(RC_FAILED);
// }

EGameRetCode CRole::changeMap(TMapID_t mapID, const TAxisPos* pos, ETeleportType type)
{
	FUNC_BEGIN(SCENE_MOD);

	EGameRetCode ret = checkChangeMap(mapID, pos, type);
	if (!IsSuccess(ret))
	{
		return ret;
	}

	CMapConfigTbl* pMapRow = DMapTblMgr.find(mapID);
	if (NULL == pMapRow)
	{
		gxError("Can't find map row!MapID={0}, {1}", mapID, toString());
		return RC_MAP_NOT_FIND;
	}

	TServerID_t mapServerID = INVALID_SERVER_ID;
	TSceneID_t sceneID = INVALID_SCENE_ID;
	if (CGameMisc::IsDynamicMap((ESceneType)pMapRow->mapType))   // 副本
	{
		return openDynamicMap(mapID);
	}
	else    // 普通地图
	{
		if (!getNormalMapScene(mapID, mapServerID, sceneID))
		{
			return RC_MAP_NOT_FIND;
		}
		if (mapServerID != DMapServerConfig->getMapServerID())
		{
			// 服务器ID不同, 直接切线
			assert(false);
			//return changeLine(sceneID, mapServerID, pos, type);
		}

		// 在本地切换场景
		toDestScene(sceneID, pos, type);

		return RC_SUCCESS;
	}

	return RC_MAP_NOT_FIND;

	FUNC_END(RC_MAP_NOT_FIND);
}

void CRole::setChangePos(TSceneID_t sceneID, const TAxisPos* pos)
{
	//gxAssert(CGameMisc::GetMapID(sceneID) != getMapID());
	//if(CGameMisc::GetMapID(sceneID) != getMapID())
	gxAssert(sceneID != getSceneID());
	if (sceneID != getSceneID())
	{
		setLoadWaitInfo(LOAD_ROLE_TYPE_CHANGE_MAP, sceneID, pos, false);
		// 切地图
		setStatus(ROLE_STATUS_CHANGE_MAP);

		// 离开场景
		leaveScene(true);
		
		setAxisPos(pos);
		clearMovePos();
		setMapID(CGameMisc::GetMapID(sceneID));
	}
	else
	{
		resetPos(pos, RESET_POS_TYPE_WINK, true, false);
	}
}

void CRole::toDestScene(TSceneID_t sceneID, const TAxisPos* destPos, ETeleportType type)
{
	FUNC_BEGIN(SCENE_MOD);

	if (sceneID == getSceneID())
	{
		resetPos(destPos, RESET_POS_TYPE_WINK, true, false);
	}
	else
	{
		onBeforeChangeMap(sceneID, destPos, LOAD_ROLE_TYPE_CHANGE_MAP, type);
		setChangePos(sceneID, destPos);
		onAfterChangeMap(sceneID, destPos, LOAD_ROLE_TYPE_CHANGE_MAP, type);
		CMapSceneBase* pScene = DSceneMgr.findScene(sceneID);
		if (pScene)
		{
			sendEnterScene(pScene->getSceneType());
		}
	}

	FUNC_END(DRET_NULL);
}

EGameRetCode CRole::openDynamicMap(TMapID_t mapID)
{
	if (_changeLineWait.openDynaMapFlag)
	{
		return RC_MAP_OPENING_DYNAMAP;
	}

	if (_changeLineWait.changeLineFlag)
	{
		return RC_MAP_CHANGING_LINE;
	}

	CMapConfigTbl* pMapConfig = DMapTblMgr.find(mapID);
	if (NULL == pMapConfig)
	{
		gxError("Cant find map config!!!MapID={0}", mapID);
		return RC_CANT_ENTER_RISK_MAP;
	}

	if (DMapServer->canOpenDynamicMap())
	{
		return openLocalDynamicMap(mapID);
	}
	else
	{
		return openRemoteDynamicMap(mapID);
	}
}

EGameRetCode CRole::openRemoteDynamicMap(TMapID_t mapID)
{
	FUNC_BEGIN(SCENE_MOD);

	if (_changeLineWait.openDynaMapFlag)
	{
		return RC_MAP_OPENING_DYNAMAP;
	}

	if (_changeLineWait.changeLineFlag)
	{
		return RC_MAP_CHANGING_LINE;
	}

	CMapConfigTbl* pMapConfig = DMapTblMgr.find(mapID);
	if (NULL == pMapConfig)
	{
		gxError("Can't find map id!MapID={0}, {1}", mapID, toString());
		return RC_MAP_NOT_FIND;
	}

	EGameRetCode retCode = checkEnterDynaMap(mapID);
	if (!IsSuccess(retCode))
	{
		return retCode;
	}

	gxAssert(false);

// 	MWOpenDynamicMap openRisk;
// 	openRisk.objUID = getObjUID();
// 	openRisk.mapID = mapID;
// 	openRisk.sceneType = (ESceneType)pMapConfig->mapType;
// 
// 	if (!SendToWorld(openRisk))
// 	{
// 		return RC_MAP_NOT_FIND;
// 	}
// 
// 	_changeLineWait.startOpenMap(mapID);

	return RC_SUCCESS;

	FUNC_END(RC_MAP_NOT_FIND);
}

EGameRetCode CRole::openLocalDynamicMap(TMapID_t mapID)
{
	FUNC_BEGIN(SCENE_MOD);

	EGameRetCode retCode = checkEnterDynaMap(mapID);
	if (!IsSuccess(retCode))
	{
		return retCode;
	}

	CMapConfigTbl* pMapConfig = DMapTblMgr.find(mapID);
	if (NULL == pMapConfig)
	{
		gxError("Can't find map id!MapID={0}, {1}", mapID, toString());
		return RC_CANT_ENTER_RISK_MAP;
	}

	COpenDynamicScene openSceneTask;
	openSceneTask.setParam(getObjUID(), mapID, &TAxisPos(pMapConfig->x, pMapConfig->y), (ESceneType)pMapConfig->mapType);
	if (!DMapServer->getTaskQue()->pushTask(openSceneTask))
	{
		return RC_CANT_ENTER_RISK_MAP;
	}
	_changeLineWait.startOpenMap(mapID);

	return RC_SUCCESS;

	FUNC_END(RC_CANT_ENTER_RISK_MAP);
}

bool CRole::getNormalMapScene(TMapID_t mapID, TServerID_t& mapServerID, TSceneID_t& sceneID)
{
	FUNC_BEGIN(SCENE_MOD);

	CMapConfigTbl* pMapRow = DMapTblMgr.find(mapID);
	if (NULL == pMapRow)
	{
		gxError("Can't find map row!MapID={0}, {1}", mapID, toString());
		return false;
	}

	if (!CGameMisc::IsDynamicMap((ESceneType)pMapRow->mapType))
	{
		CMapSceneBase* destScene = DSceneMgr.getLeastScene(mapID);
		if (NULL == destScene)
		{
			gxAssert(false);
// 			TSceneData* pSceneData = DMapServerPlayerMgr.getLeastScene(mapID);
// 			if (NULL == pSceneData)
// 			{
// 				gxError("Can't find dest map!MapID=%u,%s", mapID, toString());
// 				return false;
// 			}
// 
// 			mapServerID = pSceneData->mapServerID;
// 			sceneID = pSceneData->sceneID;
// 			return true;
		}
		else
		{
			mapServerID = DMapServer->getServerConfig()->getMapServerID();
			sceneID = destScene->getSceneID();
			return true;
		}
	}

	return false;

	FUNC_END(false);
}

void CRole::onOpenDynamicMap(TSceneID_t sceneID, const TAxisPos* pos, TServerID_t mapServerID, EGameRetCode retCode)
{
	FUNC_BEGIN(SCENE_MOD);

	_changeLineWait.cleanUpOpenMap();
	gxInfo("Open risk map ret!RetCode={0}, SceneID={1}, MapServerID={2}", retCode, sceneID, mapServerID);

	if (IsSuccess(retCode))
	{
		// 将角色拉进场景
		moveToDynamicMap(sceneID, pos, mapServerID);
	}
	else
	{
		gxAssert(false);
	}

	FUNC_END(DRET_NULL);
}

void CRole::onChangeLineRet()
{
	// 玩家已经切线返回, 需要断开并连接新的服务器
	_canMoveFlag = false;
	_initFlag = false;
}

void CRole::moveAllToDynamicMap(TSceneID_t sceneID, const TAxisPos* pos, TRoleUID_t roleUID, TServerID_t mapServerID)
{
	// 自己是场景所有者
	gxAssert(getRoleUID() == roleUID);
	if (roleUID != getRoleUID())
	{
		gxError("Move all role to dynamic map, scene is not owner!!!DestRoleUID={0},MyRoleUID={1},SceneID={2},ServerID={3}",
			roleUID, getRoleUID(), sceneID, mapServerID);
		return;
	}

	// 将自己移动到场景中
	moveToDynamicMap(sceneID, pos, mapServerID);

	// 通知其他玩家移动到场景中
	//sendOtherChangeScene();
}

EGameRetCode CRole::moveToDynamicMap(TSceneID_t sceneID, const TAxisPos* pos, TServerID_t mapServerID)
{
//	FUNC_BEGIN(RISKMAP_MOD);
	gxDebug("Begin move role to risk map!!!RoleName = {0}, ObjUID = {1}, SceneID={2}, MapServerID={3}",
		getRoleName().toString(), getObjUID(), sceneID, mapServerID);

	if (mapServerID == DMapServer->getServerID())
	{
		// 副本在当前服务器
		CMapSceneBase* pScene = DSceneMgr.findScene(sceneID);
		if (NULL == pScene)
		{
			gxError("Enter risk map failed, cant find scene!!!SceneID={0}", sceneID);
			sendErrorCode(RC_CANT_ENTER_RISK_MAP);
			return RC_CANT_ENTER_RISK_MAP;
		}

		// 切换场景
		toDestScene(sceneID, pos, TELEPORT_TYPE_RISK_ENTER);
	}
	else
	{
		// 其他服务器, 切线
		gxAssert(false);
	}

	// 通知相关人员进入对应场景

// 	bool needAddTimes = true;
// 	TMapID_t srcMapID = getMapID();
// 	CRiskMapConfigTbl* srcRiskMapConfig = DRiskMapTblMgr.find(srcMapID);
// 	if (srcRiskMapConfig != NULL && srcRiskMapConfig->identifyMap == riskMapConfig->identifyMap && mapConfig->mapType == SCENE_TYPE_LEI_FENG_TA)
// 	{
// 		needAddTimes = false;
// 	}
// 	TMapRangePos tempPos;
// 	tempPos = mapConfig->massPos[0];
// 
// 	_riskMapComp.setEnteringRisk(true);
// 
// 	if (!riskMapConfig->isTeamRiskMap())
// 	{
// 		if (needAddTimes)
// 		{
// 			_riskMapComp.addEnterNum(riskMapConfig->identifyMap);
// 		}
// 		changeLine(sceneID, mapServerID, tempPos.pos, TELEPORT_TYPE_RISK_ENTER);
// 		gxDebug(RISKMAP_MOD"Single risk map!!! Move the role to the risk map!!! roleName = %s, objUID = %u, mapID = %u",
// 			getRoleName().toString(), getObjUID(), mapID);
// 		return;
// 	}
// 	TeamMemberMap memberContainer;
// 	_team.getTeamMember(memberContainer);
// 	TeamMemberItr itr = memberContainer.begin();
// 	for (; itr != memberContainer.end(); ++itr)
// 	{
// 		TObjUID_t objUID = itr->first;
// 		CRole* pRole = DRoleManager.findByObjUID(objUID);
// 		if (pRole == NULL)
// 		{
// 			gxDebug(RISKMAP_MOD"Move role to team risk map!!! But not find the role!!! objUID = %u", objUID);
// 			continue;
// 		}
// 		if (!isInValidRadius(pRole, MAX_SAME_SCREEN_RANGE + 10))
// 		{
// 			gxDebug(RISKMAP_MOD"Move role to team risk map!!! But the role is too far away the leader!!! destRoleName = %s, destRoleObjUID = %u, srcRoleName = %s, srcRoleObjUID = %u",
// 				pRole->getRoleName().toString(), objUID, getRoleName().toString(), getObjUID());
// 			continue;
// 		}
// 		TRetCode_t retCode = pRole->changeLine(sceneID, mapServerID, tempPos.pos, TELEPORT_TYPE_RISK_ENTER);
// 		if (retCode != RC_SUCCESS)
// 		{
// 			gxError("Move role to risk map failed!!! retCode = %u, objUID = %u, roleName = %s", retCode, getObjUID(), getRoleName().toString());
// 			return;
// 		}
// 		if (needAddTimes)
// 		{
// 			pRole->getRiskMapComp().addEnterNum(riskMapConfig->identifyMap);
// 		}
// 		gxDebug("Team risk map!!! Move the role to the risk map!!! roleName = {0}, objUID = {1}, mapID = {2}",
// 			pRole->getRoleName().toString(), objUID, mapID);
// 	}

//	FUNC_END(DRET_NULL);

	return RC_SUCCESS;
}

void CRole::sendEnterScene(ESceneType type)
{
	MCEnterScene enterScenePacket;
	enterScenePacket.mapType = type;
	sendPacket(enterScenePacket);
}

void CRole::sendOtherChangeScene(TObjUID_t objUID, TSceneID_t sceneID, const TAxisPos* pos)
{
	MMChangeScene changeScenePacket;
	changeScenePacket.roleUID = getRoleUID();
	changeScenePacket.sceneID = sceneID;
	changeScenePacket.pos = *pos;
	changeScenePacket.sceneID = DMapServer->getServerID();

	Trans2OtherMapServer(changeScenePacket, getObjUID(), objUID, false);
}

TChangeLineWait* CRole::getChangeLineWait()
{
	return &_changeLineWait;
}

EGameRetCode CRole::transport(TTransportTypeID_t transportTypeID)
{
	FUNC_BEGIN(SCENE_MOD);

	if (getLoadWaitData()->canTransmit()){
		gxError("Can't transport, is change scene!{0},TransportTypeID={1}", toString(), transportTypeID);
		return RC_MAP_CHANGE_LINE_WAIT;
	}

	if (getScene() == NULL)
	{
		gxError("Can't transport, not in scene!{0},TransportTypeID={1}", toString(), transportTypeID);
		return RC_MAP_FAILD;
	}
	CTransportConfigTbl* pTransportRow = DTransportTblMgr.find(transportTypeID);
	if (NULL == pTransportRow)
	{
		gxError("Can't find transport!TransportTypeID={0},{1}", transportTypeID, toString());
		return RC_MAP_NO_TRANSMIT_ID;
	}

	CTransportConfigTbl* pTransportDestRow = DTransportTblMgr.find(pTransportRow->otherID);
	if (NULL == pTransportDestRow)
	{
		gxError("Can't find transport!TransportTypeID={0},{1}", pTransportRow->otherID, toString());
		return RC_MAP_NO_TRANSMIT_ID;
	}

	CMapSceneBase* pScene = DSceneMgr.getLeastScene(pTransportDestRow->mapID);
	if (NULL == pScene)
	{
		gxError("Transmite failed, can't find empty scene!TransportTypeID={0},MapID={1},{2}", transportTypeID, pTransportDestRow->mapID, toString());
		return RC_MAP_NO_FIND_DEST_MAP;
	}

	toDestScene(pScene->getSceneID(), &pTransportDestRow->pos, TELEPORT_TYPE_TRANSMIT);

	return RC_SUCCESS;

	FUNC_END(RC_FAILED);
}

EGameRetCode CRole::changeLine(TServerID_t serverID, TSceneID_t sceneID, const TAxisPos* pos, ETeleportType type)
{
	FUNC_BEGIN(CHANGELINE_MOD);

	EGameRetCode retCode = RC_SUCCESS;

	TAxisPos tempPos = *pos;

	TMapID_t mapID = CGameMisc::GetMapID(sceneID);
	CMapConfigTbl* pMapRow = DMapTblMgr.find(mapID);
	if (NULL == pMapRow)
	{
		gxAssert(false);
		return RC_MAP_NOT_FIND;
	}

	CMapBase* pMap = DMapDataMgr.find(CGameMisc::GetMapID(sceneID));
	if (NULL == pMap)
	{
		gxAssert(false);
		return RC_MAP_NOT_FIND;
	}
	if (!pMap->isCanWalk(tempPos.x, tempPos.y))
	{
		tempPos = *pMap->getEmptyPos();
		if (!pMap->findEmptyPos(&tempPos, 2))
		{
			return RC_MAP_NOT_FIND;
		}
	}

	retCode = checkEnterDynaMap(mapID);
	if (!IsSuccess(retCode))
	{
		return retCode;
	}

	CMapScene* pScene = DSceneMgr.findScene(sceneID);
	if (NULL != pScene)
	{
		// 直接切换场景
		toDestScene(sceneID, pos, type);
		return RC_SUCCESS;
	}

	if (_changeLineWait.openDynaMapFlag)
	{
		return RC_MAP_OPENING_DYNAMAP;
	}

	if (_changeLineWait.changeLineFlag)
	{
		return RC_MAP_CHANGING_LINE;
	}

	MWChangeLine changeLinePacket;
	changeLinePacket.objUID = getObjUID();
	changeLinePacket.sceneID = sceneID;
	changeLinePacket.pos = tempPos;
	changeLinePacket.mapServerID = serverID;
	changeLinePacket.lastSceneID = getSceneID();
	changeLinePacket.lastPos = *getAxisPos();
	changeLinePacket.lastMapServerID = DMapServer->getServerID();
	onBeforeChangeLine(&changeLinePacket.changeLineTempData, CGameMisc::GetMapID(sceneID), pos, serverID, type);
	if (!SendToWorld(changeLinePacket))
	{
		gxError("Can't send to world!{0}", toString());
		return RC_MAP_NOT_FIND;
	}
	_changeLineWait.startChangeLine(DMapServer->getServerID(), getMapID(), getSceneID(), *getAxisPos(), serverID, sceneID, tempPos);
	if (DMapServer->isDynamicServer())
	{
		//onRoleLeaveDynamicScene();
		gxAssert(false);
	}

	leaveScene(true);

	gxInfo("Send to world request change line!SceneID={0}, Pos={1}, MapServerID={2}, {3}",
		sceneID, tempPos.toString(), serverID, toString());
	clearMovePos();

	return RC_SUCCESS;

	FUNC_END(RC_FAILED);
}
