#ifndef _MAP_MANAGER_H_
#define _MAP_MANAGER_H_

#include "singleton.h"
#include "map.h"
#include "obj_mem_fix_pool.h"

#include "multi_index.h"

class CMapManager :
	public GXMISC::CHashMultiIndex<CMap>, 
	public GXMISC::CManualSingleton<CMapManager>
{
public:
	typedef GXMISC::CHashMultiIndex<CMap> TBaseType;
	DSingletonImpl();
	DMultiIndexIterFunc(CMap);
public:
	CMapManager(){}
	~CMapManager(){}

public:
	bool init(uint32 maxNum);

public:
	void update(uint32 diff);
	CMap* addMap(TMapID_t mapID);
	void delMap(TMapID_t mapID);
	uint32 size();
	bool addScene(CScene* pScene);
	void delScene(TSceneID_t sceneID);
	CScene* getLeastScene(TMapID_t mapID);
	CScene* getLeastScene(TMapID_t mapID, TServerID_t mapServerID);
	CScene* getEmptyScene(TMapID_t mapID);
	CScene* getEmptyScene(TMapID_t mapID, TServerID_t mapServerID);
public:
	CMap* findMap( TMapID_t mapID );
	bool isMapExist( TMapID_t mapID );

private:
	GXMISC::CFixObjPool<CMap> _objPool;
};

#define DMapMgr CMapManager::GetInstance()

#endif