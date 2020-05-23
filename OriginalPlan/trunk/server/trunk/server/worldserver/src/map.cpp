#include "map.h"
#include "world_map_player.h"
#include "world_map_player_mgr.h"

bool CMap::addScene( CScene* pScene )
{
	if(_scenes.find(pScene->getSceneID()) != _scenes.end())
	{
		gxError("Scene is repeat!{0}", pScene->toString());
		return false;
	}

	_scenes[pScene->getSceneID()] = pScene;
	gxInfo("Add new scene to map!{0}", pScene->toString());
	return true;
}

void CMap::delScene( TSceneID_t sceneID )
{
	_scenes.erase(sceneID);
}

CScene* CMap::getLeastScene()
{
    return getLeastScene(INVALID_SERVER_ID);
}

CScene* CMap::getLeastScene( TServerID_t mapServerID )
{
	sint32 minRoleNum = GXMISC::MAX_SINT32_NUM;
	CScene* minScene = NULL;
	for(TSceneMap::iterator iter = _scenes.begin(); iter != _scenes.end(); ++iter)
	{
		CScene* pScene = iter->second;
		if(NULL == pScene)
		{
			continue;
		}

        CWorldMapPlayer* mapServer = DWorldMapPlayerMgr.findMapPlayer(pScene->getMapServerID());
        if(NULL == mapServer)
        {
            continue;
        }

		if(mapServerID != pScene->getMapServerID() && pScene->isNormalScene() && !mapServer->isMaxNum() && mapServer->getRoleNum() < minRoleNum)
		{
            minRoleNum = mapServer->getRoleNum();
            minScene = pScene;
		}
	}

	return minScene;
}

void CMap::setMapID( TMapID_t mapID )
{
	_mapID = mapID;
}

TMapID_t CMap::getMapID()
{
	return _mapID;
}

CScene* CMap::getEmptyScene()
{
    return getEmptyScene(INVALID_SERVER_ID);
}

CScene* CMap::getEmptyScene( TServerID_t mapServerID )
{
	CScene* minScene = NULL;
	TServerID_t minMapServerID = std::numeric_limits<TServerID_t>::max();
	for(TSceneMap::iterator iter = _scenes.begin(); iter != _scenes.end(); ++iter)
	{
		CScene* pScene = iter->second;
		if(NULL == pScene)
		{
			continue;
		}

		CWorldMapPlayer* mapServer = DWorldMapPlayerMgr.findMapPlayer(pScene->getMapServerID());
		if(NULL == mapServer)
		{
			continue;
		}

		if(pScene->getMapServerID() < minMapServerID && pScene->getMapServerID() != mapServerID && pScene->isNormalScene() && !mapServer->isHalfNum())
		{
			minMapServerID = pScene->getMapServerID();
			minScene = pScene;
		}
	}

	if(NULL == minScene)
	{
		return getLeastScene(mapServerID);
	}

	return minScene;
}
