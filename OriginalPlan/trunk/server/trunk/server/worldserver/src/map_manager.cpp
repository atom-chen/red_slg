#include "map_manager.h"
#include "game_misc.h"

bool CMapManager::init( uint32 maxNum )
{
	return _objPool.init(maxNum);
}

void CMapManager::update( uint32 diff )
{

}

CMap* CMapManager::addMap( TMapID_t mapID )
{
	CMap* pMap = _objPool.newObj();
	if(NULL == pMap)
	{
		gxError("Can't new CMap!");
		return NULL;
	}

	pMap->setMapID(mapID);
	if(false == add(pMap))
	{
		gxError("Can't add map! {0}", pMap->toString());
		_objPool.deleteObj(pMap);
		return NULL;
	}

	return pMap;
}

void CMapManager::delMap( TMapID_t mapID )
{
	gxAssert(isMapExist(mapID));
	CMap* pMap = remove(mapID);
	if(NULL != pMap)
	{
		_objPool.deleteObj(pMap);
	}
	else
	{
		gxError("Can't find map! MapID={0}", mapID);
	}
}

uint32 CMapManager::size()
{
	return TBaseType::size();
}

CMap* CMapManager::findMap( TMapID_t mapID )
{
	return find(mapID);
}

bool CMapManager::isMapExist( TMapID_t mapID )
{
	return isExist(mapID);
}

bool CMapManager::addScene( CScene* pScene )
{
	TMapID_t mapID = CGameMisc::GetMapID(pScene->getSceneID());
	if(mapID == INVALID_MAP_ID)
	{
		gxError("Can't add scene, mapid is invalid!{0}", pScene->toString());
		return false;
	}
	CMap* pMap = findMap(mapID);
	if(NULL == pMap)
	{
		pMap = addMap(mapID);
	}
	if(NULL == pMap)
	{
		gxError("Can't add scene, can't find map!{0}", pScene->toString());
		return false;
	}
	
	return pMap->addScene(pScene);
}

void CMapManager::delScene( TSceneID_t sceneID )
{
	TMapID_t mapID = CGameMisc::GetMapID(sceneID);
	if(mapID == INVALID_MAP_ID)
	{
		gxError("Can't del scene, mapid is invalid!SceneID={0}", sceneID);
		return;
	}
	CMap* pMap = findMap(mapID);
	if(NULL == pMap)
	{
		gxError("Can't del scene, can't find map!SceneID={0}", sceneID);
		return;
	}

	pMap->delScene(sceneID);
}

CScene* CMapManager::getLeastScene( TMapID_t mapID )
{
	CMap* pMap = findMap(mapID);
	if(NULL == pMap)
	{
		gxError("Can't get least scene, can't find map!MapID={0}", mapID);
		return false;
	}

	return pMap->getLeastScene();
}

CScene* CMapManager::getLeastScene( TMapID_t mapID, TServerID_t mapServerID )
{
	CMap* pMap = findMap(mapID);
	if(NULL == pMap)
	{
		gxError("Can't get least scene, can't find map!MapID={0}", mapID);
		return false;
	}

	return pMap->getLeastScene(mapServerID);
}

CScene* CMapManager::getEmptyScene( TMapID_t mapID )
{
	CMap* pMap = findMap(mapID);
	if(NULL == pMap)
	{
		gxError("Can't get least scene, can't find map!MapID={0}", mapID);
		return false;
	}

	return pMap->getEmptyScene();
}

CScene* CMapManager::getEmptyScene( TMapID_t mapID, TServerID_t mapServerID )
{
	CMap* pMap = findMap(mapID);
	if(NULL == pMap)
	{
		gxError("Can't get least scene, can't find map!MapID={0}", mapID);
		return false;
	}

	return pMap->getEmptyScene(mapServerID);
}