#include "scene_manager.h"
#include "map_manager.h"
#include "game_exception.h"
#include "module_def.h"
#include "world_map_player_mgr.h"
#include "world_map_player.h"
#include "packet_mw_base.h"

bool CSceneManager::init( uint32 maxNum )
{
	return _objPool.init(maxNum);
}

void CSceneManager::update( uint32 diff )
{
	
}

CScene* CSceneManager::addScene( TSceneData* data )
{
    FUNC_BEGIN(SCENE_MOD);

	CScene* pScene = _objPool.newObj();
	if(NULL == pScene)
	{
		gxError("Can't new CScene!");
		return NULL;
	}

	pScene->init(data);
	if(false == add(pScene))
	{
		gxError("Can't add scene!{0}", pScene->toString());
		_objPool.deleteObj(pScene);
		return NULL;
	}

	if(false == DMapMgr.addScene(pScene))
	{
		gxError("Can't add scene to map manager!{0}", pScene->toString());
		delScene(pScene->getSceneID());
		return NULL;
	}

	gxInfo("Add scene!{0}", pScene->toString());
	
	return pScene;

    FUNC_END(NULL);
}

void CSceneManager::delScene( TSceneID_t sceneID )
{
    FUNC_BEGIN(SCENE_MOD);

	DMapMgr.delScene(sceneID);
	if ( !isSceneExist(sceneID) )
	{
		gxError("Delete scene failed!!! Can't find sceneID ={0}", sceneID);
		gxAssert(false);
		return ;
	}
	CScene* pScene = remove(sceneID);
	if(NULL != pScene)
	{
		gxInfo("Delete scene!{0}", pScene->toString());
		_objPool.deleteObj(pScene);
	}
	else
	{
		gxError("Can't find scene! SceneID={0}", sceneID);
	}

    FUNC_END(DRET_NULL);
}

TObjUID_t CSceneManager::getSceneOwner( TSceneID_t sceneID )
{
	FUNC_BEGIN(SCENE_MOD);
	CScene* pScene = find(sceneID);
	if(NULL == pScene)
	{
		gxError("Can't find scene!!! sceneID = {0}", sceneID);
		gxAssert(false);
		return INVALID_OBJ_UID;
	}
	return pScene->getOwner();
	FUNC_END(INVALID_OBJ_UID);
}

void CSceneManager::changeSceneOwner( TSceneID_t sceneID, TObjUID_t objUID )
{
	FUNC_BEGIN(SCENE_MOD);
	CScene* pScene = find(sceneID);
	if(NULL == pScene)
	{
		gxError("Can't find scene!!! sceneID = {0}", sceneID);
		gxAssert(false);
		return ;
	}
	pScene->changeOwner(objUID);
	FUNC_END(DRET_NULL);
}

uint32 CSceneManager::size()
{
	return TBaseType::size();
}

CScene* CSceneManager::findScene( TSceneID_t sceneID )
{
	return find(sceneID);
}

bool CSceneManager::isSceneExist( TSceneID_t sceneID )
{
	return isExist(sceneID);
}

void CSceneManager::delMapServer( TServerID_t mapServerID )
{
	std::vector<TSceneID_t> delScenes;
	for(TBaseType::Iterator iter = begin(); iter != end(); ++iter)
	{
		CScene* pScene = iter->second;
		if(NULL == pScene)
		{
			continue;
		}

		if(pScene->getMapServerID() == mapServerID)
		{
			delScenes.push_back(pScene->getSceneID());
		}
	}

	for(uint32 i = 0; i < delScenes.size(); ++i)
	{
		delScene(delScenes[i]);
	}
}

CScene* CSceneManager::getLeastScene(TMapID_t mapID)
{
	return DMapMgr.getLeastScene(mapID);
}

CScene* CSceneManager::getLeastScene( TMapID_t mapID, TServerID_t mapServerID )
{
	return DMapMgr.getLeastScene(mapID, mapServerID);
}

CScene* CSceneManager::getEmptyScene( TMapID_t mapID )
{
	return DMapMgr.getEmptyScene(mapID);
}

CScene* CSceneManager::getEmptyScene( TMapID_t mapID, TServerID_t mapServerID )
{
	return DMapMgr.getEmptyScene(mapID, mapServerID);
}

// void CSceneManager::closeDynamicScene(TSceneID_t sceneID, TMapServerID_t mapServerID)
// {
//     WMCloseDynamicMap closeMap;
//     closeMap.sceneID=sceneID;
// 
//     if(isSceneExist(sceneID))
//     {
//         delScene(sceneID);
//     }
// 
//     CWorldMapPlayer* pMapServer = DWorldMapPlayerMgr.findMapPlayer(mapServerID);
//     if(NULL == pMapServer)
//     {
//         gxError("Can't find mapserver!MapServerID=%u", mapServerID);
//         return;
//     }
// 
//     pMapServer->sendPacket(closeMap);
// }
// 
// bool CSceneManager::openDynamicScene( TMapID_t mapID, TObjUID_t objUID )
// {
//     CMapConfigTbl* pMap = DWorldMapTblMgr.find(mapID);
//     if(NULL == pMap)
//     {
//         gxError("Can't open dynamic scene, not find map!MapID=%u", mapID);
//         return false;
//     }
//     CWorldMapPlayer* pMapServer = DWorldMapPlayerMgr.getLeastDynamicServer();
//     if(NULL == pMapServer)
//     {
//         gxError("Can't open dynamic scene, not find mapserver!MapID=%u", mapID);
//         return false;
//     }
// 
//     WMOpenDynamicMap openMap;
//     openMap.mapID = mapID;
//     openMap.objUID = objUID;
//     openMap.sceneType = (ESceneType)pMap->mapType;
// 
//     pMapServer->sendPacket(openMap);
// 
//     return true;
// }
// 
// void CSceneManager::onOpenDynamicScene( TSceneID_t sceneID, TMapServerID_t mapServerID, EGameRetCode retCode )
// {
//     FUNC_BEGIN(SCENE_MOD);
//     
//     gxInfo("Open dynamic scene!SceneID=%"I64_FMT"u, MapServerID=%u, Retcode=%u", sceneID, mapServerID, retCode);
// 	if ( IsSuccess(retCode) )
// 	{
// 		ESceneType sceneType = (ESceneType)CGameMisc::GetMapType(sceneID);
// 		TMapID_t mapID = CGameMisc::GetMapID(sceneID);
// 		switch ( sceneType )
// 		{
// 		case SCENE_TYPE_GUILD_BATTLE:
// 			{
// 				DGuildPKMgr.openGroupPKSceneSuccess(sceneID);
// 			}break;
// 		case SCENE_TYPE_GROUND_BATTLE:
// 			{
// 				DGroundPKMgr.openGroupPKSceneSuccess(mapID, sceneID);
// 			}break;
// 		case SCENE_TYPE_CAMP_BATTLE:
// 			{
// 				DCampPKMgr.openGroupPKSceneSuccess(sceneID);
// 			}break;
// 		case SCENE_TYPE_CHAMPION_BATTLE:
// 			{
// 				DChampionPKMgr.openGroupPKSceneSuccess(sceneID);
// 			}break;
// 		default:
// 			{
// 				
// 			}break;
// 		}
// 	}
// 
//     FUNC_END(DRET_NULL);
// }