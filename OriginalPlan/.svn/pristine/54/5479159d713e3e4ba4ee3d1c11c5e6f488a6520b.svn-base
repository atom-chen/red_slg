#ifndef _MAP_SCENE_MANAGER_H_
#define _MAP_SCENE_MANAGER_H_

#include "core/obj_mem_fix_pool.h"
#include "core/multi_index.h"
#include "core/singleton.h"
#include "core/debug.h"

#include "game_util.h"
#include "map_scene.h"
#include "map_server_config.h"
#include "scene_manager_base.h"

// 场景管理
class CSceneManager :
	public CSceneManagerBase,
	public GXMISC::CManualSingleton<CSceneManager>
{
public:
	typedef CSceneManagerBase TBaseType;
	DSingletonImpl();

public:
	CSceneManager(){}
	~CSceneManager(){}

public:
	virtual bool init(CMapServerConfig* config);
	virtual CMapSceneBase* addNewScene(TSceneID_t sceneID, uint8 mapType, bool addFlag);
	virtual void delScene(TSceneID_t sceneID);

public:
	CMapScene* findScene(TSceneID_t sceneID);

private:
	GXMISC::CFixObjPool<CMapScene>			_objPool;								// 普通场景对象池
};

#define DSceneMgr CSceneManager::GetInstance()

#endif