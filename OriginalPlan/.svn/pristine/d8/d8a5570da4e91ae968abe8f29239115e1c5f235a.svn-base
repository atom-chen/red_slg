#ifndef _SCENE_ROLE_MANAGER_H_
#define _SCENE_ROLE_MANAGER_H_

#include "scene_object_manager.h"

class CSceneRoleManager : public CSceneObjectManager
{
public:
	CSceneRoleManager(){}
	~CSceneRoleManager(){}

public:
	CRoleBase*  getRole(TObjUID_t uid);
	void	getAllRole( std::vector<CRoleBase*>& data );
};

#endif