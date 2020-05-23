#ifndef _CHAR_SKILL_CORE_H_
#define _CHAR_SKILL_CORE_H_

#include "packet_struct.h"
#include "scan.h"
#include "game_struct.h"
#include "game_util.h"
#include "string_common.h"
#include "game_errno.h"
#include "carray.h"
#include "attributes.h"
#include "module_def.h"
#include "skill_util.h"
#include "object_util.h"

class CSkillLogicBase;

/**
* 角色技能
* 1. 技能列表
* 2. 技能升级
* 3. 战斗技能
*/
class CCharSkillCore
{
public:
	CCharSkillCore();
	~CCharSkillCore(){}

public:
	void	cleanUp();
	bool	init(const TCharacterInit* inits);
	bool	update(GXMISC::TDiffTime_t diff);
	bool	updateOutBlock(GXMISC::TDiffTime_t diff);

public:
	// 设置对象
	void setCharacter(CCharacterObject* character);

	// 战斗技能
public:
	// 使用技能
	EGameRetCode use(TObjUID_t destObjUID, TSkillTypeID_t skillTypeID, TAxisPos_t x, TAxisPos_t y);
	// 获取被攻击者
	void getAttackors(TPackAttackorList* attackors);
	// 在使用技能后事件
	void onAfterUse();
	// 获取当前使用的技能效果掉血ID
	uint32	getSN();
	// 获取当前使用的技能ID
	TSkillTypeID_t getSkillID();
	// 获取当前使用的技能对象
	CSkillLogicBase* getSkillLogicBase()const;
	// 获取普通技能
	TOwnSkill* getCommonSkill() const;

	// 技能和心法
public:
	// 获取技能等级
	virtual TSkillLevel_t getSkillLevel(TSkillTypeID_t skillID);
	// 得到自身技能列表
	virtual void getSkillList(TOwnSkillVec* skills) {};
	// 设置普通技能
	void setCommSkillID(TSkillTypeID_t skillID, TSkillLevel_t level);
	// 获取普通技能
	TSkillTypeID_t getCommSkillID();
	// 获取普通技能攻击距离
	TRange_t getCommSkillAttackDis();

protected:
	EGameRetCode	onBeforeUse();
	void            doImpact();
	void            doBroad();

protected:
	GXMISC::TDiffTime_t	getDelayTime();

private:
	void clean();

private:
	// 攻击点
	CAttackPos          _attckMsg;
	// 攻击对象
	CAttackTarget       _attackTarget;
	// 延迟显示技能效果
	GXMISC::TDiffTime_t	_delayTime;
	// 唯一标识
	uint32				_SN;
	// 技能逻辑
	CSkillLogicBase*    _skillLogic;
	// 普通技能
	TOwnSkill			_commonSkill; 

private:
	CCharacterObject* _character;
};

#endif	// _CHAR_SKILL_CORE_H_