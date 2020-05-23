#include "core/game_exception.h"

#include "world_script_engine.h"
#include "world_server_data.h"
#include "world_server_config.h"
#include "world_server_util.h"
#include "world_server.h"
#include "world_map_player_mgr.h"
#include "packet_mw_base.h"
#include "world_sql_manager.h"

// 得到世界服务器数据
CWorldServerData* luaGetWorldServerData()
{
	return CWorldServerData::GetPtrInstance();
}

// 得到服务器配置
CWorldServerConfig* luaGetWorldServerConfig()
{
	return DWorldServer->getConfig();
}

// 得到服务器
CWorldServer* luaGetServer()
{
	return DWorldServer;
}

// 后台发送奖励元宝
void luaAwardBindRmb(TRmb_t rmb, TGold_t gameMoney, std::string tempAccountID)
{
	gxInfo("Award bind rmb!Rmb={0}", rmb);

	if(rmb != 0 || gameMoney != 0)
	{
		TAccountID_t accountID = 0;
		TRoleUID_t roleUID = 0;
		GXMISC::gxFromString(tempAccountID, accountID);
		if(tempAccountID.empty())
		{
			DSqlConnectionMgr.addAwardBindRmb(rmb, gameMoney);
		}
		else
		{
			roleUID = DSqlConnectionMgr.getRoleUIDByAccountID(accountID);
			DSqlConnectionMgr.addRoleAwardBindRmb(roleUID, accountID, rmb, gameMoney);
		}

		WMAwardBindRmb bindRmbPacket;
		bindRmbPacket.bindRmb = rmb;
		bindRmbPacket.gameMoney = gameMoney;
		bindRmbPacket.roleUID = roleUID;
		DWorldMapPlayerMgr.broadCast(bindRmbPacket);
	}
}
bool BindFunc(CScriptEngineCommon::TScriptState* pState)
{
	return true;
}