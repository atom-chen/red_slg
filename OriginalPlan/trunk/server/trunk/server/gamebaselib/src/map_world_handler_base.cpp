#include "core/game_exception.h"

#include "map_world_handler_base.h"
#include "module_def.h"
#include "map_server_util.h"
#include "scene_manager_base.h"
#include "role_base.h"
#include "map_db_player_handler_base.h"
#include "packet_mw_base.h"
#include "role_manager_base.h"
#include "map_server_instance_base.h"
#include "role_manager_base.h"

CMapWorldServerHandlerBase* CMapWorldServerHandlerBase::WorldServerHandler = NULL;

bool CMapWorldServerHandlerBase::start()
{
	FUNC_BEGIN(MAP_WORLD_SERVER_HANDLER_MOD);

	sendRegisteToWorld(DMapServerBase->getServerID(), DMapServerBase->getServerType(), DMapServerBase->getMaxRoleNum(), 
		DMapServerBase->getToClientListenIP(), DMapServerBase->getToClientListenPort());
	WorldServerHandler = (CMapWorldServerHandlerBase*)this;

	gxInfo("Connect to world server!IP={0},Port={1}, RemoteIP={2},RemotePort={3}", getLocalIp(), getLocalPort(), getRemoteIp(), getRemotePort());
	return true;

	FUNC_END(false);
}

void CMapWorldServerHandlerBase::close()
{
	FUNC_BEGIN(MAP_WORLD_SERVER_HANDLER_MOD);

	// @TODO 把所有玩家T下线
	CMapWorldServerHandlerBase::WorldServerHandler = NULL;

	FUNC_END(DRET_NULL);
}

void CMapWorldServerHandlerBase::breath( GXMISC::TDiffTime_t diff )
{
	FUNC_BEGIN(MAP_WORLD_SERVER_HANDLER_MOD);

	TBaseType::breath(diff);

	FUNC_END(DRET_NULL);
}

void CMapWorldServerHandlerBase::quit()
{
	FUNC_BEGIN(MAP_WORLD_SERVER_HANDLER_MOD);

	FUNC_END(DRET_NULL);
}

bool CMapWorldServerHandlerBase::IsActive()
{
	FUNC_BEGIN(MAP_WORLD_SERVER_HANDLER_MOD);

	return NULL != CMapWorldServerHandlerBase::WorldServerHandler;

	FUNC_END(false);
}

void CMapWorldServerHandlerBase::sendRegisteToWorld( TServerID_t serverID, EServerType serverType, uint32 maxRoleNum,
	const GXMISC::TIPString_t& ip, GXMISC::TPort_t port )
{
	FUNC_BEGIN(MAP_WORLD_SERVER_HANDLER_MOD);

	MWRegiste registe;
	registe.serverData.serverID = serverID;
	registe.serverData.maxRoleNum = maxRoleNum;
	registe.serverType = serverType;
	registe.clientListenIP = ip;
	registe.clientListenPort = port;
	SceneMgrBase->getScenes(registe.serverData.scenes);
	sendPacket(registe);

	FUNC_END(DRET_NULL);
}

