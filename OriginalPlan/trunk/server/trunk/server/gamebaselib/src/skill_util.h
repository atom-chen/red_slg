#ifndef _SKILL_UTIL_H_
#define _SKILL_UTIL_H_

#include "core/string_common.h"
#include "core/carray.h"

#include "scan.h"
#include "packet_struct.h"
#include "game_struct.h"
#include "game_util.h"
#include "game_errno.h"
#include "attributes.h"

class CCharacterObject;

// 攻击点
class CAttackPos
{
public:
	CAttackPos()
	{
		cleanUp();
	}
	~CAttackPos()
	{
		cleanUp();
	}

	void cleanUp()
	{
		destObjUID = INVALID_OBJ_UID;
		skilTypeID = INVALID_SKILL_TYPE_ID;
	}

public:
	TObjUID_t destObjUID;
	TSkillTypeID_t skilTypeID;
	TAxisPos pos;

	DObjToString4Alias(CAttackPos,
		TObjUID_t, DestOjbUID, destObjUID,
		TSkillTypeID_t, SkillTypeID, skilTypeID,
		TAxisPos_t, X, pos.x,
		TAxisPos_t, Y, pos.y);
};

// 攻击效果
typedef GXMISC::CArray<CCharacterObject*, MAX_ATTACKOR_NUM> TImpactCharacterList;
typedef CArray1<TObjUID_t, MAX_ATTACKOR_NUM> TImpactObjUIDList;
class CAttackorList
{
public:
	CAttackorList()
	{
		cleanUp();
	}
	~CAttackorList(){}

public:
	void push(CCharacterObject* pObj);
	void push(TAttackorImpact* impact);
	void cleanUp();
	uint32 getImpactSize();
	uint32 getAttackObjSize();
	void getAttactorList(TImpactObjUIDList* objs);

public:
	void logImpact();

public:
	TPackAttackorList       impacts;            // 他人攻击效果
	TImpactCharacterList    characterList;      // 被攻击人列表
};
// 攻击目标
class CAttackTarget
{
public:
	CAttackTarget()
	{
		cleanUp();
	}
	~CAttackTarget()
	{
		cleanUp();
	}

public:
	void cleanUp();         // 清理
	bool single();          // 单体技能
	double getTotalDescHp(bool calcMe, TObjUID_t objUID);       // 获取总共减少的血量
	double getTotalAddHp(bool calcMe, TObjUID_t objUID);        // 获取总共增加的血量

public:
	CCharacterObject*   destObj;            // 单人攻击对象
	CAttackorList		attackorList;       // 多人攻击列表(包括单体攻击对象)
};

#endif