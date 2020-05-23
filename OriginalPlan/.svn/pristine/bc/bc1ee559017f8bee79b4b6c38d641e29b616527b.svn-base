#include "map_server_task.h"
#include "role_manager.h"
#include "map_server_util.h"
#include "scene_manager.h"
#include "role.h"
#include "map_server_instance.h"
#include "map_server.h"
#include "map_data_tbl.h"

void COpenDynamicScene::run()
{
	CRole* pRole = DRoleManager.findByObjUID(_objUID);
	if(NULL == pRole)
	{
		return;
	}
	
	if(!DMapServer->canOpenDynamicMap())
	{
		// 无法开启动态场景, 直接开启远程场景
		pRole->getChangeLineWait()->cleanUp();
		pRole->openRemoteDynamicMap(_mapID);
		return;
	}

	CMapSceneBase* pScene = DSceneMgr.openDynamicScene(_mapID, _sceneType, _objUID, true);
	if(NULL != pScene)
	{
		pRole->onOpenDynamicMap(pScene->getSceneID(), &_pos, DMapServer->getServerConfig()->getMapServerID(), RC_SUCCESS);
	}
	else
	{
		pRole->onOpenDynamicMap(INVALID_SCENE_ID, &_pos, DMapServer->getServerConfig()->getMapServerID(), RC_CANT_ENTER_RISK_MAP);
	}
}

COpenDynamicScene::COpenDynamicScene()
{
	setExcuteNumPerFrame(1);
	cleanUp();
}

COpenDynamicScene::~COpenDynamicScene()
{
}

void COpenDynamicScene::cleanUp()
{
	_objUID = INVALID_OBJ_UID;
	_mapID = INVALID_MAP_ID;
	_sceneType = SCENE_TYPE_INVALID;
}

void COpenDynamicScene::setParam(TObjUID_t objUID, TMapID_t mapID, const TAxisPos* pos, ESceneType sceneType)
{
	_objUID = objUID;
	_mapID = mapID;
	_pos = *pos;
	_sceneType = sceneType;
}

sint32 COpenDynamicScene::getType()
{
	return SERVER_TASK_TYPE_OPEN_SCENE;
}