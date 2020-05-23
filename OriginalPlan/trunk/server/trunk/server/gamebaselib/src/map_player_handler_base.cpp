#include "map_player_handler_base.h"
#include "module_def.h"
#include "game_exception.h"
#include "game_config.h"
#include "packet_mw_base.h"
#include "map_world_handler_base.h"
#include "role_base.h"
#include "role_manager_base.h"
#include "map_server_instance_base.h"

CMapPlayerHandlerBase::CMapPlayerHandlerBase() : CGameExtendSocketHandler<CMapPlayerHandlerBase>(),
	_roleUID(INVALID_ROLE_UID), _accountID(INVALID_ACCOUNT_ID), _objUID(INVALID_OBJ_UID)
{
	//setMaxDataCacheLen(g_GameConfig.maxMapPlayerDataLenght);
	initData();
}

void CMapPlayerHandlerBase::setWorldPlayerSockIndex( GXMISC::TSocketIndex_t index )
{
	_worldPlayerSockIndex = index;
}

GXMISC::TSocketIndex_t CMapPlayerHandlerBase::getWorldPlayerSockIndex()
{
	return _worldPlayerSockIndex;
}

bool CMapPlayerHandlerBase::start()
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	if (!TBaseType::start())
	{
		return false;
	}

	gxDebug("Client connect!IP={0},Port={1}, RemoteIP={2},RemotePort={3}", getLocalIp(), getLocalPort(), getRemoteIp(), getRemotePort());
	_lastHeartTime = (uint32)DTimeManager.nowSysTime();
	setIgnore();
	return true;

	FUNC_END(false);
}

void CMapPlayerHandlerBase::close()
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	TBaseType::close();

	gxError("Client socket close! {0}", toString());
	doCloseWaitReconnect();
	clean();

	FUNC_END(DRET_NULL);
}

void CMapPlayerHandlerBase::breath( GXMISC::TDiffTime_t diff )
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	TBaseType::breath(diff);

	doPlayerHeart();
	checkPlayerHeart();

	FUNC_END(DRET_NULL);
}

void CMapPlayerHandlerBase::quit( sint32 sockWaitTime )
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	clean();
	kick(sockWaitTime);

	FUNC_END(DRET_NULL);
}

void CMapPlayerHandlerBase::clean()
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	flush();
	_roleUID = INVALID_ROLE_UID;
	_accountID = INVALID_ACCOUNT_ID;
	_objUID = INVALID_OBJ_UID;

	FUNC_END(DRET_NULL);
}

bool CMapPlayerHandlerBase::onBeforeHandlePacket( CBasePacket* packet )
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	CRoleBase* pRole = getRole();
	bool checkPacket = TBaseType::onBeforeHandlePacket(packet);
	if ( !checkPacket )
	{
		if ( pRole != NULL )
		{
			pRole->quitGame();
		}
		return false;
	}
	if(NULL == pRole)
	{
		return true;
	}
//	pRole->pushMsgID(packet->packetID); @TODO 查看最后一段时间的协议处理

	return true;

	FUNC_END(false);
}

void CMapPlayerHandlerBase::setRoleInfo( TAccountID_t accountID, TRoleUID_t roleUID, TObjUID_t objUID )
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	setAccountID(accountID);
	setObjUID(objUID);
	setRoleUID(roleUID);

	FUNC_END(DRET_NULL);
}

bool CMapPlayerHandlerBase::isNeedFreeWorldRole()
{
	return getRoleUID() != INVALID_ROLE_UID || getAccountID() != INVALID_ACCOUNT_ID || getObjUID() != INVALID_OBJ_UID;
}

bool CMapPlayerHandlerBase::isFilterPacket( TPacketID_t id )
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	return CMapPlayerHandlerBase::FilterPackets.find(id) != FilterPackets.end();

	FUNC_END(false);
}

void CMapPlayerHandlerBase::insertFilterPacket(TPacketID_t id )
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	CMapPlayerHandlerBase::FilterPackets.insert(id);

	FUNC_END(DRET_NULL);
}

void CMapPlayerHandlerBase::send( const void* msg, uint32 len )
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	TBaseType::send(msg,len);

	FUNC_END(DRET_NULL);
}

CRoleBase* CMapPlayerHandlerBase::getRole( EManagerQueType queType )
{
	if(queType == MGR_QUE_TYPE_INVALID)
	{
		return DRoleMgrBase->findByRoleUID(getRoleUID());
	}
	else
	{
		return DRoleMgrBase->findInQueTypeByRoleUID(queType, getRoleUID());
	}
}

GXMISC::EHandleRet CMapPlayerHandlerBase::handlePlayerHeart( MCPlayerHeart* packet )
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	setLastHeartTime(DTimeManager.nowSysTime());

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

void CMapPlayerHandlerBase::doCloseWaitReconnect()
{
	FUNC_BEGIN(MAP_PLAYER_HANDLER_MOD);

	if(getRoleUID() != INVALID_ROLE_UID)
	{
		CRoleBase* role = getRole(MGR_QUE_TYPE_INVALID);
		if(NULL != role && !role->isLogout())
		{
			role->waitReconnect();
		}
	}
	else
	{
		gxInfo("RoleUID is invalid!SocketIndex={0}", getSocketIndex());
	}

	FUNC_END(DRET_NULL);
}

void CMapPlayerHandlerBase::initData()
{
	_lastHeartTime = DTimeManager.nowSysTime();
	_lastSendHeartTime = DTimeManager.nowSysTime();
	_heartDiffTime = 10;
	_heartOutDiffTime = 30;
}

bool CMapPlayerHandlerBase::isHeartOutTime()
{
	return GXMISC::TDiffTime_t(DTimeManager.nowSysTime()-getLastHeartTime()) > getHeartOutDiffTime();
}

bool CMapPlayerHandlerBase::isNeedSendHeart()
{
	return GXMISC::TDiffTime_t(DTimeManager.nowSysTime()-getLastSendHeartTime()) > getHeartDiffTime();
}

void CMapPlayerHandlerBase::doPlayerHeart()
{
	if(isNeedSendHeart())
	{
		MCPlayerHeart heartPacket;
		heartPacket.setRetCode(RC_SUCCESS);
		sendPacket(heartPacket);
		setLastSendHeartTime(DTimeManager.nowSysTime());
	}
}

void CMapPlayerHandlerBase::checkPlayerHeart()
{
#ifndef OS_WINDOWS 
	if(isHeartOutTime())
	{
		CRoleBase* pRole = getRole();
		if(NULL == pRole || pRole->isEnter())
		{
			gxError("Player heart out!{0}", toString());
			doCloseWaitReconnect();
			quit(0);
		}
	}
#endif
}

std::set<TPacketID_t> CMapPlayerHandlerBase::FilterPackets;