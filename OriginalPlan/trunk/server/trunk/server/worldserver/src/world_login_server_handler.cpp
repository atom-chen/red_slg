#include "world_login_server_handler.h"
#include "core/game_exception.h"
#include "module_def.h"
#include "world_player_mgr.h"
#include "world_server.h"
#include "game_server_socket_packet_handler.h"
#include "world_login_server_mgr.h"

void CWorldLoginServerHandler::Setup()
{
	FUNC_BEGIN(WORLD_LOGIN_SERVER_MOD);

	RegisteHandler(PACKET_LW_REGIST_RET, (TPacketHandler)&CWorldLoginServerHandler::handleRegiste);
	RegisteHandler(PACKET_LW_LIMIT_INFO_UPDATE, (TPacketHandler)&CWorldLoginServerHandler::handleLimitInfo);
	RegisteHandler(PACKET_LW_LIMIT_ACCOUNT_INFO, (TPacketHandler)&CWorldLoginServerHandler::handleLimitAccountInfo);
	RegisteHandler(PACKET_LW_LIMIT_CHAT_INFO, (TPacketHandler)&CWorldLoginServerHandler::handleLimitChatInfo);

	FUNC_END(DRET_NULL);
}

void CWorldLoginServerHandler::UnSetup()
{
	FUNC_BEGIN(WORLD_LOGIN_SERVER_MOD);

	FUNC_END(DRET_NULL);
}

bool CWorldLoginServerHandler::start()
{
	FUNC_BEGIN(WORLD_LOGIN_SERVER_MOD);

	sendRegiste(DWorldServer->getConfig());

	return true;

	FUNC_END(false);
}

void CWorldLoginServerHandler::close()
{
	FUNC_BEGIN(WORLD_LOGIN_SERVER_MOD);

//	TBaseType::close();

//	WorldLoginServerHandler = NULL;
	DWorldLoginServerMgr.deleteBySocketIndex(getSocketIndex());

	FUNC_END(DRET_NULL);
}

void CWorldLoginServerHandler::breath( GXMISC::TDiffTime_t diff )
{
	FUNC_BEGIN(WORLD_LOGIN_SERVER_MOD);

	TBaseType::breath(diff);

	FUNC_END(DRET_NULL);
}

void CWorldLoginServerHandler::sendUpdateData(sint32 roleNum)
{
	FUNC_BEGIN(WORLD_LOGIN_SERVER_MOD);

	FUNC_END(DRET_NULL);
}

void CWorldLoginServerHandler::sendRegiste(CWorldServerConfig* pConfig)
{
	FUNC_BEGIN(WORLD_LOGIN_SERVER_MOD);

	CWLRegiste registePacket;
	registePacket.serverID = pConfig->getWorldServerID();
	registePacket.ip = pConfig->getToClientIP();
	registePacket.port = pConfig->getToClientPort();
	registePacket.num = DWorldPlayerMgr.size();
	registePacket.dbIP = pConfig->getDbHostIP();
	registePacket.dbPort = pConfig->getDbPort();
	registePacket.dbUser = pConfig->getDbUser();
	registePacket.dbPasswd = pConfig->getDbPwd();
	sendPacket(registePacket);

	FUNC_END(DRET_NULL);
}

void CWorldLoginServerHandler::sendRoleLogin(TLoginKey_t loginKey, TAccountID_t accountID, 
	TRoleUID_t roleUID, std::string roleName, TWorldServerID_t serverID, std::string clientIP)
{
	FUNC_BEGIN(WORLD_LOGIN_SERVER_MOD);

	CWLRoleLogin roleLogin;
	roleLogin.accountID = accountID;
	roleLogin.loginKey = loginKey;
	roleLogin.roleName = roleName;
	roleLogin.roleUID = roleUID;
	roleLogin.worldServerID = serverID;
	roleLogin.clientIP = clientIP;

	sendPacket(roleLogin);

	FUNC_END(DRET_NULL);
}

