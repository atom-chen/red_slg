#ifndef _OBJ_UTIL_H_
#define _OBJ_UTIL_H_

#include "game_util.h"
#include "game_pos.h"
#include "game_struct.h"

typedef struct _ObjInit
{
	TAxisPos axisPos;		// 位置
	TDir_t dir;				// 方向
	EObjType type;			// 对象类型
	TObjUID_t objUID;		// 对象UID
	TObjGUID_t objGUID;		// 对象GUID
	TMapID_t mapID;			// 地图ID

	_ObjInit( void )
	{
		cleanUp();
	}

	virtual void cleanUp( )
	{
		axisPos.cleanUp();
		dir = INVALID_DIR;
		type = INVALID_OBJ_TYPE;
		objGUID = INVALID_OBJ_GUID;
		objUID = INVALID_OBJ_UID;
	}
}TObjInit;

class CBufferManager;

typedef struct _CharacterInit : public TObjInit
{
	_CharacterInit()
	{
		job = INVALID_JOB;
		level = 1;
		mp = 0;
		hp = 0;
		exp = 0;
		moveSpeed = INVALID_MOVE_SPEED;
		die = false;
		commSkillID = INVALID_SKILL_TYPE_ID;
		commSkillLevel = INVALID_SKILL_LEVEL;
	}
	bool die;						// 是否死亡
	TJob_t job;						// 职业
	TLevel_t level;					// 等级
	TMp_t mp;						// 魔量
	THp_t hp;						// 血量
	TExp_t exp;						// 经验
	TMoveSpeed_t moveSpeed;			// 移动速度
	TSkillTypeID_t commSkillID;		// 普通技能ID
	TSkillLevel_t commSkillLevel;   // 普通技能等级
	CBufferManager* bufferManager;	// Buffer管理器
}TCharacterInit;

#endif	// _OBJ_UTIL_H_