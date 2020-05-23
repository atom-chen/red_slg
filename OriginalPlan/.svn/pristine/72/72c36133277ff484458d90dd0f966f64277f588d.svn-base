#include "map_data_manager_base.h"

CMapDataManagerBase* g_MapDataManagerBase = NULL;

CMapDataManagerBase::TBaseType::ValueType CMapDataManagerBase::findMap( TBaseType::KeyType uid )
{
	return find(uid);
}

bool CMapDataManagerBase::isMapExist( TBaseType::KeyType key )
{
	return isExist(key);
}

TMapIDList CMapDataManagerBase::getNormalMaps()
{
	TMapIDList maps;
	for(Iterator iter = begin(); iter != end(); ++iter){
		if(CGameMisc::IsNormalMap((ESceneType)iter->second->getMapType()))
		{
			maps.push_back(iter->second->getMapID());
		}
	}

	return maps;
}

CMapDataManagerBase::CMapDataManagerBase()
{
	g_MapDataManagerBase = this;
}

CMapDataManagerBase::~CMapDataManagerBase()
{
	g_MapDataManagerBase = NULL;
}