void CWorldLoginServerHandler::sendRoleLimit(TAccountID_t accountID, TRoleUID_t roleUID, TWorldServerID_t serverID )
{
	FUNC_BEGIN(WORLD_LOGIN_SERVER_MOD);

	CWLLimitInfoReq limitReq;
	limitReq.limitAccountID = accountID;	;
	limitReq.limitRoleID    = roleUID;
	limitReq.serverID       = serverID;	

	sendPacket(limitReq);

	FUNC_END(DRET_NULL);
}

void CWorldLoginServerHandler::sendRoleCreate(TLoginKey_t loginKey)
{
	FUNC_BEGIN(WORLD_LOGIN_SERVER_MOD);

	CWLRoleCreate roleCreate;
	roleCreate.loginKey = loginKey;
	sendPacket(roleCreate);

	FUNC_END(DRET_NULL);
}

GXMISC::EHandleRet CWorldLoginServerHandler::handleRegiste( CLWRegisteRet* packet )
{
	FUNC_BEGIN(WORLD_LOGIN_SERVER_MOD);

	if(packet->isSuccess())
	{
		DWorldLoginServerMgr.addServer(&packet->serverData, getSocketIndex());
	}
	else
	{
		gxError("World server cant registe to login server!");
		DWorldServer->setStop();
	}

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CWorldLoginServerHandler::handleRoleCreateRet( CLWRoleCreateRet* packet )
{
	FUNC_BEGIN(WORLD_LOGIN_SERVER_MOD);

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CWorldLoginServerHandler::handleRoleLogin( CLWRoleLoginRet* packet )
{
	FUNC_BEGIN(WORLD_LOGIN_SERVER_MOD);

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CWorldLoginServerHandler::handleLimitInfo( CLWLimitInfoUpdate* packet )
{
	FUNC_BEGIN(LOGIN_MOD);

	for(sint32 i = 0; i < packet->accountID.size(); ++i)
	{
		CWorldPlayer* pPlayer = DWorldPlayerMgr.findByAccountID(packet->accountID[i]);
		if(NULL != pPlayer)
		{
			if(pPlayer->isEnterGame())
			{
				CLWLimitInfoUpdate limitUpdate;
				limitUpdate = *packet;
				limitUpdate.accountID.clear();
				limitUpdate.accountID.pushBack(packet->accountID[i]);
				pPlayer->sendToMapServer(limitUpdate);
			}
		}
	}

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CWorldLoginServerHandler::handleLimitAccountInfo( CLWLimitAccountInfo* packet )
{
	FUNC_BEGIN(LOGIN_MOD);

	
	CWorldPlayer* pPlayer = DWorldPlayerMgr.findByAccountID(packet->limitAccountID);
	if(NULL != pPlayer)
	{
		if(pPlayer->isEnterGame() )      //@TODO 
		{
			CWMLimitAccountInfo info;
			info.limitAccountID = packet->limitAccountID;
			info.limitRoleID    = packet->limitRoleID;
			info.begintime      = packet->begintime;
			info.endtime        = packet->endtime;
			pPlayer->sendToMapServer(info);		
		}
	}
	

	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

GXMISC::EHandleRet CWorldLoginServerHandler::handleLimitChatInfo( CLWLimitChatInfo* packet )
{
	FUNC_BEGIN(LOGIN_MOD);


	CWorldPlayer* pPlayer = DWorldPlayerMgr.findByAccountID(packet->limitAccountID);
	if(NULL != pPlayer)
	{
		if(pPlayer->isEnterGame())
		{
			CWMLimitChatInfo info;
			info.limitAccountID = packet->limitAccountID;
			info.limitRoleID    = packet->limitRoleID;
			info.begintime      = packet->begintime;
			info.endtime        = packet->endtime;
			info.uniqueId       = packet->uniqueId;
			pPlayer->sendToMapServer(info);		
		}
	}


	FUNC_END(GXMISC::HANDLE_RET_FAILED);
}

//CWorldLoginServerHandler* CWorldLoginServerHandler::WorldLoginServerHandler = NULL;
