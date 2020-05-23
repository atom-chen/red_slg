#include "world_charging_server_handler.h"

#include "world_player.h"
#include "world_map_player.h"
#include "world_user.h"
#include "world_map_player_mgr.h"
#include "world_player_mgr.h"
#include "world_user_mgr.h"
#include "game_errno.h"
#include "game_struct.h"
#include "world_server.h"
#include "packet_wb_base.h"
#include "world_sql_manager.h"
#include "charging_rmb.h"
#include "recharge_def.h"
#include "world_server.h"


GXMISC::EHandleRet CWorldChargingServerHandler::handleRecharge( BWRecharge* packet )
{
//	gxInfo("Handle charge get!SerialNo={0}", packet->serialNo.c_str());

	DRECHARGE_LOG(packet->serialNo, DWorldServer->getConfig()->getWorldServerID(), packet->accountID, packet->rmb,
		0, 0, "Handle recharge request");

	CWorldPlayer* pPlayer = DWorldPlayerMgr.findByAccountID(packet->accountID);
	CWorldUser* pUser = DWorldUserMgr.findUserByAccountID(packet->accountID);
	CWorldMapPlayer* pMapserver = NULL;
	if(NULL != pUser)
	{
		pMapserver = pUser->getMapPlayer();
	}
	bool toAccountFlag = false;
	if(NULL != pPlayer)
	{	
		if(pPlayer->isChangeLineStatus() || pPlayer->getChangeLineWait()->openDynaMapFlag == true
			|| pPlayer->getChangeLineWait()->changeLineFlag == true)
		{
			// 正在切线
			//gxError("Role is change line!{0}", packet->toString());

			DRECHARGE_LOG(packet->serialNo, DWorldServer->getConfig()->getWorldServerID(), packet->accountID, packet->rmb,
				0, 0, "Role is change line");

			toAccountFlag = true;
		}
		else if(pPlayer->isRequstStatus())
		{
			// 处理请求
			gxError("Role is in request status!Status={0},{1}",(uint32)pPlayer->getPlayerStatus(), packet->toString());

			DRECHARGE_LOG(packet->serialNo, DWorldServer->getConfig()->getWorldServerID(), packet->accountID, packet->rmb,
				0, 0, "Role is in request status");

			toAccountFlag = true;
		}
		else if(pPlayer->isRechargeStatus())
		{
			// 玩家正在充值
			//gxError("Player is in recharge status!{0}", packet->toString());

			DRECHARGE_LOG(packet->serialNo, DWorldServer->getConfig()->getWorldServerID(), packet->accountID, packet->rmb,
				0, 0, "Player is in recharge status");

			toAccountFlag = true;
		}
	}

	// 插入充值记录
	if(!DSqlConnectionMgr.addTempRechargeRecord(packet->serialNo, packet->accountID, packet->rmb, 0))
	{
		sendRechargeRet(packet, RC_RECHARGE_WORLD_SERVER_DB_ERR);
		//gxError("Can't add temp charge record!{0}", packet->toString().c_str());
		DRECHARGE_LOG(packet->serialNo, DWorldServer->getConfig()->getWorldServerID(), packet->accountID, packet->rmb,
			0, 0, "Can't add temp charge record");
		return GXMISC::HANDLE_RET_OK;
	}

	if(NULL == pPlayer || NULL == pUser || NULL == pMapserver || toAccountFlag || pPlayer->getRoleNum() > 1)
	{
		// 不能直接充值到角色, 保存到账号中去
		EGameRetCode retCode = CBillMod::RechargeToAccount(packet->serialNo, packet->accountID, packet->rmb, 0, pPlayer, pUser);
		sendRechargeRet(packet, retCode);
	}
	else
	{
		// 开始充值加锁
		pPlayer->startRecharge();

		if(!IsSuccess(CBillMod::RechargeToMapServer(packet, pPlayer, pUser)))
		{
			// 不能充值到在线玩家,直接充值到账号, 并通知玩家有充值, 请提取元宝
			EGameRetCode retCode = CBillMod::RechargeToAccount(packet->serialNo, packet->accountID, packet->rmb, 0, pPlayer, pUser);
			sendRechargeRet(packet, retCode);
		}

	//	gxInfo("Start charge rmb to mapserver!{0}", packet->toString());
		DRECHARGE_LOG(packet->serialNo, DWorldServer->getConfig()->getWorldServerID(), packet->accountID, packet->rmb,
			0, 0, "Start charge rmb to map server");
	}

	return GXMISC::HANDLE_RET_OK;
}

void CWorldChargingServerHandler::sendRechargeRet( BWRecharge* packet, EGameRetCode retCode )
{
	WBRechargeRet rechargeRet;
	rechargeRet.serialNo = packet->serialNo;
	rechargeRet.accountID = packet->accountID;
	rechargeRet.rmb = packet->rmb;
	rechargeRet.bindRmb = 0;
	rechargeRet.setRetCode(retCode);
	rechargeRet.onlineFlag = 1;

	sendPacket(rechargeRet);
}

bool CWorldChargingServerHandler::start()
{
	if(WorldChargingServerHandler != NULL)
	{
		gxError("ChargingServer can't connect repeat!");
		return false;
	}

	WorldChargingServerHandler = this;
	sendRegiste();
	return true;
}

void CWorldChargingServerHandler::quit()
{

}

void CWorldChargingServerHandler::close()
{
	WorldChargingServerHandler = NULL;
}

void CWorldChargingServerHandler::breath( GXMISC::TDiffTime_t diff )
{
	TBaseType::breath(diff);
}

void CWorldChargingServerHandler::Setup()
{
	RegisteHandler(PACKET_BW_RECHARGE, (TPacketHandler) &CWorldChargingServerHandler::handleRecharge);
}

void CWorldChargingServerHandler::sendRegiste()
{
	CWBRegiste registePacket;
	registePacket.serverID = DWorldServer->getConfig()->getWorldServerID();
	sendPacket(registePacket);
}

CWorldChargingServerHandler* CWorldChargingServerHandler::WorldChargingServerHandler = NULL;