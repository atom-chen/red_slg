#ifndef _CHAR_ATTRIBUTE_CORE_H_
#define _CHAR_ATTRIBUTE_CORE_H_

#include "game_util.h"
#include "attributes.h"
#include "obj_attr_func.h"
#include "object_util.h"
#include "buffer_manager_base.h"

class CCharacterObject;

class CCharAttributeCore	
{
public:
	void cleanUp();
	bool update( GXMISC::TDiffTime_t diff );
	bool updateOutBlock( GXMISC::TDiffTime_t diff );

public:
	void setCharacter(CCharacterObject* character); 

	// 战斗属性
public:
	// Job(职业)
	EJobType getJob() const; 
	void setJob(TJob_t job); 

	// ================角色基本属性================
public:
	// AttackRange(数值, 攻击范围)
	TAttackRange_t getAttackRange() const;
	void setAttackRange(TAttrVal_t val);
	TAttackRange_t addAttackRange(TAttrVal_t val);

	// AttackSpeed(数值, 攻击速度)
	TAttackSpeed_t getAttackSpeed() const;
	void setAttackSpeed(TAttrVal_t val);
	TAttackSpeed_t addAttackSpeed(TAttrVal_t val);

	// MoveSpeed(数值, 移动速度)
	void setMoveSpeed(TMoveSpeed_t speed);
	virtual TMoveSpeed_t getMoveSpeed() const;
	TMoveSpeed_t addMoveSpeed(TAttrVal_t val, bool logFlag = false);

	// Level(数值, 等级)
	virtual TLevel_t getMaxLevel() const; 
	virtual void setLevel(TLevel_t level); 
	virtual TLevel_t getLevel() const; 
	TLevel_t addLevel(TLevel_t level, bool logFlag = false); 

	// Exp(数值, 经验)
	virtual TExp_t getMaxExp(TLevel_t lvl = 0) const; 
	virtual TExp_t getExp() const; 
	virtual void setExp(TExp_t exp); 
	TExp_t addExp(TExp_t val, bool logFlag = false); 
	TExp_t doExpLevelUp(TExp_t val); 

	// Hp(数值, 生命)
	virtual THp_t getMaxHp() const; 
	THp_t addMaxHp(TAttrVal_t val, bool logFlag = false); 
	THp_t getNeedAddHpToMax() const; 
	virtual THp_t getHp() const; 
	virtual void setHp(THp_t hp); 
	THp_t addHp(TAttrVal_t hp, bool logFlag = false); 

	// ================基础属性, 参与公式计算================
public:
	// Power(->Attack, 力量, 基础属性)
	virtual TPower_t getPower() const;
	virtual void setPower(TPower_t val);
	TPower_t getFightPower() const;
	TPower_t addPower(TAttrVal_t val, bool logFlag = false);

	// Agility(->Defense, 敏捷, 基础属性)
	virtual TAgility_t getAgility() const;
	virtual void setAgility(TAgility_t hp);
	TAgility_t getFightAgility() const;
	TAgility_t addAgility(TAttrVal_t hp, bool logFlag = false);

	// Wisdom(->SkillAttack, 智力, 基础属性)
	virtual TWisdom_t getWisdom() const;
	virtual void setWisdom(TWisdom_t hp);
	TWisdom_t getFightWisdom() const;
	TWisdom_t addWisdom(TAttrVal_t hp, bool logFlag = false);

	// Strength(->HP, 体力, 基础属性)
	virtual TStrength_t getStrength() const;
	virtual void setStrength(TStrength_t val);
	TStrength_t getFightStrength() const;
	TStrength_t addStrength(TAttrVal_t hp, bool logFlag = false);

	// Crit(暴击, 基础属性)
	virtual TCrit_t getCrit() const;
	virtual void setCrit(TCrit_t val);
	TCrit_t getFightCrit() const;
	TCrit_t addCrit(TAttrVal_t val);

	// Dodge(闪避, 基础属性)
	virtual TDodge_t getDodge() const;
	virtual void setDodge(TDodge_t val);
	TDodge_t getFightDodge() const;
	TDodge_t addDodge(TAttrVal_t val, bool logFlag = false);

	// Damage(额外伤害, 基础属性)
	virtual TDamage_t getDamage() const;
	virtual void setDamage(TDamage_t val);
	TDamage_t getFightDamage() const;
	TDamage_t addDamage(TAttrVal_t val, bool logFlag = false);

	// ================公式计算属性================
public:
	// PhysicAttack(攻击, 计算公式)
	virtual TAttackPhysic_t getPhysicAttck() const;
	TAttackPhysic_t getFightPhysicAttack() const;
	TAttackPhysic_t addPhysicAttack(TAttrVal_t val);

