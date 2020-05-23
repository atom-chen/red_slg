#include "world_login_server_mgr.h"

bool CWorldLoginServerManager::isExistByServerID( TServerID_t serverID )
{
	return serverDatas.isExistByKey(serverID);
}

CWorldLoginServer* CWorldLoginServerManager::findByServerID( TServerID_t serverID )
{
	return serverDatas.findDataByKey(serverID);
}

void CWorldLoginServerManager::deleteByServerID( TServerID_t serverID )
{
	for(CArray1<CWorldLoginServer>::size_type i = 0; i < serverDatas.size(); ++i)
	{
		if(serverDatas[i].serverData.serverID == serverID)
		{
			serverDatas.erase(i);
		}
	}
}

void CWorldLoginServerManager::addServer( TLoginServerData* serverData, GXMISC::TSocketIndex_t socketIndex )
{
	CWorldLoginServer* pServerData = findByServerID(serverData->serverID);
	if(NULL == pServerData)
	{
		pServerData = &(serverDatas.addSize());
	}
	
	pServerData->serverData = *serverData;
	pServerData->socketIndex = socketIndex;
}

CWorldLoginServer* CWorldLoginServerManager::getRandServer()
{
	if(serverDatas.empty())
	{
		return NULL;
	}

	sint32 index = 0;
	index = DRand(0, (sint32)(serverDatas.size()-1));
	return &(serverDatas[index]);
}

sint32 CWorldLoginServerManager::size()
{
	return serverDatas.size();
}

void CWorldLoginServerManager::deleteBySocketIndex( GXMISC::TSocketIndex_t socketIndex )
{
	for(CArray1<CWorldLoginServer>::size_type i = 0; i < serverDatas.size(); ++i)
	{
		if(serverDatas[i].socketIndex == socketIndex)
		{
			serverDatas.erase(i);
		}
	}
}

CWorldLoginServerHandler* GetLoginServer(bool logFlag)
{
	CWorldLoginServer* pServer = DWorldLoginServerMgr.getRandServer();
	if(NULL != pServer)
	{
		return pServer->getServerHandler();
	}
	else if(logFlag)
	{
		gxError("Cant find login server handler!");
	}

	return NULL;
}

bool IsHasLoginServer()
{
	return DWorldLoginServerMgr.size() > 0;
}
