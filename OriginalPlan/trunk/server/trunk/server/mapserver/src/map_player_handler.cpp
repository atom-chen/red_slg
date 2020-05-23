#include "map_player_handler.h"
#include "game_exception.h"
#include "module_def.h"
#include "role.h"
#include "role_manager.h"
#include "scene_manager.h"
#include "gm_manager.h"
#include "packet_cm_base.h"
#include "script_engine.h"
#include "game_config.h"
#include "packet_cl_login.h"
#include "map_server_data.h"
#include "map_db_server_handler.h"

#define DPacketCheckHeader(pack, retp, errorCode)	\
if (!isFilterPacket(pack->packetID)) \
	{   \
if (pack->totalLen < sizeof(*pack))  \
		{   \
		gxError("Packet is less!{0}, {1}", toString(), pack->packetID);  \
		gxAssert(false);	\
		retp* ret = new retp();   \
		ret->setRetCode(errorCode);   \
		sendPacket(*ret);   \
		delete ret; \
		return GXMISC::HANDLE_RET_OK;   \
		}   \
		gxDebug("Handle {0},IP={1}!", typeid(pack).name(), getRemoteIp());		\
	}

#define DPacketCheckAndRet(pack, retp)   \
	CRole* pRole = NULL;{	\
	DPacketCheckHeader(pack, retp, RC_FAILED)	\
	pRole = getRole();    \
	if(NULL == pRole)  \
	{   \
	gxError("Can't find role!{0}", toString());   \
	if(isValid()){    \
	retp* ret = new retp();   \
	ret->setRetCode(RC_FAILED);   \
	sendPacket(*ret);   \
	delete ret; \
	}   \
	return GXMISC::HANDLE_RET_OK;   \
	}}

#define DPacketCheck( pack )   \
	CRole* pRole = NULL;{	\
	if(!isFilterPacket(pack->packetID)) \
	{   \
	if(pack->totalLen < sizeof(*pack))  \
		{   \
		gxError("Packet is less!{0}", toString());  \
		gxAssert(false);	\
		return GXMISC::HANDLE_RET_OK;   \
		}   \
		gxDebug("Handle {0},IP={1}!", typeid(pack).name(), getRemoteIp());		\
	}   \
	pRole = getRole();    \
	if(NULL == pRole)  \
	{   \
	gxError("Can't find role!{0}", toString());   \
	if(isValid()){    \
	gxError("get Role is failed!!!");  \
	}   \
	return GXMISC::HANDLE_RET_OK;   \
	}}

#define DPacketSetRet(retp, retc) \
{ \
	retp.setRetCode(retc); \
	sendPacket(retp); \
	return GXMISC::HANDLE_RET_OK; \
}

#define DPacketRet(retp, retc) \
{ \
	retp* retPacket = new retp();	\
	retPacket->setRetCode(retc); \
	sendPacket(*retPacket); \
	delete retPacket;	\
	return GXMISC::HANDLE_RET_OK; \
}

#define DPackFailedRet(retp)	\
{	\
	retp* ret = new retp();   \
	ret->setRetCode(RC_FAILED);   \
	sendPacket(*ret);   \
	delete ret;\
	return GXMISC::HANDLE_RET_OK; \
}