	// PhysicDefense(防御, 计算公式)
	virtual TDefensePhysic_t getPhysicDefense() const;
	TDefensePhysic_t getFightPhysicDefense() const;
	TDefensePhysic_t addPhysicDefense(TAttrVal_t val);

public:
	// 公式计算
	virtual TAttrVal_t getFormulaAttrValue(TAttrType_t attrType) const;
//	virtual TAttrVal_t getFightFormulaAttrValue(TAttrType_t attrType) const;

public:
	// 添加属性值
	virtual TAttrVal_t  addAttrValue(TAttrType_t index, TAttrVal_t val); 
	// 设置属性值
	virtual void setAttrValue(TAttrType_t index, uint32 val); 
	// 获取属性值
	virtual TAttrVal_t getAttrValue(TAttrType_t index) const; 
	// 获取战斗属性
	TAttrVal_t getFightAttrValue(TAttrType_t index) const; 
	// 获取将属性增加到最大值的差值
	TAttrVal_t getNeedAddToMax(TAttrType_t index) const; 
	// 将属性值标记为无效
	void markAttrDirty(TAttrType_t index); 
	// 将所有属性值标记为无效
	void markAllAttrDirty(); 

public:
	// 获取基本属性值
	TAttrVal_t getBaseAttrValue(TAttrType_t index) const;
	// 战斗数值
	CSkillAttr* getSkillAttr() const;

public:
	// 即使同步属性
	virtual void refreshFast(bool sendFlag = true); 
	// 加载基础属性
	virtual void loadBaseAttr(TBaseAttrs* baseAttr){} 
	
	// 事件处理
public:
	// 等级提升(原等级, 改变后等级)
	virtual void onLevelChanged(uint32 sLvl, uint32 dLvl);
	// 血量改变
	THp_t hpChange(THp_t incrememnt, CCharacterObject* pDestObj);

	// 战斗数值统计
public:
	const std::string logBaseAttr(bool logFlag);
	const std::string logEquipAttr(bool logFlag);
	const std::string logBufferAttr(bool logFlag);
	const std::string logTotalAttr(bool logFlag);
	const std::string logCombatResult(bool logFlag);

private:
	void appendString(std::string& str, const std::string& name, sint32 val);

protected:
	THp_t _hp;									// 血量
	TJob_t _job;								// 职业
	TMoveSpeed_t _moveSpeed;					// 移动速度
	TAttackRange_t _attackRange;				// 攻击距离
	TAttackSpeed_t _attackSpeed;				// 攻击速度
	TExp_t _exp;								// 经验
	TLevel_t _level;							// 等级

protected:
	TAttrDirtySet _attrDirtySet;                // 属性脏集合
	// 总属性 (包括:基础属性, 装备附加属性, Buffer附加属性)
	TChartAttrs _characterAttrs;                // 最终角色的总属性
	// 基本属性 等级提升的属性
	TBaseAttrs _baseAttr;						// 基础角色属性
	// 基础系数
	TBaseAttrs _baseOddsAttr;					// 基础属性系数
	// 战斗属性
	CSkillAttr _skillAttr;						// 技能属性

protected:
	CCharacterObject* _character;				// 对象

protected:
	CObjAttrFunc<CObjAddAttrFunc<CCharAttributeCore> >		_addFunc;
	CObjAttrFunc<CObjGetAttrFunc<CCharAttributeCore> >		_getFunc;
	CObjAttrFunc<CObjGetAttrFunc<CCharAttributeCore> >		_getFightFunc;
	CObjAttrFunc<CObjGetAttrFunc<CCharAttributeCore> >      _getNeedAddToMaxFunc;
};

// 扩展的角色属性
class CCharAttributeCoreExt : public CCharAttributeCore
{
	typedef CCharAttributeCore TBaseType;

public:
	bool init(const TCharacterInit* inits);

public:
	CBufferManager* getBufferManager();

public:
	// SkillAttack(技能攻击, 公式计算)
	virtual TAttackPhysic_t getSkillAttack() const;
	TAttackPhysic_t getFightSkillAttack() const;
	TAttackPhysic_t addSkillAttack(TAttrVal_t val);

	// AttackReduce(伤害减免, 基础属性)
	virtual TDamage_t getDamageReduce() const;
	virtual void setDamageReduce(TDamage_t val);
	TDamage_t getFightDamageReduce() const;
	TDamage_t addDamageReduce(TAttrVal_t val, bool logFlag = false);

	// Energy(能量, 数值)
	virtual TEnergy_t getMaxEnergy() const;
	TEnergy_t addMaxEnergy(TAttrVal_t val, bool logFlag = false);
	TEnergy_t getNeedAddEnergyToMax() const;
	virtual TEnergy_t getEnergy() const;
	virtual void setEnergy(TEnergy_t val);
	TEnergy_t addEnergy(TAttrVal_t val, bool logFlag = false);

	// 事件
public:
	// 能量改变
	TMp_t energyChange(TEnergy_t incrememnt, CCharacterObject* pDestObj);

private:
	// 初始函数指针
	void initMemberFunc();

private:
	// Buffer属性: 被动技能/物品/主动技能
	CBufferManager* _bufferMgr;		// Buffer管理器
};

#endif	// _CHAR_ATTRIBUTE_CORE_H_