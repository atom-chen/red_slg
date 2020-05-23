#include "scene_manager.h"

bool CSceneManager::init( CMapServerConfig* config )
{
	if( false == _objPool.init(config->getScenePoolNum()) )
	{
		gxError("Can't init normal scene pool!SceneNum={0}", config->getScenePoolNum());
		return false;
	}

	return TBaseType::initAllMap();
}

CSceneManager::TBaseType::ValueType CSceneManager::addNewScene(TSceneID_t sceneID, uint8 mapType, bool addFlag)
{
	CMapScene* pScene = NULL;

	if(mapType == SCENE_TYPE_NORMAL || mapType == SCENE_TYPE_PK_RISK)
	{
		pScene = _objPool.newObj();
	}
	else
	{
		gxError("Add new scene failed!SceneID={0}", sceneID);
		gxAssert(false);
		return NULL;
	}

	if(NULL == pScene)
	{
		gxError("Can't new CMapScene!SceneID={0}", sceneID);
		return NULL;
	}

	if (addFlag)
	{
		pScene->setSceneID(sceneID);
		if (false == add(pScene))
		{
			gxError("Can't add scene! {0}", pScene->toString());
			_objPool.deleteObj(pScene);
			return NULL;
		}
	}

	return pScene;
}

void CSceneManager::delScene( CMapScene::KeyType key )
{
	gxAssert(isSceneExist(key));
	CMapScene* pScene = dynamic_cast<CMapScene*>(remove(key));
	if(NULL != pScene)
	{
		if (pScene->getSceneType() == SCENE_TYPE_NORMAL || pScene->getSceneType() == SCENE_TYPE_PK_RISK)
		{
			_objPool.deleteObj(pScene);
		}
		else
		{
			gxError("Scene type is invalid!SceneType={0}", (uint32)pScene->getSceneType());
		}
	}
	else
	{
		gxError("Can't find scene! SceneID={0}", key);
	}
}

CMapScene* CSceneManager::findScene( TSceneID_t sceneID )
{
	return dynamic_cast<CMapScene*>(CSceneManagerBase::findScene(sceneID));
}