void CMapPlayerHandler::Setup()
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	// 心跳
	RegisteHandler(PACKET_CM_PLAYER_HEART_RET, (TPacketHandler)&CMapPlayerHandler::handlePlayerHeart);
	// 本地登陆游戏
	RegisteHandler(PACKET_CM_LOCAL_LOGIN, (TPacketHandler)&CMapPlayerHandler::handleLocalLogin);
	// 通过账号本地登陆游戏
	RegisteHandler(PACKET_CM_LOCAL_LOGIN_ACCOUNT, (TPacketHandler)&CMapPlayerHandler::handleLocalLoginAccount);
	// 进入游戏
	RegisteHandler(PACKET_CM_ENTER_GAME, (TPacketHandler)&CMapPlayerHandler::handleEnterGame);
	// 移动
	RegisteHandler(PACKET_CM_MOVE, (TPacketHandler)&CMapPlayerHandler::handleMove);
	// 跳跃
	RegisteHandler(PACKET_CM_JUMP, (TPacketHandler)&CMapPlayerHandler::handleJump);
	// 降落
	RegisteHandler(PACKET_CM_DROP, (TPacketHandler)&CMapPlayerHandler::handleDrop);
	// 着地
	RegisteHandler(PACKET_CM_LAND, (TPacketHandler)&CMapPlayerHandler::handleLand);
	// 进入场景
	RegisteHandler(PACKET_CM_ENTER_SCENE, (TPacketHandler)&CMapPlayerHandler::handleEnterScene);
	/// 传送点传送
	RegisteHandler(PACKET_CM_TRANSMITE, (TPacketHandler)&CMapPlayerHandler::handleTransmite);
	// 聊天
	RegisteHandler(PACKET_CM_CHAT, (TPacketHandler)&CMapPlayerHandler::handleChat);
	// 重命名
	RegisteHandler(PACKET_CM_RENAME_ROLE_NAME, (TPacketHandler)&CMapPlayerHandler::handleRename);
	// 随机名字
	RegisteHandler(PACKET_CM_RAND_ROLE_NAME, (TPacketHandler)&CMapPlayerHandler::handleRandRoleName);
	// 任务
	RegisteHandler(PACKET_CM_MISSION_OPERATION, (TPacketHandler)&CMapPlayerHandler::handleMissionOperate);
	// 兑换礼包		
//	RegisteHandler(PACKET_CM_EXCHANGE_GIFT_REQ, (TPacketHandler)&CMapPlayerHandler::handleExchangeGiftReq);
	
	// 插入过滤协议
	insertFilterPacket(PACKET_CM_MOVE);
	insertFilterPacket(PACKET_CM_CHAT);
	insertFilterPacket(PACKET_CM_GM_COMMAND);
	insertFilterPacket(PACKET_CM_RENAME_ROLE_NAME);
	insertFilterPacket(PACKET_CM_EXCHANGE_GIFT_REQ);
	//insertFilterPacket(PACKET_CM_REGISTER);
	insertFilterPacket(PACKET_CM_LOCAL_LOGIN_ACCOUNT);

	FUNC_END(DRET_NULL);
}

void CMapPlayerHandler::Unsetup()
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	FUNC_END(DRET_NULL);
}

bool CMapPlayerHandler::initScriptObject(GXMISC::CLuaVM* scriptEngine)
{
	return initScript(scriptEngine, this);
}

CRole* CMapPlayerHandler::getRole(EManagerQueType queType)
{
	return dynamic_cast<CRole*>(CMapPlayerHandlerBase::getRole(queType));
}

bool CMapPlayerHandler::enterBefore( CRole* pRole )
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	// 登陆队列
	if(pRole->isReady())
	{
		return true;
	}

	// 登出队列
	if(pRole->isLogout())
	{
		gxError("Role is in logout queue!Role={0}", pRole->toRoleString());
		return false;
	}

	// 不能在同一Socket上重新登陆两次
	if(pRole->getSocketIndex() == getSocketIndex())
	{
		gxError("Role retry enter game in same socket!Role={0}", pRole->toRoleString());
		return false;
	}

	// 通知玩家账号已经在其他地方登陆了
	pRole->sendKickMsg(KICK_TYPE_BY_OTHER);

	// 登陆准备
	if(pRole->getScene() != NULL)
	{
		pRole->setLoadWaitInfo(LOAD_ROLE_TYPE_LOGIN, pRole->getSceneID(), pRole->getAxisPos(), true);
		pRole->leaveScene(false);
	}
	if(pRole->isFight())
	{
		gxInfo("Role is fight!{0},{1}", pRole->toRoleString(), pRole->toString());
	}
	if(pRole->getSocketIndex() != getSocketIndex())
	{
		// 不是同一连接，直接把连接关掉
		CMapPlayerHandler* pPlayerHandler = pRole->getPlayerHandler(true);
		if(NULL != pPlayerHandler)
		{
			pPlayerHandler->kick(0);
		}
	}
	
	// 如果玩家不在登陆队列中，需要将玩家放置在登陆队列中
	pRole->addRoleToLogout();
	pRole->addRoleToReady();

	return true;

	FUNC_END(false);
}

