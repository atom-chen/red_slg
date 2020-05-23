#ifndef _USER_STRUCT_H_
#define _USER_STRUCT_H_

#include "game_util.h"
#include "game_binary_string.h"
#include "game_pos.h"
#include "game_struct.h"

#include "core/db_struct_base.h"


#pragma pack(push, 1)
enum EUserFlag
{
	USER_FLAG_START_NUM = 0,
	// 需要保存到数据库
	USER_FLAG_MAX_NUMBER = 255,
};

typedef GXMISC::CFixBitSet<USER_FLAG_MAX_NUMBER>	TUserBitFlag;

struct TUserFlag : public GXMISC::TDBStructBase
{
	TUserBitFlag _flag;
	TUserFlag()
	{
		cleanUp();
	}

	bool	operator[]( EUserFlag index ) const
	{
		if ( checkInvalid(index) )
		{
			return false;
		}
		return getFlag(index);
	}

	void				setFlag( EUserFlag index, bool isTrue = true )
	{
		if ( checkInvalid(index) )
		{
			return ;
		}
		if ( isTrue )
		{
			_flag.set((sint32)index);
		}
		else
		{
			_flag.clear((sint32)index);
		}
	}

	bool				getFlag( EUserFlag index ) const
	{
		if ( checkInvalid(index) )
		{
			return false;
		}
		return _flag[(sint32)index];
	}

	const TUserBitFlag& procFlag()
	{
		for ( sint32 index=(sint32)USER_FLAG_START_NUM; index<(sint32)USER_FLAG_MAX_NUMBER; ++index )
		{
			_flag.clear(index);
		}
		return _flag;
	}

	void cleanUp()
	{
		_flag.clearAll();
	}

	TUserFlag& operator = ( const TUserFlag& ls )
	{
		memcpy(this, &ls, sizeof(ls));
		return *this;
	}

	bool checkInvalid( EUserFlag index ) const
	{
		if ( index < 0 || index > USER_FLAG_MAX_NUMBER )
		{
			gxError("Invalid index!!! index = {0}", (uint32)index);
			gxAssert(false);
			return true;
		}
		return false;
	}
};

/// 玩家在世界服务器上的数据
typedef struct UserDbData
{
	TRoleUID_t					roleUID;				///< 角色UID
	GXMISC::TGameTime_t			closeServerTime;		///< 服务器关闭时间
	TUserFlag					userFlag;				///< 玩家的标记是否有变化

	UserDbData()
	{
		cleanUp();
	}

	void	cleanUp()
	{
		roleUID = INVALID_ROLE_UID;
		closeServerTime = GXMISC::INVALID_GAME_TIME;
		userFlag.cleanUp();
	}
}TUserDbData;

// 世界服务器需要角色的一些基本数据
// 由游戏服务器从数据库加载, 并发送给世界服务器
class CWorldUserData
{
public:
	CWorldUserData()
	{
		offOverDay = false;
		level = INVALID_LEVEL;
		sex = INVALID_SEX;
		job = INVALID_JOB;
		accountID = INVALID_ACCOUNT_ID;
		roleUID = INVALID_ROLE_UID;
		roleName = "";
		logoutTime = GXMISC::INVALID_GAME_TIME;
		newUser = false;
		sceneID = INVALID_SCENE_ID;
	}

public:
	bool			offOverDay;				// 是否离线过天
	TLevel_t		level;					// 等级
	TSex_t			sex;					// 性别
	TJob_t			job;					// 职业
	TAccountID_t    accountID;				// 账号
	TRoleUID_t      roleUID;				// 角色UID
	TRoleName_t     roleName;				// 角色名字
	GXMISC::TGameTime_t		logoutTime;		// 下线时间
	bool			newUser;				// 是否为新角色
	TSceneID_t		sceneID;				// 场景ID

public:
	bool isValid()
	{
		return level != INVALID_LEVEL && sex != INVALID_SEX && job != INVALID_JOB &&
			accountID != INVALID_ACCOUNT_ID && roleUID != INVALID_ROLE_UID && !roleName.empty() && logoutTime != GXMISC::INVALID_GAME_TIME;
	}
public:
	DObjToString3Alias(CWorldUserData, TAccountID_t, DAccountID, accountID, TRoleUID_t,
		DRoleUID, roleUID, TRoleName_t, DRoleName, roleName.toString().c_str());
};

// 世界服务器向地图服务器更新的User数据
typedef struct W2MUserDataUpdate
{
	TGmPower_t gmPower;					// GM等级
}TW2MUserDataUpdate;
// 地图服务器向世界服务器更新的Role数据
typedef struct M2WRoleDataUpdate
{
	TLevel_t		level;			        // 等级
	TServerID_t  mapServerID;				// 地图服务器ID
	TSceneID_t      sceneID;                // 场景ID
	TAxisPos        pos;                    // 坐标
}TM2WRoleDataUpdate;
// 切地图的数据
typedef struct _ChangeMapSaveData
{
	TObjUID_t petObjUID;                // 当前出战宠物
	TOwnerBuffAry petBuffAry;           // 当前宠物Buffer

	_ChangeMapSaveData()
	{
		cleanUp();
	}

	void cleanUp()
	{
		petObjUID = INVALID_OBJ_UID;
		petBuffAry.clear();
	}
}TChangeMapSaveData;

// 切线的数据
typedef struct ChangeLineTempData
{
public:
	// 切地图需要保存的数据, 此数据同时在角色身上存储了一份
	TChangeMapSaveData saveData;
	// Buff数据
	TOwnerBuffAry buffAry;
	// 组队数据
	// 切线时的源坐标
	TAxisPos	pos;
	TMapID_t	mapID;
	// PK类型
	uint8		pkType;
	// 阵营
	TCampID_t	camp;

public:
	ChangeLineTempData()
	{
		cleanUp();
	}

	void cleanUp()
	{
		memset(this, 0, sizeof(*this));
		pkType = 0;
		buffAry.clear();
		pos = INVALID_AXIS_POS_T;
		mapID = INVALID_MAP_ID;
		camp = INVALID_CAMP_ID;
	}
}TChangeLineTempData;

/// 玩家管理信息
typedef struct RoleManageInfo
{
	TGmPower_t		gmPower;		// GM权限
	uint8			limitChat;		// 限制聊天
	RoleManageInfo()
	{
		cleanUp();
	}

	void cleanUp()
	{
		gmPower = INVALID_GM_POWER;
		limitChat = 0;
	}
}TRoleManageInfo;

#pragma pack(pop)

#endif