#ifndef _CHAR_FIGHT_CORE_H_
#define _CHAR_FIGHT_CORE_H_

#include "core/fix_array.h"

#include "game_util.h"
#include "attributes.h"
#include "object_util.h"
#include "char_skill_core.h"
#include "cool_down.h"
#include "skill_core.h"
#include "buffer_manager_base.h"

// 战斗结果
typedef GXMISC::CArray<THp_t, 2> TCombatResultHpAry;
typedef GXMISC::CArray<TMp_t, 1> TCombatResultMpAry;
typedef GXMISC::CFixArray<sint32, 4> TCombatResultParamAry;

class CCombatResult
{
public:
	CCombatResult(){ cleanUp(); }
	~CCombatResult(){}

public:
	THp_t getHpChanged();           				// 获取普通掉血效果
	THp_t getMpChanged();							// 获取普通掉魔效果
	void setHpChanged(THp_t hp);    				// 设置普通掉血效果
	void setMpChanged(TMp_t mp);					// 设置普通掉魔效果
	THp_t addHpChanged(THp_t hp);   				// 添加普通掉血效果
	void pushDoubleHitHp(THp_t hp); 				// 添加连击掉血效果
	void setHit();                  				// 设置命中
	bool isHit();                   				// 是否命中
	bool isDoubleHit();             				// 是否连击
	bool isHitBack();               				// 是否击退
	bool isCrit();                  				// 是否暴击
	void cleanUp();                 				// 清理
	EAttackImpactType getImpactType();				// 获取技能效果
	void setImpactType(EAttackImpactType type);		// 设置技能效果
	void setParam(sint32 index, sint32 paramVal);	// 设置参数

public:
	EAttackImpactType   impactType;     			// 效果类型
	bool hit;                           			// 是否命中
	bool doubleHit;                     			// 是否连击
	TCombatResultHpAry hpChangedAry;    			// 血量改变列表(只有在连击的情况下才会有多次掉血效果)
	TCombatResultMpAry mpChangedAry;    			// 魔量改变列表
	TCombatResultParamAry paramAry;     			// 额外参数列表(击退-格子数|...)
	TObjState_t		combatState;					// 战斗状态(乱杀)
};

// 战斗临时数据
class CCombatTempData
{
public:
	TSkillTypeID_t skillTypeID;		// 对方使用的技能ID
	TObjUID_t attackorUID;			// 攻击者的UID
	CSkillAttr skillAttr;			// 对方对当前对象的技能效果
	CCombatResult result;			// 战斗结果
	GXMISC::TGameTime_t	lastUseSkillTime;	// 上次使用技能的时间

	void reset()
	{
		skillTypeID = INVALID_SKILL_TYPE_ID;
		attackorUID = INVALID_OBJ_UID;
		skillAttr.cleanUp();
		result.cleanUp();
	}

	bool canAttackTeammer();			// 是否可以攻击自己的队友
};

typedef struct _ReliveInfo
{
	// HP
	TAddAttr hp;
	// MP
	TAddAttr mp;
	// 复活点
	TSceneID_t		_sceneID;
	TAxisPos		_pos;

	_ReliveInfo( void )
	{
	}

	void reset( void )
	{
		_sceneID = INVALID_SCENE_ID;
	}

	bool isInvalid()
	{
		return _sceneID == INVALID_SCENE_ID;
	}

}TReliveInfo;

// 攻击信息
class CAttackInfo
{
public:
	TObjUID_t lastAttackMeRoleObjUID;						// 攻击我的角色UID
	GXMISC::TGameTime_t lastAttackMeRoleTime;				// 攻击我的角色时间
	TObjUID_t lastAttackOtherRoleObjUID;					// 上次攻击其他角色
	GXMISC::TGameTime_t lastAttackOtherRoleTime;			// 上次攻击其他角色的时间
};

class CCharacterObject;
class CCharFightCore
{
	friend class CCharacterObject;

public:
	void	cleanUp();
	bool	init( const TCharacterInit* inits );
	bool	update( GXMISC::TDiffTime_t diff );
	bool	updateOutBlock( GXMISC::TDiffTime_t diff );

public:
	void setCharacter(CCharacterObject* character);

public:
	CCharSkillCore* getSkillCore();								// 得到技能对像
//	CBufferManagerBase* getBufferMgr();							// 得到Buffer管理器

	// 行为状态
public:
	// 行为禁止接口
	TObjActionBan_t* getActionBan() const ;			// 获取行为禁止标记
	bool getActionBan(EActionBan banType) const;	// 获取行为禁止标记
	void setActionBan(EActionBan banType);			// 设置行为禁止标记
	void clearActionBan(EActionBan banType);		// 清除行为禁止标记
	EGameRetCode checkAction(bool moveFlag, bool useSkillFlag, bool beAttackFlag);	// 检测行为禁止标记

	void setUnBeAttack(bool flag = false);											// 设置是否能被攻击
	virtual EGameRetCode canAttackMe(CCharacterObject* pCharacter);					// 能否被攻击

	virtual bool canMove();															// 能否移动
	virtual bool canUseSkill();														// 能否使用技能
	virtual bool canBeAttack();														// 能否被攻击
	virtual bool canBeUseItem();													// 参否使用物品

public:
	void logActionBan();															// 打印行为禁止状态
	void logState();

	// 复活信息
public:
	virtual bool relive(TReliveInfo* reliveInfo, CCharacterObject* pChart);
	TReliveInfo* getReliveInfo();
	void setReliveInfo(TReliveInfo* reliveInfo);
	void resetReliveInfo();
protected:
	TReliveInfo _reliveInfo;

