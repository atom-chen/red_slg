#include "role_base.h"
#include "scene_role_manager.h"

void CSceneRoleManager::getAllRole( std::vector<CRoleBase*>& data )
{
	for ( Iterator itr = begin(); itr!=end(); ++itr )
	{
		CRoleBase* pRole = itr->second->toRoleBase();
		gxAssert(pRole);
		if ( pRole == NULL )
		{
			continue;
		}

		data.push_back(pRole);
	}
}

CRoleBase* CSceneRoleManager::getRole( TObjUID_t uid )
{
	return dynamic_cast<CRoleBase*>(findObj(uid));
}