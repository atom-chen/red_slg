#include "scene_object_manager.h"
#include "object.h"
#include "map_scene_base.h"

void CSceneObjectManager::update( GXMISC::TDiffTime_t diff )
{
	TObjectVector delAry;
	// ¸üÐÂ
	for(TBaseType::Iterator iter = begin(); iter != end(); ++iter)
	{
		CGameObject* pObj = iter->second;
		pObj->update(diff);
		if(pObj->isCanUpdateLeaveScene())
		{
			delAry.push_back(pObj);
		}
	}

	for(TObjectVector::iterator iter = delAry.begin(); iter != delAry.end(); ++iter)
	{
		CGameObject* pObj = *iter;
		gxAssert(_scene == pObj->getScene());
		_scene->leave(pObj, true);
	}
}

bool CSceneObjectManager::init( CMapSceneBase* pScene )
{
	_scene = pScene;
	return true;
}