	// 战斗
public:
	EGameRetCode useSkill(TObjUID_t destObjUID, TSkillTypeID_t skillTypeID, TAxisPos_t x, TAxisPos_t y);	// 使用技能
	void onAfterUseSkill();															// 使用技能后事件
	void onAfterBeSkill();															// 被技能攻击后
	void cleanLastCombatData();														// 清除上一次战斗数据
	bool canAttackTeammer();														// 能否攻击队员
	void attackBack(TDir_t dir, TRange_t range);									// 击退

	TObjUID_t getLastHurtMeObjUID();												// 上次对自己造成伤害的ObjUID
	TObjUID_t getLastHurtOtherObjUID();												// 获取到上次对对方造成伤害的ObjUID
	EObjType getLastHurtMeObjType();												// 获取到上次对自己造成伤害的ObjType
	EObjType getLastHurtOtherObjType();												// 获取到上次对对方造成伤害的ObjType
	void setLastHurtOtherObjUID(TObjUID_t objUID);									// 上次对对方造成伤害的ObjUID
	void setLastHurtOtherObjType(EObjType objType);									// 上次对对方造成伤害的ObjType
	bool canHit(CCharacterObject* character);										// 能否命中
	bool canCrit();																	// 能否暴击
	TObjUID_t getAssistantUID();													// 获取辅助者
	void setLastAttackMeTime(GXMISC::TGameTime_t curTime);							// 设置上次被攻击的时间
	GXMISC::TGameTime_t getLastAttackMeTime();										// 获取到上次被攻击的时间
	void setLastAttackDieObjUID(TObjUID_t objUID);									// 打死的对象UID
	TObjUID_t getLastAttackDieObjUID();												// 获取到被攻击致死的对象UID
public:
	CCombatResult* getCombatResult();												// 战斗结果
	void appendSkillBuff(CCharacterObject* pCharacter, CSkillInfo* skillInfo);		// 添加战斗Buff
protected:
	void calcHurt(CCharacterObject* pCharacter, CSkillInfo* pSkillInfo);			// 计算伤害

	// 技能相关
public:
	// 技能是否正在冷却
	virtual bool isSkillCoolDown(TSkillTypeID_t skillID);
	// 普通技能是否正在冷却
	bool isCommonSkillCdDown(TSkillTypeID_t skillID = INVALID_SKILL_TYPE_ID);

public:
	bool isCombatStart();																			// 是否战斗开始
	bool isCombatEnd();																				// 是否战斗结束
	ECombatStateType getCombatState();																// 获取战斗状态
	virtual bool combatStart();																		// 战斗开始
	virtual bool combatEnd();																		// 战斗结束

public:
	virtual EGameRetCode onBeforeHit(CCharacterObject* character);									// 命中前
	virtual void onDie();																			// 死亡
	virtual void onHurt(THp_t hp, TObjUID_t objUID);												// 被伤害
	virtual void onUseSkillSuccess(CCharacterObject* attackor, TSkillTypeID_t skill);				// 使用技能成功
	virtual bool onBeUseSkill(CCharacterObject* attackor, TSkillTypeID_t skill, bool goodSkill);	// 别人对当前角色使用技能
	virtual bool onUseSkill(TSkillTypeID_t skill, TImpactCharacterList* impactObjs);				// 对别人使用技能
	virtual void onRelive(TObjUID_t caster);														// 复活
	virtual void onKillObject(CCharacterObject* pDestObj);											// 杀死一个对象
	virtual void onBeKill(CCharacterObject* pDestObj);												// 被其他对象杀死
	virtual void onEnterArea(){}																	// 进入事件区
	virtual void onAttackChart(CCharacterObject* pDestObj);											// 攻击玩家
	virtual void onStateChange();																	// 状态改变
	virtual void onActionBanChange(EActionBan actionBan);											// 行为禁止改变
	virtual void onCombatStart();																	// 战斗开始
	virtual void onCombatEnd();																		// 战斗结束
	virtual void onCombatChange(ECombatStateType beforeState, ECombatStateType curState);			// 战斗状态改变
	virtual void onStartAttackOther(CCharacterObject* pDestObj);									// 攻击其他玩家前
	virtual void onStartBeAttack(CCharacterObject* pDestObj);										// 被攻击前
	virtual void onAfterAttackOther(CCharacterObject* pDestObj);									// 攻击后
	virtual void onAfterBeAttack(CCharacterObject* pDestObj);										// 被攻击后

	// 战斗
protected:
	TObjUID_t _lastHurtMeObjUID;				// 上一次对自身造成伤害的对象UID
	EObjType _lastHurtMeObjType;				// 上一次对自身造成伤害的对象类型
	GXMISC::TGameTime_t _lastAttackMeTime;		// 上一次对自身造成攻击的时间
	TObjUID_t _lastHurtOtherObjUID;				// 上一次对对方造成伤害的对象UID
	EObjType _lastHurtOtherObjType;				// 上一次对对方造成伤害的对象类型
	GXMISC::TGameTime_t _lastAttackOtherTime;	// 上一次攻击对方的时间
	TObjUID_t _lastAttackDieOtherObjUID;		// 上一次被打死的对象UID
	TObjUID_t _assistantID;                     // 辅助者
	ECombatStateType _combatState;				// 战斗状态

protected:
	CCombatTempData _combatTempData;			// 战斗临时数据
	TSkillCoolDown _skillCoolDown;              // 技能冷却
	TSkillCommCoolDown _skillCommCoolDown;      // 技能公共冷却
	CActionBan _banAction;						// 目标行为
	GXMISC::TGameTime_t _lastDieTime;			// 上次死亡时间
	GXMISC::TGameTime_t _lastReliveTime;		// 上次复活时间
private:
	CCharacterObject* _character;				// 拥有对象
};

#endif	// _CHAR_FIGHT_CORE_H_