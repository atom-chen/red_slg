#ifndef _MAP_DATA_MANAGER_BASE_H_
#define _MAP_DATA_MANAGER_BASE_H_

#include "core/multi_index.h"
#include "core/singleton.h"
#include "core/debug.h"
#include "core/obj_mem_fix_pool.h"

#include "map_data_base.h"

class CMapDataManagerBase :
	public GXMISC::CHashMultiIndex<CMapBase>
{
public:
	typedef GXMISC::CHashMultiIndex<CMapBase> TBaseType;
	DMultiIndexIterFunc(CMapBase);
public:
	CMapDataManagerBase();
	virtual ~CMapDataManagerBase();

public:
	TMapIDList getNormalMaps();

public:
	TBaseType::ValueType findMap( TBaseType::KeyType uid );
	bool isMapExist(TBaseType::KeyType key);
};

extern CMapDataManagerBase* g_MapDataManagerBase;
#define DMapDataMgrBase g_MapDataManagerBase

#endif	// _MAP_DATA_MANAGER_BASE_H_