#ifndef _WORLD_LOGIN_ROLE_LIST_H_
#define _WORLD_LOGIN_ROLE_LIST_H_

#include <vector>

#include "core/carray.h"
#include "core/db_filed_parse.h"

#include "packet_struct.h"
#include "game_define.h"
#include "game_util.h"
#include "game_pos.h"
#include "game_misc.h"

#pragma pack(push, 1)

typedef struct _LoginRole
{
public:
	TRoleUID_t roleUID;					// 角色UID
	TObjUID_t objUID;					// 对象UID
	TRoleProtypeID_t protypeID;			// 原型ID
	TRoleName_t name;					// 名字
	TLevel_t level;						// 等级
	TSceneID_t sceneID;					// 场景
	TAxisPos pos;						// 位置
	GXMISC::CGameTime createTime;		// 创建时间
	GXMISC::CGameTime	logoutTime;		// 登出时间

public:
	static const GXMISC::TDbCol DbCols[11];

public:
	_LoginRole()
	{
		memset(this, 0, sizeof(*this));
		cleanUp();
	}

	void cleanUp()
	{
		roleUID = INVALID_ROLE_UID;
		level = INVALID_LEVEL;
		sceneID = INVALID_SCENE_ID;
		pos.cleanUp();
		createTime = GXMISC::INVALID_GAME_TIME;
		logoutTime = GXMISC::INVALID_GAME_TIME;
	}

	void getPackLoginRole(TPackLoginRole* packRole)
	{
		packRole->level = level;
		packRole->name = name;
		packRole->uid = roleUID;
		packRole->createTime = createTime;
		packRole->logoutTime=logoutTime;
	}

	TPackLoginRole toPackLoginRole()
	{
		TPackLoginRole packRole;
		getPackLoginRole(&packRole);
		return packRole;
	}

	void setParam(const char* name, TRoleUID_t roleUID, TObjUID_t objUID, uint8 sex, uint8 job,
		TLevel_t level, GXMISC::TGameTime_t createTime, TAxisPos& pos, TSceneID_t sceneID, uint8 gridNum, GXMISC::TGameTime_t logOutTime )
	{
		this->name = name;
		this->roleUID = roleUID;
		this->objUID = objUID;
		this->level = level;
		this->sceneID = sceneID;
		this->pos = pos;
		this->createTime = createTime;
		this->logoutTime = logOutTime;
	}

	bool isDynamicMap()
	{
		uint8 mapType = CGameMisc::GetMapType(sceneID);
		return !(mapType == SCENE_TYPE_NORMAL);
		return false;
	}

	TMapID_t getMapID()
	{
		return CGameMisc::GetMapID(sceneID);
	}

	TSceneID_t getSceneID()
	{
		return sceneID;
	}

	const std::string toString()
	{
		return GXMISC::gxToString("name = %s, uid = %" I64_FMT "u, objUID=%u, level = %u, create_time = %u,"
			"mapID=%u", name.toString().c_str(), roleUID, objUID, level, createTime.getGameTime(), getMapID());
	}
}TLoginRole;
typedef GXMISC::CArray<TLoginRole, MAX_ROLE_NUM> TLoginRoleArray;
typedef std::vector<TLoginRole> TLoginRoleVector;

class CWorldLoginRoleList 
{
public:
	CWorldLoginRoleList() {
		_currRoleUID = INVALID_ROLE_UID;
		_currObjUID = INVALID_OBJ_UID;
	}

	~CWorldLoginRoleList() {
	}

public:
	void genStrName();
	const char* toString();

	void addRole(TLoginRole* role);
	void getRoleList(TPackLoginRoleArray& roleList);
	bool selectRole(TRoleUID_t roleUID);
	void delRole(TRoleUID_t roleUID);
	bool isRole(TRoleUID_t roleUID);
	bool isMaxRoleNum();
	TObjUID_t getCurrentObjUID();
	TRoleUID_t getCurrentRoleUID();
	TRoleUID_t getLastLoginRoleUID();
	void clean();
	uint32 size();
	TLoginRole* getCurrentRole();
	TRoleUID_t getFirstRoleUID();
private:
	TLoginRoleVector _roleList;
	TRoleUID_t _currRoleUID;
	TObjUID_t _currObjUID;
	std::string _strName;
};

#pragma pack(pop)

#endif
