#include "core/game_exception.h"

#include "packet_mw_trans.h"
#include "module_def.h"
#include "world_map_server_handler_base.h"
#include "world_map_player_mgr.h"
#include "world_player.h"
#include "world_player_mgr.h"
#include "world_user_mgr.h"
#include "world_user.h"
#include "scene_manager.h"
#include "rand_name.h"
#include "packet_cm_base.h"
#include "packet_mw_base.h"
#include "packet_wb_base.h"
#include "world_sql_manager.h"
#include "charging_rmb.h"
#include "world_charging_server_handler.h"
#include "recharge_def.h"
#include "world_server.h"

bool CWorldMapServerHandlerBase::start()
{
	FUNC_BEGIN(WORLD_MAP_SERVER_MOD);

	setIgnore();
	gxInfo("World and map server connect start!");

	return true;

	FUNC_END(false);
}

void CWorldMapServerHandlerBase::close()
{
	FUNC_BEGIN(WORLD_MAP_SERVER_MOD);

	gxInfo("CWorldMapServerHandler close! {0}", toString());
	if(_serverID != INVALID_SERVER_ID)
	{
		DWorldMapPlayerMgr.delMapPlayer(_serverID);
		DSceneMgr.delMapServer(_serverID);
		DWorldPlayerMgr.closeByMapServer(_serverID);
	}

	FUNC_END(DRET_NULL);
}

void CWorldMapServerHandlerBase::breath( GXMISC::TDiffTime_t diff )
{
	FUNC_BEGIN(WORLD_MAP_SERVER_MOD);

	TBaseType::breath(diff);

	FUNC_END(DRET_NULL);
}

void CWorldMapServerHandlerBase::quit()
{
	FUNC_BEGIN(WORLD_MAP_SERVER_MOD);

	FUNC_END(DRET_NULL);
}

void CWorldMapServerHandlerBase::setServerID( TServerID_t serverID )
{
	_serverID = serverID;
}

TServerID_t CWorldMapServerHandlerBase::getServerID()
{
	return _serverID;
}

void CWorldMapServerHandlerBase::genStrName()
{
	_strName = GXMISC::gxToString("SocketIndex = %"I64_FMT"u, ServerID = %u",
		getSocketIndex(), getServerID());
}

const char* CWorldMapServerHandlerBase::toString()
{
	return _strName.c_str();
}

CWorldMapPlayer* CWorldMapServerHandlerBase::getWorldMapPlayer()
{
	FUNC_BEGIN(WORLD_MAP_SERVER_MOD);

	CWorldMapPlayer* player = DWorldMapPlayerMgr.findMapPlayer(getServerID());
	if (NULL == player)
	{
		gxWarning("Can't find CWorldMapPlayer! {0}", toString());
		return NULL;
	}

	return player;

	FUNC_END(NULL);
}

void CWorldMapServerHandlerBase::RegisterTransHandler( TPacketID_t id, TTransPacketHandler handler )
{
	FUNC_BEGIN(WORLD_MAP_SERVER_MOD);

	TransPacketHash.insert(TTransPacketHandlerHash::value_type(id, handler));

	FUNC_END(DRET_NULL);
}

GXMISC::EHandleRet CWorldMapServerHandlerBase::doTransToWorld(char* msg, uint32 len, TObjUID_t objUID)
{
	FUNC_BEGIN(WORLD_MAP_SERVER_MOD);

	gxAssert(msg != NULL);
	CBasePacket* packet = (CBasePacket*)msg;
	gxAssert(packet->totalLen == len);
	if(false == packet->check())
	{
		gxError("Pack is invalid! TotalLen={0}, PacketID={1}", packet->totalLen, packet->packetID);
	}

	TTransPacketHandlerHash::iterator iter = TransPacketHash.find(packet->getPacketID());
	if(iter != TransPacketHash.end())
	{
		TTransPacketHandler handler = iter->second;
		GXMISC::EHandleRet ret = (this->*handler)(packet, objUID);
		return ret;
	}
	else
	{
		gxError("Can't find trans packet! {0}", packet->getPacketID());
	}

	return GXMISC::HANDLE_RET_FAILED;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);

}

