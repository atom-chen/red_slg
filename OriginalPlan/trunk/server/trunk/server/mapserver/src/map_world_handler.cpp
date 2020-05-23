#include "core/game_exception.h"

#include "role.h"
#include "role_manager.h"
#include "map_world_handler.h"
#include "module_def.h"
#include "map_db_player_handler.h"
#include "map_server_util.h"
#include "db_name_define.h"
#include "map_db_server_handler.h"
#include "dhm_tbl.h"
#include "map_server_instance.h"
#include "map_server.h"
#include "packet_cm_bag.h"

void CMapWorldServerHandler::Setup()
{
	FUNC_BEGIN(MAP_WORLD_SERVER_HANDLER_MOD);

	RegisteHandler(PACKET_WM_REGISTE_RET, (TPacketHandler)&CMapWorldServerHandler::handleRegisteToWorldRet);
	RegisteHandler(PACKET_WM_LOAD_ROLE_DATA, (TPacketHandler)&CMapWorldServerHandler::handleLoadRoleData);
	RegisteHandler(PACKET_WM_UNLOAD_ROLE_DATA, (TPacketHandler)&CMapWorldServerHandler::handleUnloadRoleData);
	RegisteHandler(PACKET_WM_TRANS_ERROR, (TPacketHandler)&CMapWorldServerHandler::handleTransError);
	RegisteHandler(PACKET_MW_BROAD, (TPacketHandler)&CMapWorldServerHandler::handleBroadCast);
	RegisteHandler(PACKET_MW_TRANS, (TPacketHandler)&CMapWorldServerHandler::handleTrans);
	RegisteHandler(PACKET_WM_ROLE_HEART_RET, (TPacketHandler)&CMapWorldServerHandler::handleRoleHeartRet);
	RegisteHandler(PACKET_WM_RENAME_ROLE_NAME_RET, (TPacketHandler)&CMapWorldServerHandler::handleRename);
	RegisteHandler(PACKET_LW_LIMIT_INFO_UPDATE, (TPacketHandler)&CMapWorldServerHandler::handleLimitInfo);
	RegisteHandler(PACKET_WM_USER_UPDATE, (TPacketHandler)&CMapWorldServerHandler::handleUpdateUserata);
	RegisteHandler(PACKET_WM_SERVER_INFO, (TPacketHandler)&CMapWorldServerHandler::handleServerInfo);
	RegisteHandler(PACKET_WM_RECHARGE, (TPacketHandler)&CMapWorldServerHandler::handleRecharge);
//	RegisteHandler(PACKET_WM_EXCHANGE_GIFT_RET, (TPacketHandler)&CMapWorldServerHandler::handleExchangeGiftRet);
	RegisteHandler(PACKET_WM_LIMIT_ACCOUNT_INFO, (TPacketHandler)&CMapWorldServerHandler::handleLimitAccountInfo);
	RegisteHandler(PACKET_WM_LIMIT_CHAT_INFO, (TPacketHandler)&CMapWorldServerHandler::handleLimitChatInfo);

	FUNC_END(DRET_NULL);
}

void CMapWorldServerHandler::Unsetup()
{
	FUNC_BEGIN(MAP_WORLD_SERVER_HANDLER_MOD);

	FUNC_END(DRET_NULL);
}

void CMapWorldServerHandler::sendRoleQuit(TAccountID_t accountID, TObjUID_t objUID, TRoleUID_t roleUID, GXMISC::TSocketIndex_t worldSockIndex)
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	MWRoleQuit roleQuit;
	roleQuit.accountID = accountID;
	roleQuit.objUID = objUID;
	roleQuit.roleUID = roleUID;
	roleQuit.socketIndex = worldSockIndex;

	SendToWorld(roleQuit);

	FUNC_END(DRET_NULL);
}

void CMapWorldServerHandler::sendUnloadDataRet(EUnloadRoleType retType, TAccountID_t accountID,
	TRoleUID_t roleUID, GXMISC::TSocketIndex_t worldSockIndex)
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	MWUnloadRoleDataRet unloadRet;
	unloadRet.setRetCode(RC_SUCCESS);
	unloadRet.accountID = accountID;
	unloadRet.roleUID = roleUID;
	unloadRet.unloadType = retType;
	unloadRet.socketIndex = worldSockIndex;

	if(CMapWorldServerHandler::IsActive())
	{
		CMapWorldServerHandler::SendPacket(unloadRet);
	}

	FUNC_END(DRET_NULL);
}

