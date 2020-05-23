#include "map_data_manager.h"
#include "map_data_tbl.h"

CMap* CMapDataManager::addNewMap( TMapID_t mapID, const std::string& mapName )
{
	gxDebug("Add new map!!!MapID={0},MapName={1}", mapID, mapName);
	CMap* pMap = _objPool.newObj();
	if(NULL == pMap)
	{
		gxError("Can't new CMap!");
		return NULL;
	}

	pMap->setMapID(mapID);
	if(false == pMap->load(mapName))
	{
		_objPool.deleteObj(pMap);
		return NULL;
	}

	if(false == add(pMap))
	{
		gxError("Can't add CMap! {0}", pMap->toString());
		_objPool.deleteObj(pMap);
		return NULL;
	}

	return pMap;
}

void CMapDataManager::delMap( TBaseType::KeyType key )
{
	gxAssert(isExist(key));

	CMap* pMap = (CMap*)remove(key);
	if(NULL != pMap)
	{
		_objPool.deleteObj(pMap);
	}
	else
	{
		gxAssert(false);
	}
}

bool CMapDataManager::init( const std::string path )
{
	if(false == _objPool.init(DMapTblMgr.size()))
	{
		return false;
	}

	for(CMapTblLoader::Iterator iter = DMapTblMgr.begin(); iter != DMapTblMgr.end(); ++iter)
	{
		std::string tempPath = path;
		tempPath += "/";
		tempPath += iter->second->dataFileName;
		CMapBase* pMap = addNewMap(iter->second->mapID, tempPath);
		if(NULL == pMap)
		{
			continue;
		}

		CMapConfigTbl* pConfig = iter->second;
		pMap->setMapConfig(iter->second);
		pMap->setEmptyPos(&TAxisPos(pConfig->x, pConfig->y));
	}

	return true;
}

CMapDataManager::CMapDataManager()
{
}

CMapDataManager::~CMapDataManager()
{
}

CMap* CMapDataManager::findMap( TMapID_t mapID )
{
	return dynamic_cast<CMap*>(CMapDataManagerBase::findMap(mapID));
}
