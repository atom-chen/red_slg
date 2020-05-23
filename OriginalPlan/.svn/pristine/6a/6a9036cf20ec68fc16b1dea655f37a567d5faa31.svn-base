#include "core/debug.h"
#include "core/game_exception.h"

#include "world_user.h"
#include "game_util.h"
#include "world_user_mgr.h"
#include "module_def.h"
#include "world_all_user.h"

CWorldUser* CWorldUserMgr::addUser(TObjUID_t objUID, TServerID_t mapServerID, CWorldUserData* data) 
{
// 	if (!data.isValid())	@TODO
// 	{
// 		gxError("Add user data is invalid!{0} ", data.toString());
// 		return NULL;
// 	}

	gxInfo("Add user!{0}, ObjUID={1}", data->toString(), objUID);
	CWorldUser* usr = _objPool.newObj();
	if (NULL == usr) 
	{
		gxError("Can't new CWorldUser!{0}, ObjUID={1}", data->toString(), objUID);
		return NULL;
	}

	usr->setObjUID(objUID);
	usr->setMapServerID(mapServerID);
	usr->setUserData(data);

	if (false == add(usr)) 
	{
		gxError("Can't add CWorldUser!{0}, ObjUID={1}", data->toString(), objUID);
		_objPool.deleteObj(usr);
		return NULL;
	}
	//	usr->online();
	return usr;
}

void CWorldUserMgr::delUserByObjUID(TObjUID_t objUID)
{
	if(INVALID_OBJ_UID == objUID)
	{
		return;
	}
	gxInfo("Remove world user! OjbUID = {0}", objUID);

	CWorldUser* usr = remove(objUID);
	if (usr != NULL) 
	{
		usr->offLine();
		gxInfo("Remove world user! {0}", usr->toString());
		_objPool.deleteObj(usr);
	}
	else
	{
		gxWarning("Can't find user! OjbUID = {0}", objUID);
	}
}

void CWorldUserMgr::delUserByRoleUID(TRoleUID_t roleUID) 
{
	if(INVALID_ROLE_UID == roleUID)
	{
		return;
	}

	gxInfo("Remove world user! RoleUID = {0}", roleUID);
	CWorldUser* usr = remove3(roleUID);
	gxAssert(usr != NULL);
	if (usr != NULL) {
		usr->offLine();
		gxInfo("Remove world user! {0}", usr->toString());
		_objPool.deleteObj(usr);
	} else {
		gxWarning("Can't find user! RoleUID = {0}", roleUID);
	}
}

void CWorldUserMgr::delUserByAccountID( TAccountID_t accountID )
{
	if(INVALID_ACCOUNT_ID == accountID)
	{
		return;
	}

	gxInfo("Remove world user! AccountID = {0}", accountID);
	CWorldUser* usr = remove4(accountID);
	gxAssert(usr != NULL);
	if (usr != NULL) {
		usr->offLine();
		gxInfo("Remove world user! {0}", usr->toString());
		_objPool.deleteObj(usr);
	} else {
		gxWarning("Can't find user! AccountID = {0}", accountID);
	}
}

void CWorldUserMgr::delUserByRoleName( const TRoleName_t& name )
{
	if(INVALID_ROLE_NAME == name)
	{
		return;
	}

	gxInfo("Remove world user! RoleUID = {0}", name.toString());
	CWorldUser* usr = remove2(INVALID_ROLE_NAME);
	gxAssert(usr != NULL);
	if (usr != NULL) {
		usr->offLine();
		gxInfo("Remove world user! {0}", usr->toString());
		_objPool.deleteObj(usr);
	} else {
		gxWarning("Can't find user! RoleName={0}", name.toString());
	}
}

void CWorldUserMgr::delUser( TObjUID_t objUID, TRoleUID_t roleUID, const TRoleName_t& name, TAccountID_t& accountID )
{
	if(isExistByObjUID(objUID))
	{
		delUserByObjUID(objUID);
	}

	if(isExistByRoleUID(roleUID))
	{
		delUserByRoleUID(roleUID);
	}

	if(isExistByRoleName(name))
	{
		delUserByRoleName(name);
	}

	if(isExistByAccountID(accountID))
	{
		delUserByAccountID(accountID);
	}
}

CWorldUser* CWorldUserMgr::findUserByObjUID(TObjUID_t objUID)
{
	return find(objUID);
}

CWorldUser* CWorldUserMgr::findUserByRoleName(const TRoleName_t& name) 
{
	return find2(name);
}

CWorldUser* CWorldUserMgr::findUserByRoleUID(TRoleUID_t roleUID) 
{
	return find3(roleUID);
}

CWorldUser* CWorldUserMgr::findUserByAccountID( TAccountID_t accountID )
{
	return find4(accountID);
}

bool CWorldUserMgr::init(uint32 num)
{
	return _objPool.init(num);
}

bool CWorldUserMgr::isExistByObjUID(TObjUID_t objUID)
{
	return findUserByObjUID(objUID) != NULL;
}

bool CWorldUserMgr::isExistByRoleUID(TRoleUID_t roleUID) 
{
	return findUserByRoleUID(roleUID) != NULL;
}

bool CWorldUserMgr::isExistByRoleName(const TRoleName_t& roleName) 
{
	return findUserByRoleName((char*)roleName.toString().c_str()) != NULL;
}

bool CWorldUserMgr::isExistByAccountID( TAccountID_t accountID )
{
	return findUserByAccountID(accountID) != NULL;
}

uint32 CWorldUserMgr::size()
{
	return TBaseType::size();
}

void CWorldUserMgr::update( GXMISC::TDiffTime_t diff )
{
	for(TBaseType::Iterator iter = begin(); iter != end(); ++iter)
	{
		CWorldUser* pUser = iter->second;
		if(NULL == pUser)
		{
			continue;
		}

		pUser->update(diff);
	}
}

bool CWorldUserMgr::renameRoleName( TRoleUID_t roleUID, const std::string& name )
{
	FUNC_BEGIN(ROLE_MOD);

	CWorldUserSimpleData* pSimpleUser = DWorldAllUserMgr.findUser(name);
	if(NULL != pSimpleUser)
	{
		gxError("Can't rename role name, role name repeat!RoleUID={0},Name={1}", roleUID, name);
		return false;
	}

	CWorldUser* pUser = findUserByRoleName(name);
	if(NULL != pUser)
	{
		gxError("Can't rename role name, role name repeat!RoleUID={0},Name={1}", roleUID, name);
		return false;
	}


	pSimpleUser = DWorldAllUserMgr.findUser(roleUID);
	DWorldAllUserMgr.remove(roleUID);
	pSimpleUser->roleName = name;
	if(!DWorldAllUserMgr.addUser(pSimpleUser))
	{
		gxError("Can't rename role name, role name repeat!RoleUID={0},Name={1}", roleUID, name);
		return false;
	}

	pUser = findUserByRoleUID(roleUID);
	remove(pUser->getObjUID());
	pUser->setName(name);
	if(!add(pUser))
	{
		gxError("Can't rename role name, role name repeat!RoleUID={0},Name={1}", roleUID, name);
		return false;
	}

	return true;

	FUNC_END(false);
}