void CMapPlayerHandler::enterAfter( CRole* pRole )
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	// 发送玩家所有数据
	pRole->sendAllData();
	pRole->getSceneRecord()->cleanUp();

	FUNC_END(DRET_NULL);
}

GXMISC::EHandleRet CMapPlayerHandler::handleLocalLogin(CMLocalLoginGame* packet)
{
	DPacketCheckHeader(packet, MCLocalLoginGameRet, RC_LOGIN_FAILED);

	TLoadRoleData loadData;
	TChangeLineTempData tempData;

	loadData.roleUID = packet->roleUID;
	loadData.accountID = packet->roleUID;
	loadData.objUID = (TObjUID_t)(packet->roleUID + TEMP_ROLE_INIT_UID);
	loadData.loadType = LOAD_ROLE_TYPE_LOGIN;
	loadData.sceneID = 0;
	loadData.needOpenMap = false;
	loadData.mapID = 10001;
	loadData.pos.x = 300;
	loadData.pos.y = 500;

	EGameRetCode retCode = DRoleManager.loadRoleData(&loadData, getSocketIndex(), getSocketIndex(), &tempData, true);
	if (!IsSuccess(retCode))
	{
// 		MCLocalLoginGameAccountRet retPacket;
// 		retPacket.setRetCode(retCode);
// 		retPacket.initData();
// 		retPacket.gameServerIp = "127.0.0.1";
// 		retPacket.port = 7110;
// 		retPacket.systemAccount = 0;
// 		retPacket.newSdkAccount = 0;
// 
// 		sendPacket(retPacket);
	}

	return GXMISC::HANDLE_RET_OK;
}

#include "map_server.h"

GXMISC::EHandleRet CMapPlayerHandler::handleLocalLoginAccount(CMLocalLoginGameAccount* packet)
{
	DPacketCheckHeader(packet, MCLocalLoginGameAccountRet, RC_LOGIN_FAILED);
	
	if(!CMapServer::GetPtr()->getScriptObject()->bCall("validateGameAccountLogin", packet->accountName.toString(), packet->password.toString())){
		gxError("Account cant pass validate!!!Account={0}", packet->accountName.toString());
		MCLocalLoginGameAccountRet localLoginRet;
 		localLoginRet.setRetCode(RC_LOGIN_ACCOUNT_PWD_INVALID);
 		sendPacket(localLoginRet);
		return GXMISC::HANDLE_RET_OK;
	}

	TLoadRoleData loadData;
	TChangeLineTempData tempData;

	std::string accountString = ToMD5String(packet->accountName.toString());
	TRoleUID_t roleUID = GXMISC::StrCRC32(accountString.c_str());

	loadData.roleUID = roleUID;
	loadData.accountID = roleUID;
	loadData.objUID = GXMISC::StrCRC32(accountString.c_str());
	loadData.loadType = LOAD_ROLE_TYPE_LOGIN;
	loadData.sceneID = 0;
	loadData.needOpenMap = false;
	loadData.mapID = 10001;
	loadData.pos.x = 300;
	loadData.pos.y = 500;
	_roleUID = roleUID;
	EGameRetCode retCode = DRoleManager.loadRoleData(&loadData, getSocketIndex(), getSocketIndex(), &tempData, true);
	if (!IsSuccess(retCode))
	{
 		MCLocalLoginGameAccountRet localLoginRet;
 		localLoginRet.setRetCode(retCode);
 		sendPacket(localLoginRet);
	}

	return GXMISC::HANDLE_RET_OK;
}

// 注册
/*
GXMISC::EHandleRet CMapPlayerHandler::handleRegister(CMGameRegister* packet)
{
	DPacketCheckHeader(packet, MCGameRegisterRet, RC_LOGIN_FAILED);

	DMapServerData.getDbHandler(true)->sendPlayerRegiste(packet->accountName.toString(), packet->password.toString(), getSocketIndex());

	return GXMISC::HANDLE_RET_OK;
}
*/

