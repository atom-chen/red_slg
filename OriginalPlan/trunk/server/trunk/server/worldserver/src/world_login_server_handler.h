#ifndef _WORLD_LOGIN_SERVER_HANDLER_H_
#define _WORLD_LOGIN_SERVER_HANDLER_H_

#include "game_socket_handler.h"
#include "base_packet_def.h"
#include "packet_lw_base.h"
#include "world_server_config.h"

class CWorldLoginServerHandler : public CGameSocketHandler<CWorldLoginServerHandler>
{
public:
//	static CWorldLoginServerHandler* WorldLoginServerHandler;

public:
	typedef CGameSocketHandler<CWorldLoginServerHandler> TBaseType;

public:
	CWorldLoginServerHandler() : CGameSocketHandler<CWorldLoginServerHandler>() 
	{
//		WorldLoginServerHandler = this;
	}

	~CWorldLoginServerHandler() {
//		WorldLoginServerHandler = NULL;
	}

protected:
	virtual bool start();
	virtual void close();
	virtual void breath(GXMISC::TDiffTime_t diff);

public:
	void sendUpdateData(sint32 roleNum);
	void sendRegiste(CWorldServerConfig* pConfig);
	void sendRoleLogin(TLoginKey_t loginKey, TAccountID_t accountID, TRoleUID_t roleUID, std::string roleName, TWorldServerID_t serverID, std::string clientIP);
	void sendRoleCreate(TLoginKey_t loginKey);
	void sendRoleLimit(TAccountID_t accountID,TRoleUID_t roleUID, TWorldServerID_t serverID );

protected:
	GXMISC::EHandleRet handleRegiste(CLWRegisteRet* packet);
	GXMISC::EHandleRet handleRoleCreateRet(CLWRoleCreateRet* packet);
	GXMISC::EHandleRet handleRoleLogin(CLWRoleLoginRet* packet);
	GXMISC::EHandleRet handleLimitInfo(CLWLimitInfoUpdate* packet);
	GXMISC::EHandleRet handleLimitAccountInfo( CLWLimitAccountInfo* packet );
	GXMISC::EHandleRet handleLimitChatInfo( CLWLimitChatInfo* packet );

public:
	static void Setup();
	static void UnSetup();
};

#endif	// _WORLD_LOGIN_SERVER_HANDLER_H_