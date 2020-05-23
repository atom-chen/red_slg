#ifndef _WORLD_ALL_USER_H_
#define _WORLD_ALL_USER_H_

#include "game_misc.h"
#include "game_util.h"
#include "world_login_role_list.h"

#include "core/multi_index.h"
#include "core/string_common.h"
#include "core/obj_mem_fix_pool.h"

// 玩家简单数据, 包括离线玩家
class CWorldUserSimpleData
{
public:
	CWorldUserSimpleData()
	{
		objUID = INVALID_OBJ_UID;
		roleUID = INVALID_ROLE_UID;
		roleName = "";
		level = INVALID_LEVEL;
	}

	void update(TLoginRole* role)
	{
		this->objUID = role->objUID;
		this->roleUID = role->roleUID;
		this->roleName = role->name;
		this->level = role->level;
		genStrName();
	}

	// 更新离线玩家数据
	void update(TLevel_t level)
	{
		this->level = level;
	}

public:
	TObjUID_t objUID;
	TRoleUID_t roleUID;
	TRoleName_t roleName;
	TLevel_t level;

	DFastObjToString3Alias(CWorldUserSimpleData, TObjUID_t, ObjUID, objUID,
		TRoleUID_t, RoleUID, roleUID, TRoleName_t, RoleName, roleName.toString().c_str());
	DMultiIndexImpl1(TObjUID_t, objUID, INVALID_OBJ_UID);
	DMultiIndexImpl2(TRoleUID_t, roleUID, INVALID_ROLE_UID);
	DMultiIndexImpl3(TRoleName_t, roleName, '\0');

	static std::tr1::hash<TRoleName_t> roleNameDef;
};

// 玩家管理器
class CWorldAllUserMgr : public GXMISC::CManualSingleton<CWorldAllUserMgr>
{
	DSingletonImpl();

public:
	CWorldAllUserMgr();
	~CWorldAllUserMgr();

public:
	bool init(uint32 maxNum = MAX_ALL_USER_NUM);
	bool loadAll();
	CWorldUserSimpleData* addUser(TLoginRole* role, bool loadFromDbFlag = true);
	bool addUser(CWorldUserSimpleData* pUser);
	void updateUser(TObjUID_t objUID, TLevel_t level);
	void delUser(TObjUID_t objUID);
	void delUser(TRoleUID_t roleUID);

	CWorldUserSimpleData* remove(TObjUID_t objUID);
	CWorldUserSimpleData* remove(TRoleUID_t objUID);
	CWorldUserSimpleData* remove(const TRoleName_t& name);

	CWorldUserSimpleData* findUser(TObjUID_t objUID);
	CWorldUserSimpleData* findUser(TRoleUID_t roleUID);
	CWorldUserSimpleData* findUser(const TRoleName_t& name);
	TRoleUID_t   getRoleUID(const TObjUID_t objUID);
	TObjUID_t    getObjUID(const TRoleUID_t roleUID);
	uint32 size();

public:
	GXMISC::CFixObjPool<CWorldUserSimpleData> _objPool;			// 对象池
	GXMISC::CHashMultiIndex3<CWorldUserSimpleData, false, INVALID_OBJ_UID, INVALID_ROLE_UID, TRoleName_t::InvalidKey> _users;		// 所有玩家
};

#define DWorldAllUserMgr CWorldAllUserMgr::GetInstance()

#endif