GXMISC::EHandleRet CMapWorldServerHandler::handleLoadRoleData(WMLoadRoleData* packet)
{
	FUNC_BEGIN(LOGIN_MOD);

	gxInfo("World load role data!{0}", packet->toString());

	EGameRetCode retCode = DRoleManager.loadRoleData(&packet->loadData, getSocketIndex(), packet->socketIndex, &packet->changeLineTempData, false);
	if (!IsSuccess(retCode))
	{
		MWLoadRoleDataRet retPacket;
		retPacket.loadData = packet->loadData;
		retPacket.socketIndex = packet->socketIndex;
		retPacket.setRetCode(retCode);

		sendPacket(retPacket);
	}

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_OK);
}

// 保存角色数据到数据库再下线
GXMISC::EHandleRet CMapWorldServerHandler::handleUnloadRoleData( WMUnloadRoleData* packet )
{  
	if(packet->unloadType != UNLOAD_ROLE_TYPE_SYS_CHECK)
	{
		gxInfo("World unload role data!{0},UnloadType={1}", packet->toString(),(sint32)packet->unloadType);
	}

	MWUnloadRoleDataRet unloadRet;
	unloadRet.accountID = packet->accountID;
	unloadRet.roleUID = packet->roleUID;
	unloadRet.socketIndex = packet->socketIndex;
	unloadRet.unloadType = packet->unloadType;
	unloadRet.setRetCode(DRoleManager.unLoadRoleData(packet->roleUID, packet->socketIndex, packet->needRet, packet->unloadType));

	sendPacket(unloadRet);

	return GXMISC::HANDLE_RET_OK;
}

