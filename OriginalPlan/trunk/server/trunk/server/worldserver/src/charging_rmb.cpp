#include "charging_rmb.h"
#include "world_player.h"
#include "world_user.h"
#include "world_player_mgr.h"
#include "world_sql_manager.h"
#include "world_server.h"
#include "recharge_def.h"

EGameRetCode CBillMod::RechargeToMapServer(BWRecharge* packet, CWorldPlayer* pPlayer, CWorldUser* pUser)
{
	// 通知地图服务器有充值
	WMRecharge recharge;
	recharge.serialNo = packet->serialNo;
	recharge.roleUID = pPlayer->getCurrentRoleUID();
	recharge.accountID = pPlayer->getAccountID();
	recharge.rmb = packet->rmb;
	if(!pUser->sendPacket(recharge))
	{
		return RC_LOGIN_NO_MAP_SERVER;
	}

	if(!DSqlConnectionMgr.updateTempRechargeRecord(packet->serialNo, 2))	// 更新状态为开始充值
	{
		gxError("Cant update charge record!AccountID={0},Rmb={1},SerialNo={2}",
			packet->accountID, packet->rmb, packet->serialNo.c_str());
	}

	return RC_SUCCESS;
}

EGameRetCode CBillMod::RechargeToAccount(TSerialStr_t serialNo, TAccountID_t accountID, TRmb_t rmb, TRmb_t bindRmb, CWorldPlayer* pPlayer, CWorldUser* pUser)
{
	TRoleUID_t roleUID = DSqlConnectionMgr.getLastLoginRoleUIDByAccountID(accountID);
	if(pUser != NULL)
	{
		roleUID = pUser->getRoleUID();
	}
	if(!DSqlConnectionMgr.addAccountRmb(accountID, rmb, bindRmb))
	{
// 		gxError("Player not online, cant save recharge rmb!AccountID={0},Rmb={1},SerialNo={2}",
// 			accountID, rmb, serialNo.c_str());

		DRECHARGE_LOG(serialNo, DWorldServer->getConfig()->getWorldServerID(), accountID, rmb,
			0, 0, "Cant save recharge rmb");

		if(!DSqlConnectionMgr.updateTempRechargeRecord(serialNo, 1))	// 更新状态为失败
		{
// 			gxError("Can't update charge record!AccountID={0},Rmb={1},SerialNo={2}",
// 				accountID, rmb, serialNo.c_str());
			DRECHARGE_LOG(serialNo, DWorldServer->getConfig()->getWorldServerID(), accountID, rmb,
				0, 0, "Can't update charge record");
		}

		return RC_RECHARGE_WORLD_SERVER_DB_ERR;
	}
	else
	{
		OnChargeRmb(serialNo, accountID, INVALID_ROLE_UID, rmb, bindRmb);
// 		gxInfo("Recharge to account success!AccountID={0},Rmb={1},SerialNo={2}",
// 			accountID, rmb, serialNo.c_str());

		DRECHARGE_LOG(serialNo, DWorldServer->getConfig()->getWorldServerID(), accountID, rmb,
			0, 0, "Recharge to account success");

		if(!DSqlConnectionMgr.updateTempRechargeRecord(serialNo, 3))	// 更新状态为成功
		{
// 			gxError("Can't update charge record!AccountID={0},Rmb={1},SerialNo={2}",
// 				accountID, rmb, serialNo.c_str());

			DRECHARGE_LOG(serialNo, DWorldServer->getConfig()->getWorldServerID(), accountID, rmb,
				0, 0, "Can't update charge record");
		}

		return RC_SUCCESS;
	}

	// 充值解锁
	if(NULL != pPlayer)
	{
		pPlayer->closeRecharge();
	}

	return RC_SUCCESS;
}

void CBillMod::OnChargeRmb( TSerialStr_t serialNo, TAccountID_t accountID, TRoleUID_t roleUID, TRmb_t rmb, TRmb_t bindRmb )
{

}

void CBillMod::OnFirstChargeRmb( TAccountID_t accountID, TRoleUID_t roleUID, TSerialStr_t serialNo, TRmb_t rmb )
{

}