GXMISC::EHandleRet CMapPlayerHandler::handleEnterGame( CMEnterGame* packet )
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	CRole* pRole = NULL;
	MCEnterGameRet enterGameRet;

	gxInfo("Role enter game!RoleUID={0}", packet->roleUID);

	enterGameRet.setRetCode(RC_ENTER_GAME_FAILED);

	if(packet->roleUID != 0)
	{
		setRoleUID(packet->roleUID);
	}
	else
	{
		packet->roleUID = _roleUID;
	}
	pRole = getRole(MGR_QUE_TYPE_INVALID);
	if(NULL == pRole)
	{
		// 角色无法找到，直接退出
		gxError("Can't find role! {0}", toString());
		MCKickRole kickRole;
		kickRole.type = KICK_TYPE_ERR;
		sendPacket(kickRole);
		kick(3);
		return GXMISC::HANDLE_RET_OK;
	}

	if(!enterBefore(pRole))
	{
		pRole->sendKickMsg(KICK_TYPE_ERR);

		kick(3);
		return GXMISC::HANDLE_RET_OK;
	}

	pRole->setSocketIndex(getSocketIndex());
	pRole->setIPAddress(getRemoteIp());

	setRoleInfo(pRole->getAccountID(), pRole->getRoleUID(), pRole->getObjUID());
	if(NULL == DRoleManager.removeFromReady(packet->roleUID))
	{
		// 无法从登陆队列中删除角色
		gxError("Can't remove from read queue!{0}", pRole->toRoleString());
		
		pRole->sendKickMsg(KICK_TYPE_ERR);
		pRole->directKick(false, true, true);
		gxAssert(false);
		return GXMISC::HANDLE_RET_OK;
	}

	DRoleManager.addToEnter(pRole);
	gxInfo("Enter game success!{0}", pRole->toRoleString());
	
	pRole->getRoleDetailData(&enterGameRet.detailData);
	enterGameRet.setRetCode(RC_SUCCESS);
	sendPacket(enterGameRet);

	enterAfter(pRole);

	//通知世界服务
	CMWLimitInfoReq limitInfoReq;
	limitInfoReq.limitAccountID = pRole->getAccountID();
	limitInfoReq.limitRoleID    = pRole->getRoleUID();
	SendToWorld( limitInfoReq );

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CMapPlayerHandler::handleEnterScene( CMEnterScene* packet )
{
	FUNC_BEGIN(SCENE_MOD);

	DPacketCheckAndRet(packet, MCEnterSceneRet);
	if(pRole->getScene() != NULL)
	{
		pRole->sendKickMsg(KICK_TYPE_ERR);

		gxError("Can't enter scene, role has enter scene! CurrentSceneID={0}, DestSceneID={1}, {2}",
			pRole->getSceneID(), pRole->getLoadWaitData()->destSceneID, pRole->toString());
		pRole->kick(true, 3, "Can't enter scene!");
		return GXMISC::HANDLE_RET_OK;
	}

	MCEnterSceneRet enterSceneRet;
	enterSceneRet.setRetCode(RC_SUCCESS);

	if(pRole->isFight())
	{
		pRole->sendKickMsg(KICK_TYPE_ERR);

		gxError("Can't enter scene, role has in fight!{0}", pRole->toString());
		pRole->kick(true, 3, "Can't enter scene!");
		enterSceneRet.setRetCode(RC_FIGHT_HAS_START);
		sendPacket(enterSceneRet);
		return GXMISC::HANDLE_RET_OK;
	}

	// 登陆, 进入场景
	if (!pRole->enterScene(pRole->getLoadWaitData()->destSceneID))
	{
		pRole->sendKickMsg(KICK_TYPE_ERR);

		gxError("Can't enter scene! SceneID={0}, {1}", pRole->getLoadWaitData()->destSceneID, pRole->toString());
		enterSceneRet.setRetCode(RC_MAP_NO_FIND_DEST_MAP);
		sendPacket(enterSceneRet);
		pRole->kick(true, 3, "Can't enter scene!");
		return GXMISC::HANDLE_RET_OK;
	}

	// 角色初始化成功
	gxInfo("Client enter scene success! {0}", pRole->toString());
	pRole->initClient();
	pRole->getLoadWaitData()->cleanUp();
	pRole->getScenData(&enterSceneRet.npcs, &enterSceneRet.trans);
	enterSceneRet.mapID = pRole->getMapID();
	enterSceneRet.pos = *pRole->getAxisPos();
	sendPacket(enterSceneRet);

	// 进入场景事件
	call("onRoleEnterScene", 0, pRole, pRole->getScriptHandler()->getScriptObject());

	pRole->updateBlock();
	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CMapPlayerHandler::handleTransmite( CMTransmite* packet )
{
	FUNC_BEGIN(SCENE_MOD);

	DPacketCheckAndRet(packet, MCTransmiteRet);

	MCTransmiteRet returnPacket;
	returnPacket.setRetCode(pRole->transport(packet->transportTypeID));
	sendPacket(returnPacket);

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CMapPlayerHandler::handleMove( CMMove* packet )
{
	FUNC_BEGIN(SCENE_MOD);

	DPacketCheck(packet);

	if(pRole->isDie())
	{
		pRole->resetPos(pRole->getAxisPos(), RESET_POS_TYPE_WINK, false, false);
		return GXMISC::HANDLE_RET_OK;
	}

	for ( uint32 i=0; i<packet->posList.size(); ++i )
	{
		TAxisPos& pos = packet->posList[i];
		if ( pos.x < 0 || pos.y < 0 )
		{
			return GXMISC::HANDLE_RET_OK;
		}
	}

	MCMoveRet retPacket;
	if ( packet->posList.empty() )
	{
		retPacket.setRetCode(RC_FAILED);
	}
	else
	{
		retPacket.setRetCode(RC_SUCCESS);
	}

	if( IsSuccess(retPacket.getRetCode()) )
	{
		//pRole->move(&packet->posList);
		pRole->roleMove(&packet->posList, (ERoleMoveType)packet->moveType);
	}

	sendPacket(retPacket);

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CMapPlayerHandler::handleJump(CMJump* packet)
{
	FUNC_BEGIN(SCENE_MOD);

	DPacketCheck(packet);

	if (pRole->getScene() != NULL)
	{
		MCJumpRet jumpBroad;
		jumpBroad.objUID = pRole->getObjUID();
		jumpBroad.x = packet->x;
		jumpBroad.y = packet->y;
		pRole->getScene()->broadCast(jumpBroad, pRole, false, g_GameConfig.broadcastRange);
	}

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CMapPlayerHandler::handleDrop(CMDrop* packet)
{
	FUNC_BEGIN(SCENE_MOD);

	DPacketCheck(packet);

	if (pRole->getScene() != NULL)
	{
		MCDropRet dropBroad;
		dropBroad.objUID = pRole->getObjUID();
		dropBroad.x = packet->x;
		dropBroad.y = packet->y;

		pRole->getScene()->broadCast(dropBroad, pRole, false, g_GameConfig.broadcastRange);
	}

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CMapPlayerHandler::handleLand(CMLand* packet)
{
	FUNC_BEGIN(SCENE_MOD);

	DPacketCheck(packet);

	if (pRole->getScene() != NULL)
	{
		MCLandRet landBroad;
		landBroad.srcObjUID = pRole->getObjUID();
		landBroad.objUID = packet->objUID;
		landBroad.x = packet->x;
		landBroad.y = packet->y;

		pRole->setAxisPos(&TAxisPos(packet->x, packet->y));

		pRole->getScene()->broadCast(landBroad, pRole, false, g_GameConfig.broadcastRange);
	}

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}
GXMISC::EHandleRet CMapPlayerHandler::handleChat(CMChat* packet)
{
	FUNC_BEGIN(CHAT_MOD);

 	DPacketCheckAndRet(packet, MCChatBroad);

	if( packet == NULL )
	{
		gxError("packetPtr = NULL");
		return GXMISC::HANDLE_RET_FAILED;
	}

	// 消息处理前
	if(packet->msg.size() > 3){
		// 检测是否为gm命令
		if(tolower(packet->msg[0]) == 'g' && tolower(packet->msg[1]) == 'm'){
			packet->channelType = CHAT_CHANNEL_GM;
		}
	}

	if (packet->channelType == CHAT_CHANNEL_GM)
	{
		pRole->getChatMod()->chatGm(packet);
	}
	else if( packet->channelType == CHAT_CHANNEL_WORLD)
	{		
		pRole->getChatMod()->chatWorld(packet);
	}
	else if(packet->channelType == CHAT_CHANNEL_FACTION )
	{
		pRole->getChatMod()->chatFaction(packet);
	}
	else if(packet->channelType == CHAT_CHANNEL_PRIVATE)
	{
		pRole->getChatMod()->chatFriend(packet);
	}
	
	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CMapPlayerHandler::handleMissionOperate( CMMissionOperate* packet )
{
	FUNC_BEGIN(MISSION_MOD);

	DPacketCheckAndRet(packet, MCMissionOperateRet);

	MCMissionOperateRet missionOperateRet;
	missionOperateRet.operateType = packet->operateType;
	missionOperateRet.missionID = packet->missionID;
	switch(packet->operateType)
	{
	case MISSION_OPERATION_ACCEPT:
		{
			missionOperateRet.setRetCode(pRole->getMissionMod()->acceptMission(packet->missionID));
		}break;
	case MISSION_OPERATION_SUBMIT:
		{
			missionOperateRet.setRetCode(pRole->getMissionMod()->submitMission(packet->missionID));
		}break;
	default:
		{
			gxAssert(false);
		}
	}
	sendPacket(missionOperateRet);

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CMapPlayerHandler::handleRename( CMRenameRoleName* packet )
{
	FUNC_BEGIN(ROLE_MOD);

	DPacketCheck(packet);

	MCRenameRoleNameRet renameRoleNameRet;
	renameRoleNameRet.roleName = packet->roleName;
	renameRoleNameRet.setRetCode(RC_SUCCESS);

	
	if(packet->roleName.empty())
	{
		renameRoleNameRet.setRetCode(RC_LOGIN_ROLE_NAME_INVALID);
		sendPacket(renameRoleNameRet);
		return GXMISC::HANDLE_RET_OK;
	}
	
	pRole->renameName(packet->roleName.toString());

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CMapPlayerHandler::handleRandRoleName( CMRandRoleName* packet )
{
	FUNC_BEGIN(ROLE_MOD);

	DPacketCheck(packet);

	std::string roleName = pRole->randName();
	if(!roleName.empty())
	{
		MCRandRoleNameRet returnPacket;
		returnPacket.roleName = roleName;
		sendPacket(returnPacket);
	}

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

// GXMISC::EHandleRet CMapPlayerHandler::handleExchangeGiftReq( const CMExchangeGiftReq* packet )
// {
// 	FUNC_BEGIN(ROLE_MOD);
// 	DPacketCheckAndRet(packet, MCExchangeGiftRet); 	
// 
// 	MCExchangeGiftRet retPacket;
// 
// 	sint32 retValue = DScriptEngine.call("checkExchangeGiftId", 0, (packet->id).toString() );	
// 	if (pRole->getBagMod()->isFullBagGuird(BAGCONTAINTER_TYPE) != RC_SUCCESS)
// 	{
// 		retValue = RC_BAG_IS_FULL;
// 	}
// 
// 	if( retValue != RC_SUCCESS )
// 	{
// 		retPacket.setRetCode(retValue);
// 		gxError("retCode={0}", sint32(retValue) );
// 		sendPacket(retPacket);
// 		return GXMISC::HANDLE_RET_OK;
// 	}
// 
// 	MWExchangeGiftReq reqPacket;
// 	reqPacket.roleUID = pRole->getRoleUID();
// 	reqPacket.objUid  = pRole->getObjUID();
// 	reqPacket.id      = packet->id;
// 	SendToWorld(reqPacket);
// 
// 	return GXMISC::HANDLE_RET_OK;
// 
// 	FUNC_END(GXMISC::HANDLE_RET_FAILED);
// }

bool CMapPlayerHandler::start()
{
	if (!TBaseType::start())
	{
		return false;
	}

	return true;
}
