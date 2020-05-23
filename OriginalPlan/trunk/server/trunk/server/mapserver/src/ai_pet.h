#ifndef _AI_PET_H_
#define _AI_PET_H_

#include "interval_timer.h"
#include "game_struct.h"
#include "ai_character.h"

class CCharacterObject;
class CObjPet;

// 宠物AI
class CPetAI : public CAICharacter
{
	typedef CAICharacter TBaseType;

public:
	enum { BODYSTAYTIME = 5000, };

public:
	CPetAI(void);
	virtual ~CPetAI(void);

protected:
	CObjPet* getCharacter();

public:
	virtual bool init(CCharacterObject *pCharacter);
	virtual void term(void);
	virtual void relive(CCharacterObject* pCharacter);

	//======================
	// 逻辑状态、事件相关
	//======================
protected:
	virtual void AILogicIdle(GXMISC::TDiffTime_t diff);             // 空闲
	virtual void AILogicCombat(GXMISC::TDiffTime_t diff);           // 战斗
	virtual void AILogicApproach(GXMISC::TDiffTime_t diff);         // 追击敌人

	//===================
	// 行为相关
	//===================
public:
	// 触发baby进行跟随
	void	petToGo(const TAxisPos *paTargetPos);
	// 宠物进行攻击
	void	petToAttack(void);

protected:
	virtual void eventOnDie(CCharacterObject* pKiller = NULL);
	virtual void eventOnDamage(THp_t damage, CCharacterObject* pAttacker) {};
	virtual void eventOnBeSkill(CCharacterObject* pCharacter, bool goodSkill) {};

protected:
	// 是否已经远离主人
	bool        isGoToOwner();
	// 改变走路模式
	void	    changeMoveMode(void);
	// 计算跟主人之间的距离
	double	    calcDistSqrOfToOwner(void);
	// 战斗是否完成
	bool	    isCombatBeOver(void);
	// 清理战斗
	void        clearCombat();
	// 获取靠近敌人的最佳坐标
	bool        getMaxRangePos(TAxisPos& pos);

	// 执行行为动作
protected:
	bool        doAttack();         // 攻击敌人
	bool        doApproach();       // 靠近
	void	    doRandMove(void);   // 随机移动
	bool		doBossSkill();

	// 状态转移
protected:
	void        toIdle();       // 转入空闲状态
	void        toAttack();     // 转入攻击状态
	void        toApproach();   // 转入靠近状态

public:
	TSkillLevel_t getSkillLevel(TSkillTypeID_t skillID);
	void loadSkill();
	void cleanSkill();
	void setUseSkill(TSkillTypeID_t skillID, TSkillLevel_t skillLvl);

private:
	GXMISC::CManualIntervalTimer    _idleTimer;		// IDLE定时器
	TExtUseSkillList _bossSkills;					// 技能
	TOwnSkill       _skill;							// 缓存的技能
};

#endif