#include "core/game_exception.h"

#include "scene_manager_base.h"
#include "map_server_base.h"
#include "map_server_util.h"
#include "map_world_handler_base.h"
#include "map_data_manager_base.h"
#include "module_def.h"
#include "packet_mw_base.h"
#include "constant_define.h"
#include "constant_tbl.h"

bool CSceneManagerBase::initAllMap()
{
	TMapIDList mapIDS = DMapServerBase->getMapIDs();
	for(uint32 i = 0; i < mapIDS.size(); ++i)
	{
		CMapBase* pMapData = DMapDataMgrBase->findMap(mapIDS[i]);
		if(NULL == pMapData)
		{
			gxError("Can't find map!MapID={0}", mapIDS[i]);
			return false;
		}

		CMapSceneBase* pScene = addNewScene(genSceneID(DMapServerBase->getServerID(), 
			pMapData->getMapType(), mapIDS[i]), pMapData->getMapType(), true);
		if(pScene == NULL)
		{
			return false;   
		}

		if(!pScene->init(pMapData))
		{
			return false;
		}

		pScene->initRoleInfo(1024, GetConstant<TSceneGroupID_t>(OT_SCENE_ROLE_NUM));
	}

	return true;
}

void CSceneManagerBase::update( GXMISC::TDiffTime_t diff )
{
	GXMISC::TGameTime_t curTime = (GXMISC::TGameTime_t)DTimeManager.nowSysTime();
	std::vector<TSceneID_t> dynamicScenes;
	for(TBaseType::Iterator iter = begin(); iter != end(); ++iter)
	{
		CMapSceneBase* pScene = iter->second;
		if ( pScene == NULL )
		{
			gxError("Scene ptr is NULL");
			gxAssert(false);
			continue;
		}
		pScene->update(diff);
		if ( pScene->getIsNeedClose() && !pScene->isNormalScene() )
		{
			gxInfo("Del scene from scene manager!!! sceneID = {0}", GXMISC::gxToString(pScene->getSceneID()));
			dynamicScenes.push_back(pScene->getSceneID());
			continue;
		}
	}

	for(uint32 i = 0; i < dynamicScenes.size(); ++i)
	{
		closeDynamicScene(dynamicScenes[i], true);
	}
}

CMapSceneBase* CSceneManagerBase::findScene( TSceneID_t sceneID )
{
	return find(sceneID);
}

bool CSceneManagerBase::isSceneExist( TBaseType::KeyType key )
{
	return isExist(key);
}

// CSceneManagerBase::TBaseType::ValueType CSceneManagerBase::addNewScene( TSceneID_t sceneID, uint8 mapType )
// {
// 	CMapSceneBase* pScene = NULL;
// 	if(mapType == SCENE_TYPE_NORMAL)
// 	{
// 		pScene = _objPool.newObj();
// 	}
// 	else
// 	{
// 		gxError("Add new scene failed!SceneID={0}", sceneID);
// 		gxAssert(false);
// 		return NULL;
// 	}
// 
// 	if(NULL == pScene)
// 	{
// 		gxError("Can't new CMapScene!SceneID={0}", sceneID);
// 		return NULL;
// 	}
// 
// 	pScene->setSceneID(sceneID);
// 	if(false == add(pScene))
// 	{
// 		gxError("Can't add scene! {0}", pScene->toString());
// 		_objPool.deleteObj(pScene);
// 		return NULL;
// 	}
// 
// 	return pScene;
// }
// 
// void CSceneManagerBase::delScene( CMapSceneBase::KeyType key )
// {
// 	gxAssert(isSceneExist(key));
// 	CMapSceneBase* pScene = remove(key);
// 	if(NULL != pScene)
// 	{
// 		if(pScene->getSceneType() == SCENE_TYPE_NORMAL)
// 		{
// 			_objPool.deleteObj(pScene);
// 		}
// 		else
// 		{
// 			gxError("Scene type is invalid!SceneType={0}", pScene->getSceneType());
// 		}
// 	}
// 	else
// 	{
// 		gxError("Can't find scene! SceneID={0}", key);
// 	}
// }

TSceneID_t CSceneManagerBase::genSceneID( TServerID_t serverID, uint8 mapType, TMapID_t mapID )
{
	TSceneID_t sceneID = CGameMisc::GenSceneID(serverID, mapType, mapID, _genCopyID);
	_genCopyID++;
	return sceneID;
}

void CSceneManagerBase::getScenes( TSceneAry& scenes )
{
	// 获取普通的场景
	for(Iterator iter = begin(); iter != end(); ++iter)
	{
		CMapSceneBase* pScene = iter->second;
		if(NULL == pScene)
		{
			continue;
		}

		TSceneData sceneData;
		pScene->getSceneData(&sceneData);
		scenes.pushBack(sceneData);
	}
}

CMapSceneBase* CSceneManagerBase::getLeastScene( TMapID_t mapID )
{
	uint32 minNum = GXMISC::MAX_UINT32_NUM;
	CMapSceneBase* minScene = NULL;
	for(Iterator iter = begin(); iter != end(); ++iter)
	{
		CMapSceneBase* mapScene = iter->second;
		if(NULL == mapScene)
		{
			continue;
		}
		if(!mapScene->isNormalScene())
		{
			// 动态场景不能获取, 只能通过开启进入或findScene查找
			continue;
		}
		if(mapScene->getRoleMgr()->size() < minNum && mapScene->getMapID() == mapID)
		{
			minScene = mapScene;
			minNum = mapScene->getRoleMgr()->size();
		}
	}

	return minScene;
}

