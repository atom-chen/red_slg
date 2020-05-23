#ifndef _SCENE_OBJECT_MANAGER_H_
#define _SCENE_OBJECT_MANAGER_H_

#include "game_util.h"
#include "object_manager.h"

class CMapSceneBase;
class CGameObject;

class CSceneObjectManager : public CObjectManager
{
public:
	typedef CObjectManager TBaseType;

public:
	CSceneObjectManager() {} 
	virtual ~CSceneObjectManager() {}

	virtual bool init(CMapSceneBase* pScene);
	virtual void update( GXMISC::TDiffTime_t diff );

	void setScene( CMapSceneBase* pScene )
	{
		_scene = pScene;
	}
	CMapSceneBase *getScene()
	{
		return _scene;
	}

private:
	CMapSceneBase* _scene;
};

#endif	// _SCENE_OBJECT_MANAGER_H_