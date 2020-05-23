#ifndef _ATTR_BACKUP_STRUCT_H_
#define _ATTR_BACKUP_STRUCT_H_

#include "packet_cm_base.h"
#include "game_util.h"
#include "game_define.h"

typedef struct AttrBackupBase
{
public:
	void setObjUID(TObjUID_t uid)
	{
		data.objUID = uid;
	}

	MCSyncRoleData* getSyncData()
	{
		return &data;
	}

	// 初始化
	void init()
	{
		data.reset();
	}

	bool isDirty()
	{
		return data.isDirty();
	}

	MCSyncRoleData data;
}TAttrBackupBase;

/// 角色同步属性
typedef struct RoleAttrBackup : public AttrBackupBase
{
public:
	RoleAttrBackup(){
		DCleanSubStruct(AttrBackupBase);
	}

	// @member
public:
	TAttrVal_t values[255];

public:
	TAttrVal_t getValue(uint8 type)
	{
		return values[type];
	}
	void setValue(uint8 type, TAttrVal_t val)
	{
		values[type] = val;
	}
	bool isEqual(uint8 type, TAttrVal_t val)
	{
		return values[type] == val;
	}
	
	// @member
// public:
// 	TLevel_t level;								///< 等级
// 	TExp_t exp;									///< 经验
// 	TMoveSpeed_t moveSpeed;						///< 移动速度
// 	TGold_t gameMoney;							///< 金钱
// 	TStrength_t strength;						///< 体力值
// 	TStrength_t	maxStrength;					///< 最大体力值
// 	TRmb_t rmb;									///< 元宝
// 	TLevel_t vipLevel;							///< vip等级
// 	TExp_t   vipExp;							///< vip经验值
// 	TExp_t maxExp;								///< 经验最大值
//
//public:
// 	TLevel_t getLevel() const { return level; } 
// 	void setLevel(TLevel_t val) { level = val; data.push(ATTR_LEVEL, val);} 
// 	TExp_t getExp() const { return exp; } 
// 	void setExp(TExp_t val) { exp = val; data.push(ATTR_EXP, val); } 
// 	TMoveSpeed_t getMoveSpeed() const { return moveSpeed; } 
// 	void setMoveSpeed(TMoveSpeed_t val) { moveSpeed = val; data.push(ATTR_MOVE_SPEED, val); } 
// 	TGold_t getGameMoney() const { return gameMoney; } 
// 	void setGameMoney(TGold_t val) { gameMoney = val; data.push(ATTR_MONEY, val); } 
// 	TStrength_t getStrength() const { return strength; } 
// 	void setStrength(TStrength_t val) { strength = val; data.push(ATTR_CURR_STRENGTH, val); } 
// 	TStrength_t getMaxStrength() const { return maxStrength; } 
// 	void setMaxStrength(TStrength_t val) { maxStrength = val; data.push(ATTR_MAX_STRENGTH, val); } 
// 	TRmb_t getRmb() const { return rmb; } 
// 	void setRmb(TRmb_t val) { rmb = val; data.push(ATTR_RMB, val); } 
// 	TLevel_t getVipLevel() const{ return vipLevel; } 
// 	void setVipLevel(TLevel_t val){ vipLevel = val; data.push(ATTR_VIP_LEVEL, val); } 
// 	TExp_t getVipExp() const{ return vipExp; } 
// 	void setVipExp(TExp_t val){ vipExp = val; data.push(ATTR_VIP_EXP, val); }	 
// 	TExp_t getMaxExp() const { return maxExp; }
// 	void setMaxExp(TExp_t val) { maxExp = val; data.push(ATTR_MAX_EXP, val); } 

}TRoleAttrBackup;		///< 角色同步属性

typedef struct _MonsterAttrBackup : public TAttrBackupBase
{
	TMoveSpeed_t moveSpeed;             // 移动速度
	THp_t hp;							// 血量

	_MonsterAttrBackup(){}

	void setMoveSpeed(TMoveSpeed_t val)
	{
		moveSpeed = val;
		data.push(ATTR_MOVE_SPEED, val);
	}

	void setHp(THp_t val)
	{
		hp = val;
		data.push(ATTR_CUR_HP, val);
	}

public:
	void cleanUp()
	{
		data.reset();
		moveSpeed = 0;
		hp = 0;
	}
}TMonsterAttrBackup;

#endif	// _ATTR_BACKUP_STRUCT_H_