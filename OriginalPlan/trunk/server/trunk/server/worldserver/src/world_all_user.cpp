#include "core/db_single_conn_manager.h"

#include "world_all_user.h"
#include "world_sql_manager.h"

CWorldUserSimpleData* CWorldAllUserMgr::addUser( TLoginRole* role, bool loadFromDbFlag )
{
	if(!loadFromDbFlag)
	{
		gxInfo("Add user!ObjUID={0},RoleUID={1},RoleName={2}", role->objUID, role->roleUID, role->name.toString());
	}
	CWorldUserSimpleData* usr = findUser(role->objUID);
	if(NULL != usr)
	{
		usr->update(role);
	}
	else
	{
		usr = _objPool.newObj();
		if (NULL == usr) 
		{
			gxError("Can't new CWorldUserSimpleData!ObjUID={0},RoleUID={1},RoleName={2}", role->objUID,role->roleUID,role->name.toString());
			return NULL;
		}

		usr->update(role);

		if (false == _users.add(usr))
		{
			gxError("Can't new CWorldUserSimpleData!ObjUID={0},RoleUID={1},RoleName={2}", role->objUID,role->roleUID,role->name.toString());
			_objPool.deleteObj(usr);
			return NULL;
		}
	}

	return usr;
}

bool CWorldAllUserMgr::addUser( CWorldUserSimpleData* pUser )
{
	return _users.add(pUser);
}

void CWorldAllUserMgr::updateUser( TObjUID_t objUID, TLevel_t level )
{
	CWorldUserSimpleData* usr = findUser(objUID);
	if(NULL != usr)
	{
		usr->update(level);
	}
	else
	{
		gxError("Can't find CWorldUserSimpleData!ObjUID={0}", objUID);
	}
}

void CWorldAllUserMgr::delUser( TObjUID_t objUID )
{
	gxInfo("Remove world all user! OjbUID = {0}", objUID);
	CWorldUserSimpleData* usr = _users.remove(objUID);
	if (usr != NULL) {
		gxInfo("Remove world all user! {0}", usr->toString());
		DSqlConnectionMgr.deleteUserData(usr->roleUID);
		_objPool.deleteObj(usr);
	} else {
		gxWarning("Can't find world all user! OjbUID = {0}", objUID);
	}
}

void CWorldAllUserMgr::delUser( TRoleUID_t roleUID )
{
	gxInfo("Remove world all user! RoleUID = {0}", roleUID);
	CWorldUserSimpleData* usr = _users.remove2(roleUID);
	if (usr != NULL) {
		gxInfo("Remove world all user! {0}", usr->toString());
		DSqlConnectionMgr.deleteUserData(roleUID);
		_objPool.deleteObj(usr);
	} else {
		gxWarning("Can't find world all user! RoleUID = {0}", roleUID);
	}
}

CWorldUserSimpleData* CWorldAllUserMgr::findUser( TObjUID_t objUID )
{
	return _users.find(objUID);
}

CWorldUserSimpleData* CWorldAllUserMgr::findUser( TRoleUID_t roleUID )
{
	return _users.find2(roleUID);
}

CWorldUserSimpleData* CWorldAllUserMgr::findUser( const TRoleName_t& name )
{
	return  _users.find3(name);
}

uint32 CWorldAllUserMgr::size()
{
	return _objPool.getCount();
}

bool CWorldAllUserMgr::init( uint32 maxNum /*= MAX_ALL_USER_NUM*/ )
{
	return _objPool.init(maxNum);
}

CWorldAllUserMgr::CWorldAllUserMgr()
{

}

CWorldAllUserMgr::~CWorldAllUserMgr()
{

}

bool CWorldAllUserMgr::loadAll()
{
	return DSqlConnectionMgr.loadAllUser();
}

TRoleUID_t CWorldAllUserMgr::getRoleUID( TObjUID_t objUID )
{
	CWorldUserSimpleData* allUser = findUser(objUID);
	if (allUser != NULL)
	{
		return allUser->roleUID;
	}
	return INVALID_ROLE_UID;
}

TObjUID_t CWorldAllUserMgr::getObjUID( TRoleUID_t roleUID )
{
	CWorldUserSimpleData* allUser = findUser(roleUID);
	if (allUser != NULL)
	{
		return allUser->objUID;
	}
	return INVALID_OBJ_UID;
}

CWorldUserSimpleData* CWorldAllUserMgr::remove( TObjUID_t objUID )
{
	return _users.remove(objUID);
}

CWorldUserSimpleData* CWorldAllUserMgr::remove( TRoleUID_t objUID )
{
	return _users.remove2(objUID);
}

CWorldUserSimpleData* CWorldAllUserMgr::remove( const TRoleName_t& name )
{
	return _users.remove3(name);
}

std::tr1::hash<TRoleName_t> CWorldUserSimpleData::roleNameDef;
