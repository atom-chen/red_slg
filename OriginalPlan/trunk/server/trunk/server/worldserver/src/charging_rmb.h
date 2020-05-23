#ifndef _CHARGING_RMB_H_
#define _CHARGING_RMB_H_

#include "game_util.h"
#include "packet_wb_base.h"

class CWorldPlayer;
class CWorldUser;
class CBillMod
{
public:
	static EGameRetCode RechargeToMapServer(BWRecharge* packet, CWorldPlayer* pPlayer, CWorldUser* pUser);		// 充值到地图服务器
	static EGameRetCode RechargeToAccount(TSerialStr_t serialNo, TAccountID_t accountID, TRmb_t rmb, TRmb_t bindRmb, CWorldPlayer* pPlayer, CWorldUser* pUser);	// 充值到账号

public:
	static void OnChargeRmb(TSerialStr_t serialNo, TAccountID_t accountID, TRoleUID_t roleUID, TRmb_t rmb, TRmb_t bindRmb);
	static void OnFirstChargeRmb(TAccountID_t accountID, TRoleUID_t roleUID, TSerialStr_t serialNo, TRmb_t rmb);
};

#endif	// _CHARGING_RMB_H_