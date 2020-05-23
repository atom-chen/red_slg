#ifndef _WORLD_USER_MGR_H_
#define _WORLD_USER_MGR_H_

#include <string>

#include "game_misc.h"
#include "world_user.h"
#include "game_util.h"

#include "core/obj_mem_fix_pool.h"
#include "core/multi_index.h"
#include "core/singleton.h"

// 世界角色管理
class CWorldUserMgr : public GXMISC::CHashMultiIndex4<CWorldUser, false, 
	INVALID_OBJ_UID, TRoleName_t::InvalidKey, INVALID_ROLE_UID, INVALID_ACCOUNT_ID>, 
	public GXMISC::CManualSingleton<CWorldUserMgr>
{
public:
	typedef GXMISC::CHashMultiIndex4<CWorldUser, false, INVALID_OBJ_UID, TRoleName_t::InvalidKey, INVALID_ROLE_UID, INVALID_ACCOUNT_ID> TBaseType;
	DSingletonImpl();
	DMultiIndexIterFunc(CWorldUser);

public:
	bool init(uint32 num);
	void update(GXMISC::TDiffTime_t diff);
	CWorldUser* addUser(TObjUID_t objUID, TServerID_t mapServerID, CWorldUserData* data);
	uint32 size();
	bool renameRoleName(TRoleUID_t roleUID, const std::string& name);

public:
	void delUserByObjUID(TObjUID_t objUID);
	void delUserByRoleName(const TRoleName_t& name);
	void delUserByRoleUID(TRoleUID_t roleUID);
	void delUserByAccountID(TAccountID_t accountID);
	void delUser(TObjUID_t objUID, TRoleUID_t roleUID, const TRoleName_t& name, TAccountID_t& accountID);

	CWorldUser* findUserByObjUID(TObjUID_t objUID);
	CWorldUser* findUserByRoleName(const TRoleName_t& name);
	CWorldUser* findUserByRoleUID(TRoleUID_t roleUID);
	CWorldUser* findUserByAccountID(TAccountID_t accountID);

	bool isExistByObjUID(TObjUID_t objUID);
	bool isExistByRoleName(const TRoleName_t& roleName);
	bool isExistByRoleUID(TRoleUID_t roleUID);
	bool isExistByAccountID(TAccountID_t accountID);

public:
	GXMISC::CFixObjPool<CWorldUser> _objPool;
};

#define DWorldUserMgr CWorldUserMgr::GetInstance()

#endif