GXMISC::EHandleRet CMapWorldServerHandlerBase::handleRegisteToWorldRet( WMRegisteRet* packet )
{
	FUNC_BEGIN(MAP_WORLD_SERVER_HANDLER_MOD);

	if(packet->getRetCode() == RC_SUCCESS)
	{
		gxInfo("Map server registe to world server success!WorldServerID={0}", packet->worldServerID);
		DMapServerBase->onRegisteToWorld(packet->worldServerID);
	}
	else
	{
		gxError("Register from world server failed, stop server!ReturnCode={0}", packet->getRetCode());
		DMapServerBase->setStop();
	}

	return GXMISC::HANDLE_RET_OK;

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

void CMapWorldServerHandlerBase::WorldBroadPacket(CRoleBase*& pRole, void* arg)
{
	MWBroadPacket* packet = (MWBroadPacket*)arg;
	if(NULL == packet)
	{
		return;
	}

	CMapPlayerHandlerBase* player = pRole->getPlayerHandlerBase(false);
	if(NULL != player)
	{
		// 发送数据给玩家
		player->send(packet->msg.data(), packet->msg.sizeInBytes()-sizeof(TRransPackAry::size_type));
	}
}

GXMISC::EHandleRet CMapWorldServerHandlerBase::handleBroadCast( MWBroadPacket* packet )
{
	if(TRANS_CODE_CONTINUE == doBroadCast((CBasePacket*)packet->msg.data(), packet->srcObjUID))
	{
		// 需要广播数据
		DRoleMgrBase->traverseEnter(&CMapWorldServerHandlerBase::WorldBroadPacket, packet);
	}

	return GXMISC::HANDLE_RET_OK;
}


GXMISC::EHandleRet CMapWorldServerHandlerBase::handleTrans( MWTransPacket* packet )
{
	if(TRANS_CODE_CONTINUE == doTrans((CBasePacket*)packet->msg.data(), packet->srcObjUID, packet->destObjUID))
	{
		CRoleBase* pRole = DRoleMgrBase->findByObjUID(packet->destObjUID);
	//	if(NULL != pRole && pRole->isOnline()) @TODO 处理在线
		if(NULL != pRole)
		{
			CMapPlayerHandlerBase* player = pRole->getPlayerHandlerBase(false);
			if(NULL != player)
			{
				// 发送数据给玩家
				player->send(packet->msg.data(), packet->msg.sizeInBytes()-sizeof(TRransPackAry::size_type));
				return GXMISC::HANDLE_RET_OK;
			}
		}

		// 失败了是否需要通知发送人
		if(packet->srcObjUID == INVALID_OBJ_UID || packet->failedNeedRes)
		{
			return GXMISC::HANDLE_RET_OK;
		}

		// 转发数据错误
		WMTransPacketError transErr;
		transErr.srcObjUID = packet->srcObjUID;
		transErr.destObjUID = packet->destObjUID;
		transErr.msg = packet->msg;

		Trans2OtherMapServer(transErr, INVALID_OBJ_UID, packet->srcObjUID);
	}

	return GXMISC::HANDLE_RET_OK;
}

GXMISC::EHandleRet CMapWorldServerHandlerBase::handleTransError( WMTransPacketError* packet )
{
	doTransError((CBasePacket*)packet->msg.data(), packet->destObjUID, packet->srcObjUID, (EGameRetCode)packet->getRetCode());
	return GXMISC::HANDLE_RET_OK;
}

GXMISC::EHandleRet CMapWorldServerHandlerBase::handleRoleHeartRet( WMRoleHeartRet* packet )
{
	FUNC_BEGIN(SCENE_MOD);

	for(sint32 i = 0; i < packet->roles.size(); ++i)
	{
		CRoleBase* pRole = DRoleMgrBase->findByRoleUID(packet->roles[i].roleUID);
		if(NULL != pRole && !packet->roles[i].onlineFlag)
		{
			gxError("Role heart failed, kick role!RoleUID={0},AccountID={1}", packet->roles[i].roleUID, packet->roles[i].accountID);
			pRole->quit(true, "Heart kick!");
			return GXMISC::HANDLE_RET_OK;
		}
	}
	
	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CMapWorldServerHandlerBase::handleRename( WMRenameRoleNameRet* packet )
{
	FUNC_BEGIN(ROLE_MOD);

	CRoleBase* pRole = DRoleMgrBase->findByRoleUID(packet->roleUID);
	if(NULL == pRole){
		gxError("Rename return from world server, can't find role!RoleUID={0},RoleName={1}",
			packet->roleUID, packet->roleName.toString());
		return GXMISC::HANDLE_RET_OK;
	}
	
	if(packet->isSuccess()){
		if( !DRoleMgrBase->renameRole(packet->roleUID, packet->roleName.toString()) ){
			pRole->onRename(RC_LOGIN_RENAME_FAILED);
			return GXMISC::HANDLE_RET_OK;
		}

		pRole->onRename(RC_SUCCESS);
	}else{
		pRole->onRename((EGameRetCode)packet->getRetCode());
	}

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CMapWorldServerHandlerBase::handleServerInfo( WMServerInfo* packet )
{
	FUNC_BEGIN(MAP_WORLD_SERVER_HANDLER_MOD);

	DMapServerBase->onWorldServerInfo(packet);
	
	FUNC_END(GXMISC::HANDLE_RET_OK);
}

