#ifndef _SCENE_ROLE_MANAGER_H_
#define _SCENE_ROLE_MANAGER_H_

#include "scene_obj_manager.h"

class CRole;
class CSceneRoleManager : public CSceneObjectManager
{
public:
	CSceneRoleManager(){}
	~CSceneRoleManager(){}

public:
	CRole*  getRole(TObjUID_t uid);
	void	getAllRole( std::vector<CRole*>& data );
};

#endif