GXMISC::EHandleRet CWorldMapServerHandlerBase::handleMapServreRegiste( MWRegiste* packet )
{
	FUNC_BEGIN(WORLD_MAP_SERVER_MOD);

	WMRegisteRet retPacket;
	retPacket.setRetCode(RC_FAILED);
	gxInfo("Map server registe to world server! {0}", packet->toString());
	CWorldMapPlayer* mapPlayer = DWorldMapPlayerMgr.addMapPlayer(packet->serverData.serverID);
	if (NULL == mapPlayer) {
		gxError("Can't add CWorldMapPlayer! {0}", packet->toString().c_str());
		sendPacket(retPacket);
		return GXMISC::HANDLE_RET_OK;
	}

	retPacket.setRetCode(mapPlayer->registe(packet->serverData.scenes, packet->serverData.serverID, packet->serverType, packet->serverData.maxRoleNum, packet->clientListenIP, packet->clientListenPort));
	if(!IsSuccess(retPacket.getRetCode()))
	{
		gxError("Map server register failed!{0}, retCode={1}", packet->toString().c_str(), retPacket.getRetCode());
		DWorldMapPlayerMgr.delMapPlayer(mapPlayer->getServerID());
		sendPacket(retPacket);
	}
	else
	{
		mapPlayer->setSocketIndex(getSocketIndex());
		setServerID(packet->serverData.serverID);
	}

	retPacket.worldServerID = DWorldServer->getWorldServerID();
	sendPacket(retPacket);

	onMapServerRegiste(packet->serverData.serverID);

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CWorldMapServerHandlerBase::handleLoadRoleData(MWLoadRoleDataRet* packet)
{
	gxInfo("Load role data ret! {0},ReturnCode={1}", packet->toString(), packet->getRetCode());

	CWorldPlayer* player = DWorldPlayerMgr.findByAccountID(packet->loadData.accountID);
	if (NULL == player) 
	{
		// 无法找到对应的账号
		gxError("Can't find player! {0}", packet->toString().c_str());
		gxAssert(false);
		WMUnloadRoleData unloadRoleDataPack;
		unloadRoleDataPack.objUID = packet->loadData.objUID;
		unloadRoleDataPack.accountID = packet->userData.accountID;
		unloadRoleDataPack.roleUID = packet->userData.roleUID;
		unloadRoleDataPack.socketIndex = GXMISC::INVALID_SOCKET_INDEX;
		unloadRoleDataPack.needRet = false;
		sendPacket(unloadRoleDataPack);
		return GXMISC::HANDLE_RET_OK;
	}

#ifdef LIB_DEBUG
	if(player->getSocketIndex() != packet->socketIndex)
	{
		// 对象的Socket唯一标识正确
		gxError("Socket index is invalid! {0},{1}", packet->toString(), player->toString());
		gxAssert(false);
		return GXMISC::HANDLE_RET_OK;
	}
#endif

	if(!IsSuccess(player->onBeforeResponse(PA_LOAD_ROLE_RES)))
	{
		return GXMISC::HANDLE_RET_OK;
	}

	if (IsSuccess(packet->getRetCode()))
	{
		WCLoginGameRet loginGameRet;
		loginGameRet.setRetCode(RC_SUCCESS);
		if(player->getSocketIndex() != packet->socketIndex)
		{
			// 对象的Socket唯一标识正确
			gxError("Socket index is invalid! {0},{1}", packet->toString(), player->toString());
			gxAssert(false);
			return GXMISC::HANDLE_RET_OK;
		}

		gxInfo("Player load role data ok!{0}", player->toString());
		// 获取地图服务器对象
		CWorldMapPlayer* mapPlayer = getWorldMapPlayer();
		if (NULL == mapPlayer) {
			gxAssert(false);
			gxError("WorldMapPlayer is NULL! {0}", packet->toString().c_str());
			player->unloadRoleDataReq(UNLOAD_ROLE_TYPE_QUIT, false);
			loginGameRet.setRetCode(RC_FAILED);
			player->sendPacket(loginGameRet);
			return GXMISC::HANDLE_RET_OK;
		}

		// 加载角色数据
		gxAssert(packet->loadData.accountID == player->getAccountID());
		gxAssert(packet->loadData.roleUID == player->getCurrentRoleUID());
		if (!IsSuccess(player->loadRoleDataSuccess(&packet->userData, _serverID, CGameMisc::GetMapID(packet->loadData.sceneID))))
		{
			loginGameRet.setRetCode(RC_FAILED);
			player->sendPacket(loginGameRet);
			player->quit(true, "Load role data failed!");
			return GXMISC::HANDLE_RET_OK;
		}

		loginGameRet.roleUID = player->getFirstRoleUID();
		loginGameRet.serverIP = mapPlayer->getClientListenIP();
		loginGameRet.serverPort = mapPlayer->getClientListenPort();
		player->sendPacket(loginGameRet);
		gxInfo("Send load response to client!{0}", toString());
	}
	else
	{
		// 不允许再使用Player对象
		if(!player->loadRoleDataFailed(&packet->loadData, (EGameRetCode)packet->getRetCode()))
		{
			player->quit(true, "Change line load failed!");
		}
	}

	return GXMISC::HANDLE_RET_OK;
}

GXMISC::EHandleRet CWorldMapServerHandlerBase::handleUnloadRoleData(MWUnloadRoleDataRet* packet)
{
	gxInfo("Unload role data ret! {0}", packet->toString());

	CWorldPlayer* player = DWorldPlayerMgr.findByAccountID(packet->accountID);
	if (NULL == player)
	{
		gxError("Can't find player! {0}", packet->toString());
		gxAssert(false);

		CWorldUser* pUser = DWorldUserMgr.findUserByRoleUID(packet->roleUID);
		if(NULL != pUser)
		{
			player = DWorldPlayerMgr.findByAccountID(pUser->getAccountID());
		}
	}

	if(NULL == player)
	{
		gxError("Can't find player! {0}", packet->toString());
		if(DWorldUserMgr.isExistByRoleUID(packet->roleUID))
		{
			DWorldUserMgr.delUserByRoleUID(packet->roleUID);
		}
		return GXMISC::HANDLE_RET_OK;
	}

	if(packet->unloadType != UNLOAD_ROLE_TYPE_ERROR && packet->socketIndex != player->getSocketIndex())
	{
		gxError("Unload role data ret, socket index is invalid! {0},{1}", packet->toString(), player->toString());
		gxAssert(false);
		return GXMISC::HANDLE_RET_OK;
	}

	// 	if(!IsSuccess(player->onBeforeResponse(PA_UNLOAD_ROLE_RES)))
	// 	{
	// 		assert(false);
	// 		return GXMISC::HANDLE_RET_OK;
	// 	}

	if(IsSuccess(packet->getRetCode()))
	{
		player->unloadRoleDataSuccess(packet->roleUID);
	}
	else
	{
		player->unloadRoleDataFailed(packet->roleUID);
	}

	return GXMISC::HANDLE_RET_OK;
}

GXMISC::EHandleRet CWorldMapServerHandlerBase::handleRoleQuit( MWRoleQuit* packet )
{
	gxInfo("Role request quit game!{0}", packet->toString());

	CWorldPlayer* player = DWorldPlayerMgr.findByAccountID(packet->accountID);
	if (NULL == player)
	{
		gxError("Can't find player! {0}", packet->toString().c_str());

		gxAssert(!DWorldUserMgr.isExistByRoleUID(packet->roleUID));
		if (DWorldUserMgr.isExistByRoleUID(packet->roleUID))
		{
			DWorldUserMgr.delUserByRoleUID(packet->roleUID);
		}

		return GXMISC::HANDLE_RET_OK;
	}

	if(player->getSocketIndex() != packet->socketIndex)
	{
		gxError("Role quit, socket index is invalid!{0},{1}", player->toString(), packet->toString());
		gxAssert(false);
		return GXMISC::HANDLE_RET_OK;
	}

	player->onBeforeRequst(PA_QUIT_GAME_REQ);
	player->quitGameReq(packet->roleUID);

	return GXMISC::HANDLE_RET_OK;
}

GXMISC::EHandleRet CWorldMapServerHandlerBase::handleUserLogin( MWUserLogin* packet )
{
	CWorldUser* user = DWorldUserMgr.findUserByObjUID(packet->objUID);
	if(NULL == user)
	{
		gxError("Can't find user!OjbUID={0}", packet->objUID);
		return GXMISC::HANDLE_RET_OK;
	}

	CWorldPlayer* player = DWorldPlayerMgr.findByAccountID(user->getAccountID());
	if(NULL != player)
	{
		player->onUserLogin();
	}

	if(packet->firstLogin)
	{
		// 第一次登陆
		user->online();
	}

	return GXMISC::HANDLE_RET_OK;
}

typedef struct _BoradCastArg
{
	TServerID_t mapServerID;
	MWBroadPacket* packet;
}TBoradCastArg;
static void WorldBroadCast(CWorldMapPlayer*& mapPlayer, void* arg)
{
	TBoradCastArg* broadArg = (TBoradCastArg*)arg;
	if(NULL == broadArg || mapPlayer == NULL || (mapPlayer->getServerID() == broadArg->mapServerID && broadArg->packet->sendToMe == false))
	{
		return;
	}

	mapPlayer->send((const char*)broadArg->packet, broadArg->packet->getPackLen());
}
GXMISC::EHandleRet CWorldMapServerHandlerBase::handleBroadCast( MWBroadPacket* packet )
{
	TBoradCastArg arg;
	arg.mapServerID = getServerID();
	arg.packet = packet;
	DWorldMapPlayerMgr.traverse(&WorldBroadCast, &arg);
	return GXMISC::HANDLE_RET_OK;
}

GXMISC::EHandleRet CWorldMapServerHandlerBase::handleTrans( MWTransPacket* packet )
{
	WMTransPacketError transErr;
	CWorldUser* pUser = DWorldUserMgr.findUserByObjUID(packet->destObjUID);
	if(NULL == pUser)
	{
		transErr.setRetCode(RC_ROLE_OFFLINE);
		transErr.srcObjUID = packet->srcObjUID;
		transErr.destObjUID = packet->destObjUID;
		transErr.msg = packet->msg;
		sendPacket(transErr);
		return GXMISC::HANDLE_RET_OK;
	}

	CWorldMapPlayer* mapPlayer = DWorldMapPlayerMgr.findMapPlayer(pUser->getMapServerID());
	if(NULL == mapPlayer)
	{
		transErr.setRetCode(RC_ROLE_OFFLINE);
		transErr.srcObjUID = packet->srcObjUID;
		transErr.destObjUID = packet->destObjUID;
		transErr.msg = packet->msg;
		sendPacket(transErr);
		return GXMISC::HANDLE_RET_OK;
	}

	CWorldMapServerHandler* mapHandler = mapPlayer->getMapServerHandler();
	if(NULL == mapHandler)
	{
		transErr.setRetCode(RC_ROLE_OFFLINE);
		transErr.srcObjUID = packet->srcObjUID;
		transErr.destObjUID = packet->destObjUID;
		transErr.msg = packet->msg;
		sendPacket(transErr);
		return GXMISC::HANDLE_RET_OK;
	}

	mapHandler->sendPacket(*packet);

	return GXMISC::HANDLE_RET_OK;
}

GXMISC::EHandleRet CWorldMapServerHandlerBase::handleTrans2World( MWTrans2WorldPacket* packet )
{
	return doTransToWorld(packet->msg.data(), packet->msg.size(), packet->destObjUID);
}

GXMISC::EHandleRet CWorldMapServerHandlerBase::handleRoleKick( MWRoleKick* packet )
{
	FUNC_BEGIN(ROLE_MOD);

	CWorldPlayer* player = DWorldPlayerMgr.findByAccountID(packet->accountID);
	if(NULL != player)
	{
		if(player->getCurrentRoleUID() == packet->roleUID && player->getSocketIndex() == packet->socketIndex)
		{
			player->setPlayerStatus(PS_QUIT);
			player->quit(true, "Role kick!");
		}
		else
		{
			if(DWorldUserMgr.isExistByRoleUID(packet->roleUID))
			{
				DWorldUserMgr.delUserByRoleUID(packet->roleUID);
			}
		}
	}

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CWorldMapServerHandlerBase::handleRoleHeart( MWRoleHeart* packet )
{
	FUNC_BEGIN(ROLE_MOD);

	WMRoleHeartRet roleHeartRet;
	for(sint32 i = 0; i < packet->roles.size(); ++i)
	{
		CWorldPlayer* player = DWorldPlayerMgr.findByAccountID(packet->roles[i].accountID);
		if(NULL != player && player->getCurrentRoleUID() == packet->roles[i].roleUID)
		{
#ifdef SERVER_DEBUG
			// 检测Role和User的MapServerID是否一致
			CWorldUser* pUser = DWorldUserMgr.findUserByRoleUID(packet->roleUID);
			gxAssert(pUser != NULL);
			if(NULL != pUser)
			{
				gxAssert(pUser->getMapServerID() == getServerID());
			}
#endif
			packet->roles[i].onlineFlag = true;
			player->onRoleHeart();
		}
		else
		{
			gxError("Role heart failed, can't find player!RoleUID={0},AccountID={1}", packet->roles[i].roleUID, packet->roles[i].accountID);
			packet->roles[i].onlineFlag = false;
			if(DWorldUserMgr.isExistByRoleUID(packet->roles[i].roleUID))
			{
				DWorldUserMgr.delUserByRoleUID(packet->roles[i].roleUID);
			}
		}

		roleHeartRet.roles.pushBack(packet->roles[i]);
	}
	
	sendPacket(roleHeartRet);

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CWorldMapServerHandlerBase::handleRandRoleName( MWRandRoleName* packet )
{
	FUNC_BEGIN(ROLE_MOD);

	std::string roleName = DRandRoleMgr.randRoleName(packet->sex);
	MCRandRoleNameRet randRoleNameRet;
	randRoleNameRet.roleName = roleName;
	randRoleNameRet.setRetCode(RC_SUCCESS);
	CWorldUser* pUser = DWorldUserMgr.findUserByRoleUID(packet->roleUID);
	if(NULL != pUser){
		pUser->sendPackTrans(randRoleNameRet);
	}else{
		gxError("Rand role name, cant get user!RoleUID={0}", packet->roleUID);
	}

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CWorldMapServerHandlerBase::handleRenameRoleName( MWRenameRoleName* packet )
{
	FUNC_BEGIN(ROLE_MOD);

	WMRenameRoleNameRet renameRet;
	renameRet.roleUID = packet->roleUID;
	renameRet.roleName = packet->roleName;

	if ( !IsSuccess(DCheckText.isTextPass(packet->roleName.toString())) )
	{
		gxWarning("invalid role name!Name={0}", packet->roleName.toString());
		renameRet.setRetCode(RC_LOGIN_ROLE_NAME_INVALID);
	}
	else{
		if(DWorldUserMgr.renameRoleName(packet->roleUID, packet->roleName.toString())){
			renameRet.setRetCode(RC_SUCCESS);
			gxInfo("Role rename success!RoleUID={0},RoleName={1}", packet->roleUID, packet->roleName.toString());
		}else{
			renameRet.setRetCode(RC_LOGIN_RENAME_REPEAT);
			gxError("Role rename failed!RoleUID={0},RoleName={1}", packet->roleUID, packet->roleName.toString());
		}
	}

	sendPacket(renameRet);

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CWorldMapServerHandlerBase::handleGetRandNameList( MWGetRandNameList* packet )
{
	FUNC_BEGIN(ROLE_MOD);

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CWorldMapServerHandlerBase::handleRechargeRet( MWRechargeRet* packet )
{
	FUNC_BEGIN(BILL_MOD);

	WBRechargeRet rechargeGetRet;

	CWorldPlayer* pPlayer = DWorldPlayerMgr.findByAccountID(packet->accountID);
	if(NULL != pPlayer)
	{
		pPlayer->closeRecharge();
	}

	if(packet->isSuccess())
	{
		// 充值成功
		gxInfo("Recharge ret success!AccountID={0},RoleUID={1},MapServerID={2},SerialNo={3},Rmb={4},BindRmb={5}",
			packet->accountID, packet->roleUID, getServerID(), packet->serialNo.toString(), packet->rmb, packet->bindRmb);

		DRECHARGE_LOG(packet->serialNo, DWorldServer->getConfig()->getWorldServerID(), packet->accountID, packet->rmb,
			packet->bindRmb, packet->getRetCode(), "Start charge rmb to map server");

		if(!DSqlConnectionMgr.updateTempRechargeRecord(packet->serialNo, 3))
		{
//			gxError("Can't up date recharge record!SerilaNo={0},RoleUID={1}", packet->serialNo.c_str(), packet->roleUID);

			DRECHARGE_LOG(packet->serialNo, DWorldServer->getConfig()->getWorldServerID(), packet->accountID, packet->rmb,
				packet->bindRmb, packet->getRetCode(), "Can't up date recharge record");

		}
		rechargeGetRet.onlineFlag = 1;
		CBillMod::OnChargeRmb(packet->serialNo, packet->accountID, packet->roleUID, packet->rmb, packet->bindRmb);
		if(packet->isFirstCharge)
		{
			CBillMod::OnFirstChargeRmb(packet->accountID, packet->roleUID, packet->serialNo, packet->rmb);
		}
	}
	else
	{
		// 充值到账号中去
		// rechargeGetRet.setRetCode(CBillMod::RechargeToAccount(packet->serialNo, packet->accountID, packet->rmb, packet->bindRmb, pPlayer, NULL));
		rechargeGetRet.onlineFlag = false;
	}
	rechargeGetRet.setRetCode(packet->getRetCode());
	rechargeGetRet.accountID = packet->accountID;
	rechargeGetRet.serialNo = packet->serialNo;
	rechargeGetRet.rmb = packet->rmb;
	rechargeGetRet.bindRmb = packet->bindRmb;

	if(!SendToChargingServer(rechargeGetRet))
	{
		gxError("Can't send to bill server!AccountID={0},RoleUID={1},MapServerID={2},SerialNo={3},Rmb={4},BindRmb={5}",
			packet->accountID, packet->roleUID, getServerID(), packet->serialNo.toString(), packet->rmb, packet->bindRmb);
	}

	DRECHARGE_LOG(packet->serialNo, DWorldServer->getConfig()->getWorldServerID(), packet->accountID, packet->rmb,
		packet->bindRmb, packet->getRetCode(), "Charge rmb to map server return!");

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_OK);
}

TTransPacketHandlerHash CWorldMapServerHandlerBase::TransPacketHash;