CMapSceneBase* CSceneManagerBase::openDynamicScene(TMapID_t mapID, ESceneType sceneType, TObjUID_t objUID, bool needSendToWorld)
{
	FUNC_BEGIN(SCENE_MOD);

	CMapBase* pMap = DMapDataMgrBase->findMap(mapID);
	if(NULL == pMap)
	{
		gxError("Can't find map data!MapID={0}", mapID);
		return NULL;
	}

	TSceneID_t sceneID = genSceneID(DMapServerBase->getServerID(), pMap->getMapType(), mapID);
	CMapSceneBase* pScene = NULL;
	switch(sceneType)
	{
	case SCENE_TYPE_NORMAL:             // 普通
		{
		}break;
	case SCENE_TYPE_PK_RISK:            // 副本
		{
											pScene = addNewScene(mapID, sceneType, false);
		}break;
	default:
		{
			gxError("Unknow scene type!!! sceneTypek = {0}", (uint32)sceneType);
		}break;
	}
	if(NULL == pScene)
	{
		return NULL;
	}
	pScene->setSceneID(sceneID);
	if(!add(pScene))
	{
		gxError("Can't add scene! {0}", pScene->toString());
		delDynamicScene(pScene);
		return NULL;
	}

	if(!pScene->init(pMap))
	{
		closeDynamicScene(sceneID, false);
		return NULL;
	}

	if(!pScene->load())
	{
		closeDynamicScene(sceneID, false);
		return NULL;
	}

	pScene->initRoleInfo(1024, GetConstant<TSceneGroupID_t>(OT_SCENE_ROLE_NUM));
	pScene->setOwnerObjUID(objUID);
	pScene->setIsNeedClose(false);

	gxInfo("Open dynamic scene!{0}", pScene->toString());

	if (needSendToWorld)
	{
		sendOpenDynamicToWorld(pScene);
	}
	if ( sceneType > SCENE_TYPE_INVALID && sceneType < SCENE_TYPE_NUMBER )
	{
		_dynamicSceneNum[sceneType] += 1;
	}
	statDynamicSceneNum();

	return pScene;

	FUNC_END(NULL);
}

void CSceneManagerBase::closeDynamicScene( TSceneID_t sceneID, bool needSendToWorld )
{
	FUNC_BEGIN(SCENE_MOD);

	if(needSendToWorld)
	{
		MWCloseScene closeScene;
		closeScene.sceneID = sceneID;
		closeScene.mapServerID = DMapServerBase->getServerID();
		SendToWorld(closeScene);
	}

	CMapSceneBase* pScene = findScene(sceneID);
	if(NULL == pScene)
	{
		gxError("Can't find scene!SceneID={0}", sceneID);
		return;
	}
	ESceneType sceneType = pScene->getSceneType();
	gxDebug("Close dynamic scene!!! sceneID = {0}, mapID = {1}", GXMISC::gxToString(sceneID), pScene->getMapID());
	pScene->unload();
//	remove(sceneID);
	delDynamicScene(pScene);

	if ( sceneType > SCENE_TYPE_INVALID && sceneType < SCENE_TYPE_NUMBER )
	{
		_dynamicSceneNum[sceneType] -= 1;
	}

	statDynamicSceneNum();

	FUNC_END(DRET_NULL);
}

void CSceneManagerBase::delDynamicScene( CMapSceneBase* pScene )
{
	FUNC_BEGIN(SCENE_MOD);

	switch(pScene->getSceneType())
	{
	case SCENE_TYPE_NORMAL:             // 普通
		{
		}break;
	case SCENE_TYPE_PK_RISK:           // 副本
		{
										   delScene(pScene->getSceneID());
		}break;
	default:
		{

		}break;
	}

	FUNC_END(DRET_NULL);
}

void CSceneManagerBase::statDynamicSceneNum()
{
	FUNC_BEGIN(SCENE_MOD);
	FUNC_END(DRET_NULL);
}

CSceneManagerBase* g_SceneManagerBase = NULL;
CSceneManagerBase::CSceneManagerBase()
{
	g_SceneManagerBase = this;
}

sint32 CSceneManagerBase::getDynamicMapNum() const
{
	sint32 count = 0;
	for (sint32 i = SCENE_TYPE_NORMAL+1; i < SCENE_TYPE_NUMBER; ++i){
		count = count + _dynamicSceneNum[i];
	}

	return count;
}

bool CSceneManagerBase::openSomeDynamicScene()
{
	gxAssert(false);
	return false;
}

void CSceneManagerBase::sendOpenDynamicToWorld(CMapSceneBase* pScene)
{
	MWOpenScene openScene;
	pScene->getSceneData(&openScene.sceneData);
	SendToWorld(openScene);
}

void CSceneManagerBase::sendCloseDynamicToWorld(TSceneID_t sceneID)
{
	MWCloseScene closeScene;
	closeScene.mapServerID = DMapServerBase->getServerID();
	closeScene.sceneID = sceneID;

	SendToWorld(closeScene);
}
