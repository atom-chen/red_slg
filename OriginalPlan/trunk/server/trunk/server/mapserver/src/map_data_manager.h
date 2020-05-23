#ifndef _MAP_DATA_MANAGER_H_
#define _MAP_DATA_MANAGER_H_

#include "core/singleton.h"

#include "map_data_manager_base.h"
#include "map_data.h"


class CMapDataManager :
	public CMapDataManagerBase,
	public GXMISC::CManualSingleton<CMapDataManager>
{
	DSingletonImpl();

public:
	CMapDataManager();
	~CMapDataManager();

public:
	bool init(const std::string path);

public:
	CMap* addNewMap(TMapID_t mapID, const std::string& mapName);
	void delMap(TBaseType::KeyType key);
	CMap* findMap(TMapID_t mapID);

private:
	GXMISC::CFixObjPool<CMap> _objPool;
};

#define DMapDataMgr CMapDataManager::GetInstance()

#endif	// _MAP_DATA_MANAGER_H_