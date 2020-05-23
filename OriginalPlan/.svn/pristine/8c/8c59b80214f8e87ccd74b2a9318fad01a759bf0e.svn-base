#include "world_map_player_mgr.h"
#include "packet_mw_base.h"
#include "world_server_util.h"
#include "world_server.h"

CWorldMapPlayer* CWorldMapPlayerMgr::getLeastNormalMapServer() 
{
	CWorldMapPlayer* retPlayer = NULL;
	for (TBaseType::Iterator iter = begin(); iter != end(); ++iter) 
	{
		CWorldMapPlayer* player = iter->second;
		if (player == NULL) 
		{
			continue;
		}

		if (player->isNormalServer()) 
		{
			if(retPlayer == NULL || player->getRoleNum() < retPlayer->getRoleNum())
			{
				retPlayer = player;
			}
		}
	}

	return retPlayer;
}

CWorldMapPlayer* CWorldMapPlayerMgr::getLeastDynamicServer()
{
	CWorldMapPlayer* retPlayer = NULL;
	for (TBaseType::Iterator iter = begin(); iter != end(); ++iter)
	{
		CWorldMapPlayer* player = iter->second;
		if (player == NULL) 
		{
			continue;
		}

		if (player->isDynamicServer()) 
		{
			if(retPlayer == NULL || player->getRoleNum() < retPlayer->getRoleNum())
			{
				retPlayer = player;
			}
		}
	}

	return retPlayer;
}

CWorldMapPlayer* CWorldMapPlayerMgr::addMapPlayer(TServerID_t serverID)
{
	CWorldMapPlayer* player = _objPool.newObj();
	if (NULL == player) {
		gxError("Can't new CWorldMapPlayer!ServerID = {0}", (uint32)serverID);
		return NULL;
	}

	player->setServerID(serverID);
	if (false == add(player)) {
		gxError("Can't add CWorldMapPlayer!ServerID = {0}", (uint32)serverID);
		_objPool.deleteObj(player);
		return NULL;
	}

	return player;
}

void CWorldMapPlayerMgr::delMapPlayer(TServerID_t serverID)
{
	CWorldMapPlayer* player = remove(serverID);
	gxAssert(player != NULL);
	if (NULL == player)
	{
		gxError("Can't find CWorldMapPlayer!ServerID = {0}", (uint32)serverID);
		return;
	}

	_objPool.deleteObj(player);
}

CWorldMapPlayer* CWorldMapPlayerMgr::findMapPlayer(TServerID_t serverID) 
{
	return find(serverID);
}

bool CWorldMapPlayerMgr::init(uint32 num) 
{
	return _objPool.init(num);
}


void CWorldMapPlayerMgr::update( GXMISC::TDiffTime_t diff )
{
	updateServerData(diff);
}

// @todo ¸Ä³É°ó¶¨
typedef struct _UpdateServerData
{
	TMapServerAry servers;
	TServerID_t mapServerID;
}TUpdateServerData;
void UpdateServerData(CWorldMapPlayer*& mapPlayer, void* arg)
{
	TUpdateServerData* serverAry = (TUpdateServerData*)arg;
	if(serverAry->mapServerID == mapPlayer->getServerID())
	{
		return;
	}

	TMapServerUpdate updateData;
	updateData.serverID = mapPlayer->getServerID();
	updateData.roleNums = mapPlayer->getRoleNum();
	mapPlayer->getScenes(updateData.scenes);
	if(!updateData.scenes.empty())
	{
		serverAry->servers.pushBack(updateData);
	}
}
void CWorldMapPlayerMgr::updateServerData( GXMISC::TDiffTime_t diff )
{
	if(!_updateServerDataTimer.update(diff))
	{
		return;
	}
	_updateServerDataTimer.reset(true);

	for(Iterator iter = begin(); iter != end(); ++iter)
	{
		CWorldMapPlayer* mapPlayer = iter->second;
		if(NULL == mapPlayer)
		{
			continue;
		}

		WMUpdateServer updateServers;
		TUpdateServerData updateS;
		updateS.mapServerID = mapPlayer->getServerID();
		traverse(&UpdateServerData, &updateS);
		if(!updateS.servers.empty())
		{
			updateServers.servers = updateS.servers;
			mapPlayer->sendPacket(updateServers);
		}
	}
}

CWorldMapPlayerMgr::CWorldMapPlayerMgr()
{
	_updateServerDataTimer.init(MAX_SCENE_DATA_UPDATE_TIME*10*1000);
}

CWorldMapPlayerMgr::~CWorldMapPlayerMgr()
{

}

void CWorldMapPlayerMgr::updateServerInfo()
{
	WMServerInfo serverInfo;
	serverInfo.openTime = DWorldServer->getServerInfo()->getOpenTime();
	serverInfo.firstStartTime = DWorldServer->getServerInfo()->getFirstStartTime();
	broadCast(serverInfo);
}