GXMISC::EHandleRet CMapWorldServerHandler::handleLimitInfo( CLWLimitInfoUpdate* packet )
{
	FUNC_BEGIN(LOGIN_MOD);

	for(sint32 i = 0; i < packet->accountID.size(); ++i)
	{
		CRole* pRole = DRoleManager.findByAccountID(packet->accountID[i]);
		if(NULL != pRole)
		{
			pRole->getLimitManager()->updateLimitRole(packet->limitType, packet->limitKey, packet->limitVal, packet->limitTime);
		}
	}

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CMapWorldServerHandler::handleUpdateUserata( WMUpdateUserData* packet )
{
	FUNC_BEGIN(LOGIN_MOD);

	CRole* pRole = DRoleManager.findByObjUID(packet->objUID);
	if(NULL != pRole)
	{
		pRole->updateUserData(&packet->userData);
	}

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CMapWorldServerHandler::handleRecharge( WMRecharge* packet )
{
	FUNC_BEGIN(BILL_MOD);

	MWRechargeRet rechargeRet;
	rechargeRet.setRetCode(RC_RECHARGE_ROLE_UNEXIST);
	rechargeRet.serialNo = packet->serialNo;
	rechargeRet.accountID = packet->accountID;
	rechargeRet.roleUID = packet->roleUID;
	rechargeRet.bindRmb = packet->bindRmb;
	rechargeRet.rmb = packet->rmb;

	CRole* pRole = DRoleManager.findByRoleUID(packet->roleUID);
	if(NULL == pRole)
	{
		rechargeRet.setRetCode(RC_RECHARGE_ROLE_UNEXIST);	
		gxError("Recharge failed, can't find role!RoleUID={0},Rmb={1},BindRmb={2},SerialNo={3}",
			packet->roleUID, packet->rmb, packet->bindRmb, packet->serialNo.toString());
	}
	else if(pRole->isChangeLine())
	{
		rechargeRet.setRetCode(RC_RECHARGE_HAS_CHANGE_LINE);
		gxError("Recharge failed, role is changeline!{0},Rmb={1},BindRmb={2},SerialNo={3}",
			pRole->toString(), packet->rmb, packet->bindRmb, packet->serialNo.toString());
	}
	else if(pRole->isLogout() || pRole->isReady())
	{
		rechargeRet.setRetCode(RC_RECHARGE_ROLE_NOT_ENTER);
		gxError("Recharge failed, role not in enter!{0},Rmb={1},BindRmb={2},SerialNo={3}", 
			pRole->toString(), packet->rmb, packet->bindRmb, packet->serialNo.toString());
	}
	else
	{
		// 充值成功
		if(pRole->getHumanBaseData()->getTotalChargeRmb() <= 0)
		{
			// 首充值
			rechargeRet.isFirstCharge = true;
		}
		else
		{
			rechargeRet.isFirstCharge = false;
		}

		pRole->chargeRmb(packet->rmb);
		pRole->addBindRmb(packet->bindRmb);

		rechargeRet.setRetCode(RC_SUCCESS);

		// 添加日志记录
		gxInfo("Recharge success!{0},Rmb={1},BindRmb={2},SerialNo={3}",
			pRole->toString(), packet->rmb, packet->bindRmb, packet->serialNo.toString());
	}

	sendPacket(rechargeRet);

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_OK);
}

// GXMISC::EHandleRet CMapWorldServerHandler::handleExchangeGiftRet( WMExchangeGiftRet* packet )
// {
// 	CRole* pRole = DRoleManager.findByRoleUID(packet->roleUID);
// 	if(NULL == pRole)
// 	{
// 		gxError("invalid roleUID roleUId={0}", packet->roleUID);
// 	}
// 	else
// 	{
// 		MCExchangeGiftRet giftRet;
// 		giftRet.setRetCode(packet->getRetCode());
// 		giftRet.itemId  = packet->itemId;
// 		if( packet->getRetCode() == RC_SUCCESS )
// 		{
// 			CDhmTbl *dhmPtr = DDhmTblMgr.find( packet->itemId );
// 			if( dhmPtr!=NULL )
// 			{
// 				//增加奖励
// 				TItemReward iteminfo;
// 				iteminfo.itemMarkNum       = dhmPtr->giftId;
// 				iteminfo.itemNum           = 1;	
// 				EGameRetCode ret=pRole->handleAddTokenOrItem(&iteminfo, TEM_RECORD_EXCHANGE_GIFT);	
// 				if( ret == RC_SUCCESS )
// 				{
// 					gxInfo("roleId={0} add giftId={1} by exchangeGift", packet->roleUID, dhmPtr->giftId );
// 				}
// 				else
// 				{
// 					giftRet.setRetCode(RC_BAG_IS_FULL);
// 					gxError("exchange gift failed !!! roleId={0} itemId={1}", packet->roleUID, packet->itemId );
// 				}
// 			}
// 			else
// 			{
// 				giftRet.setRetCode(RC_BAG_IS_FULL);
// 				gxError("exchange gift failed !!! roleId={0} itemId={1}", packet->roleUID, packet->itemId );
// 			}
// 			
// 		}
// 
// 		pRole->sendPacket( giftRet );
// 	}
// 	
// 	return GXMISC::HANDLE_RET_OK;
// }

GXMISC::EHandleRet CMapWorldServerHandler::handleLimitAccountInfo( CWMLimitAccountInfo* packet )
{
	CRole* pRole = DRoleManager.findByRoleUID(packet->limitRoleID);
	if(NULL == pRole)
	{
		gxError("invalid roleUID roleUId={0}", packet->limitRoleID);
	}
	else
	{
		if( DTimeManager.nowSysTime() >= (packet->begintime).getGameTime() && DTimeManager.nowSysTime()<=(packet->endtime).getGameTime() )
		{
			pRole->sendKickMsg(KICK_TYPE_BY_GM);		
			pRole->kick(true, 3, "forbid login game!");
		}
		
	}

	return GXMISC::HANDLE_RET_OK;
}

GXMISC::EHandleRet CMapWorldServerHandler::handleLimitChatInfo( CWMLimitChatInfo* packet )
{
	CRole* pRole = DRoleManager.findByRoleUID(packet->limitRoleID);
	if(NULL == pRole)
	{
		gxError("invalid roleUID roleUId={0}", packet->limitRoleID);
	}
	else
	{		
		pRole->addLimitChatInfo( packet->limitAccountID, packet->limitRoleID, packet->begintime, packet->endtime, packet->uniqueId );

	}

	return GXMISC::HANDLE_RET_OK;
}

ETransCode CMapWorldServerHandler::doBroadCast( CBasePacket* packet, TObjUID_t srcObjUID )
{
	switch(packet->packetID)
	{
	case PACKET_MW_ANNOUNCEMENT:
		{
			MWAnnoucement* announcement = (MWAnnoucement*)packet;
			DMapServer->addManagerBoard(announcement->msg.toString(), announcement->lastTime, announcement->interval);
			return TRANS_CODE_STOP;
		}break;
	}

	return TRANS_CODE_CONTINUE;
}

ETransCode CMapWorldServerHandler::doTrans(CBasePacket* packet, TObjUID_t srcObjUID, TObjUID_t destObjUID)
{
	switch (packet->packetID)
	{
		case PACKET_MM_CHANGE_SCENE:
		{
			MMChangeScene* pChangeScene = (MMChangeScene*)packet;
			CRole* pRole = DRoleManager.findByObjUID(destObjUID);
			if (NULL != pRole)
			{
				// 检测通知者与当前玩家关系

				// 移动到动态场景
				pRole->moveToDynamicMap(pChangeScene->sceneID, &pChangeScene->pos, pChangeScene->serverID);
			}
			return TRANS_CODE_STOP;
		}break;
		default:
			break;
	}

	return TRANS_CODE_CONTINUE;
}
