#ifndef _WORLD_LOGIN_SERVER_MGR_H_
#define _WORLD_LOGIN_SERVER_MGR_H_

#include "core/base_util.h"
#include "core/singleton.h"
#include "core/carray.h"

#include "world_server_util.h"
#include "server_struct.h"
#include "world_login_server_handler.h"

class CWorldLoginServer : public GXMISC::IArrayEnable<CWorldLoginServer>
{
public:
	CWorldLoginServer(){
		DArrayKey(serverData.serverID);
	}
	~CWorldLoginServer(){}

public:
	template<typename T>
	void sendPacket(T& packet)
	{
		CWorldLoginServerHandler* pHandler = (CWorldLoginServerHandler*)DWorldNetMgr->getSocketHandler(socketIndex);
		if(NULL != pHandler)
		{
			pHandler->sendPacket(packet);
		}
		else
		{
			gxError("Cant find login server handler!SocketIndex={0},ServerID={1}", socketIndex, serverData.serverID);
		}
	}

	CWorldLoginServerHandler* getServerHandler()
	{
		return (CWorldLoginServerHandler*)DWorldNetMgr->getSocketHandler(socketIndex);
	}

public:
	TLoginServerData serverData;
	GXMISC::TSocketIndex_t socketIndex;

};

class CWorldLoginServerManager
	: public GXMISC::CSingleton<CWorldLoginServerManager>
{
public:
	CArray1<CWorldLoginServer> serverDatas;
	
public:
	bool isExistByServerID(TServerID_t serverID);
	CWorldLoginServer* findByServerID(TServerID_t serverID);
	void deleteByServerID(TServerID_t serverID);
	void deleteBySocketIndex(GXMISC::TSocketIndex_t socketIndex);
	void addServer(TLoginServerData* serverData, GXMISC::TSocketIndex_t socketIndex);
	CWorldLoginServer* getRandServer();
	sint32 size();
};

#define DWorldLoginServerMgr CWorldLoginServerManager::GetInstance()

template<typename T>
void SendToLogin(T& packet)
{
	CWorldLoginServer* pServer = DWorldLoginServerMgr.getRandServer();
	if(NULL != pServer)
	{
		pServer->sendPacket(packet);
	}
	else
	{
		gxError("Cant find login server handler!");
	}
}

CWorldLoginServerHandler* GetLoginServer(bool logFlag);
bool IsHasLoginServer();

#endif	// _WORLD_LOGIN_SERVER_MGR_H_