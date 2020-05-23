#ifndef _SCENE_MANAGER_H_
#define _SCENE_MANAGER_H_

#include "game_util.h"
#include "game_misc.h"
#include "scene.h"

#include "core/multi_index.h"
#include "core/singleton.h"
#include "core/obj_mem_fix_pool.h"

class CSceneManager : 
    public GXMISC::CHashMultiIndex<CScene>, 
    public GXMISC::CManualSingleton<CSceneManager>
{
public:
    typedef GXMISC::CHashMultiIndex<CScene> TBaseType;
	DSingletonImpl();
	DMultiIndexIterFunc(CScene);

public:
    CSceneManager(){}
    ~CSceneManager(){}

public:
    bool		init(uint32 maxNum);

public:
    void		update(uint32 diff);
    CScene*		addScene(TSceneData* data);
    void		delScene(TSceneID_t sceneID);
	TObjUID_t	getSceneOwner(TSceneID_t sceneID);
	void		changeSceneOwner(TSceneID_t sceneID, TObjUID_t objUID);		// 改变场景所有者
    uint32		size();
    void		delMapServer(TServerID_t mapServerID);
    CScene*		getLeastScene(TMapID_t mapID);
    CScene*		getLeastScene(TMapID_t mapID, TServerID_t mapServerID);
    CScene*		getEmptyScene(TMapID_t mapID);
    CScene*		getEmptyScene(TMapID_t mapID, TServerID_t mapServerID);

// 	void		closeDynamicScene(TSceneID_t sceneID, TMapServerID_t mapServerID);
// 	bool		openDynamicScene(TMapID_t mapID, TObjUID_t objUID);
// 
// public:
//     void		onOpenDynamicScene(TSceneID_t sceneID, TMapServerID_t mapServerID, EGameRetCode retCode);

public:
    CScene*		findScene( TSceneID_t sceneID );
    bool		isSceneExist( TSceneID_t sceneID );

private:
    GXMISC::CFixObjPool<CScene> _objPool;
};

#define DSceneMgr CSceneManager::GetInstance()

#endif