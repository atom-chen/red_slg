#include "core/game_exception.h"

#include "core/time/date_time.h"

#include "module_def.h"
#include "packet_id_def.h"
#include "packet_mw_trans.h"
#include "world_sql_manager.h"
#include "constant_tbl.h"
#include "world_map_player_mgr.h"
#include "world_server_util.h"
#include "world_server.h"
#include "world_player_mgr.h"
#include "world_user.h"
#include "world_user_mgr.h"
#include "world_script_engine.h"
#include "world_server_data.h"
#include "world_map_server_handler.h"

void CWorldMapServerHandler::Setup()
{
	FUNC_BEGIN(WORLD_MAP_SERVER_MOD);

	RegisteHandler(PACKET_MW_REGISTE, (TPacketHandler) &CWorldMapServerHandler::handleMapServreRegiste);
	RegisteHandler(PACKET_MW_LOAD_ROLE_DATA_RET, (TPacketHandler) &CWorldMapServerHandler::handleLoadRoleData);
	RegisteHandler(PACKET_MW_UNLOAD_ROLE_DATA_RET, (TPacketHandler) &CWorldMapServerHandler::handleUnloadRoleData);
	RegisteHandler(PACKET_MW_ROLE_QUIT, (TPacketHandler) &CWorldMapServerHandler::handleRoleQuit);
	RegisteHandler(PACKET_MW_USER_LOGIN, (TPacketHandler) &CWorldMapServerHandler::handleUserLogin);
	RegisteHandler(PACKET_MW_TRANS, (TPacketHandler) &CWorldMapServerHandler::handleTrans);
	RegisteHandler(PACKET_MW_TRANS_TO_WORLD, (TPacketHandler) &CWorldMapServerHandler::handleTrans2World);
	RegisteHandler(PACKET_MW_BROAD, (TPacketHandler) &CWorldMapServerHandler::handleBroadCast);
	RegisteHandler(PACKET_MW_ROLE_KICK, (TPacketHandler)&CWorldMapServerHandler::handleRoleKick);
	RegisteHandler(PACKET_MW_ROLE_HEART, (TPacketHandler)&CWorldMapServerHandler::handleRoleHeart);
	RegisteHandler(PACKET_MW_RENAME_ROLE_NAME, (TPacketHandler)&CWorldMapServerHandler::handleRenameRoleName);
	RegisteHandler(PACKET_MW_RAND_ROLE_NAME, (TPacketHandler)&CWorldMapServerHandler::handleRandRoleName);
	RegisteHandler(PACKET_MW_GET_RAND_NAME_LIST, (TPacketHandler)&CWorldMapServerHandler::handleGetRandNameList);
	RegisteHandler(PACKET_MW_RECHARGE_RET, (TPacketHandler)&CWorldMapServerHandler::handleRechargeRet);
	RegisteHandler(PACKET_MW_EXCHANGE_GIFT_REQ, (TPacketHandler)&CWorldMapServerHandler::handleExchangeGiftReq);
	RegisteHandler(PACKET_MW_LIMIT_INFO_REQ, (TPacketHandler)&CWorldMapServerHandler::handleLimitInfoReq);


	FUNC_END(DRET_NULL);
}

void CWorldMapServerHandler::Unsetup()
{
	FUNC_BEGIN(WORLD_MAP_SERVER_MOD);

	FUNC_END(DRET_NULL);
}

void CWorldMapServerHandler::onMapServerRegiste( TServerID_t mapServer )
{
	FUNC_BEGIN(WORLD_MAP_SERVER_MOD);

	DWorldMapPlayerMgr.updateServerInfo();

	FUNC_END(DRET_NULL);
}

GXMISC::EHandleRet CWorldMapServerHandler::handleExchangeGiftReq( const MWExchangeGiftReq* packet )
{
// 	WMExchangeGiftRet   retPacket;
// 	retPacket.roleUID = packet->roleUID;
// 	retPacket.objUid  = packet->objUid;
// 	retPacket.setRetCode(RC_SUCCESS);
// 	retPacket.itemId  = 0;
// 
// 	TExchangeGiftID_t tmpId = packet->id;
// 
// 	sendPacket( retPacket );	

	return GXMISC::HANDLE_RET_OK;
}

GXMISC::EHandleRet CWorldMapServerHandler::handleLimitInfoReq( const CMWLimitInfoReq* packet )
{
	CWorldPlayer* player = DWorldPlayerMgr.findByAccountID(packet->limitAccountID);
	if (NULL == player) 
	{
		// 无法找到对应的账号
		gxError("Can't find player! accoutId={0}", packet->limitAccountID);
		gxAssert(false);		
		return GXMISC::HANDLE_RET_OK;
	}

	// 获取地图服务器对象
	CWorldMapPlayer* mapPlayer = getWorldMapPlayer();
	if (NULL == mapPlayer) {
		gxAssert(false);
		gxError("WorldMapPlayer is NULL! ");		
		return GXMISC::HANDLE_RET_OK;
	}

	// 加载角色数据
	gxAssert(packet->limitAccountID == player->getAccountID());
	gxAssert(packet->limitRoleID == player->getCurrentRoleUID());

	player->transLimitInfo();
	
	return GXMISC::HANDLE_RET_OK;
}