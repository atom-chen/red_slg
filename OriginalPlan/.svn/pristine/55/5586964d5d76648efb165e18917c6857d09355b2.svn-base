#ifndef _ATTRIBUTES_H_
#define _ATTRIBUTES_H_

#include "core/fix_array.h"
#include "core/types_def.h"
#include "core/string_common.h"

#include "game_util.h"
#include "game_misc.h"
#include "game_define.h"

#pragma pack(push, 1)

class IAttrBase
{
public:
	TAttrVal_t getPower()const{ return getValue(ATTR_POWER); }
	TAttrVal_t getAgility()const { return getValue(ATTR_AGILITY); }
	TAttrVal_t getWisdom()const { return getValue(ATTR_WISDOM); }
	TAttrVal_t getStrength()const { return getValue(ATTR_STRENGTH); }
	TAttrVal_t getCrit()const { return getValue(ATTR_CRIT); }
	TAttrVal_t getDodge()const { return getValue(ATTR_DODGE); }
	TAttrVal_t getDamage()const { return getValue(ATTR_DAMAGE); }
	TAttrVal_t getPhysicAttck()const{ return getValue(ATTR_ATTACK); };
	TAttrVal_t getPhysicDefense() const { return getValue(ATTR_DEFENSE); }
	TAttrVal_t getSkillAttack() const { return getValue(ATTR_SKILL_ATTACK); }
	TAttrVal_t getDamageReduce() const { return getValue(ATTR_DAMAGE_REDUCE); }
	TAttrVal_t getMoveSpeed()const { return getValue(ATTR_MOVE_SPEED); }
	TAttrVal_t getMaxHp()const { return getValue(ATTR_MAX_HP); }
	TAttrVal_t getMaxEnergy()const { return getValue(ATTR_MAX_ENERGY); }
	TAttrVal_t getHp()const { return getValue(ATTR_CUR_HP); }
	TAttrVal_t getMp()const { return getValue(ATTR_CUR_ENERGY); }

public:
	void setPower(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_POWER,val); }
	void setAgility(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_AGILITY,val); }
	void setWisdom(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_WISDOM, val); }
	void setStrength(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_STRENGTH, val); }
	void setCrit(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_CRIT, val); }
	void setDodge(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_DODGE, val); }
	void setDamage(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_DAMAGE, val); }
	void setPhysicAttck(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_ATTACK, val); }
	void setPhysicDefense(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_DEFENSE, val); }
	void setSkillAttack(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_SKILL_ATTACK, val); }
	void setDamageReduce(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_DAMAGE_REDUCE, val); }
	void setMoveSpeed(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_MOVE_SPEED, val); }
	void setMaxHp(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_MAX_HP, val); }
	void setMaxEnergy(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_MAX_ENERGY, val); }
	void setHp(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_CUR_HP, val); }
	void setMp(TAttrVal_t val) { CGameMisc::RefixValue(val, std::numeric_limits<TAttrVal_t>::min()); setValue(ATTR_CUR_ENERGY, val); }

public:
	TAttrVal_t addPower(TAttrVal_t val) { return addValue(ATTR_POWER,val); }
	TAttrVal_t addAgility(TAttrVal_t val) { return addValue(ATTR_AGILITY, val); }
	TAttrVal_t addWisdom(TAttrVal_t val) { return addValue(ATTR_WISDOM, val); }
	TAttrVal_t addStrength(TAttrVal_t val) { return addValue(ATTR_STRENGTH, val); }
	TAttrVal_t addCrit(TAttrVal_t val) { return addValue(ATTR_CRIT, val); }
	TAttrVal_t addDodge(TAttrVal_t val) { return addValue(ATTR_DODGE, val); }
	TAttrVal_t addDamage(TAttrVal_t val) { return addValue(ATTR_DAMAGE, val); }
	TAttrVal_t addPhysicAttck(TAttrVal_t val) { return addValue(ATTR_ATTACK, val); }
	TAttrVal_t addPhysicDefense(TAttrVal_t val) { return addValue(ATTR_DEFENSE, val); }
	TAttrVal_t addSkillAttack(TAttrVal_t val) { return addValue(ATTR_SKILL_ATTACK, val); }
	TAttrVal_t addDamageReduce(TAttrVal_t val) { return addValue(ATTR_DAMAGE_REDUCE, val); }
	TAttrVal_t addMoveSpeed(TAttrVal_t val) { return addValue(ATTR_MOVE_SPEED, val); }
	TAttrVal_t addMaxHp(TAttrVal_t val) { return addValue(ATTR_MAX_HP, val); }
	TAttrVal_t addMaxEnergy(TAttrVal_t val) { return addValue(ATTR_MAX_ENERGY, val); }
	TAttrVal_t addHp(TAttrVal_t val) { return addValue(ATTR_CUR_HP, val); }
	TAttrVal_t addEnergy(TAttrVal_t val) { return addValue(ATTR_CUR_ENERGY, val); }

public:
	virtual TAttrVal_t getValue(const TAttrType_t index)const = 0;
	virtual void setValue(const TAttrType_t index, const TAttrVal_t val) = 0;
	virtual TAttrVal_t addValue(const TAttrType_t index, const TAttrVal_t val) = 0;
};

// 属性基类
template<typename T, sint32 MaxAttrNum>
class CAttrBase : public IAttrBase
{
public:
	CAttrBase(){ reset(); }
	virtual ~CAttrBase(){}

public:
	TAttrVal_t attrs[MaxAttrNum];					// 提高的属性值

public:
	bool operator != (const CAttrBase<T, MaxAttrNum>& ls) const
	{
		return (memcmp(attrs, ls.attrs, sizeof(attrs)) != 0);
	}

	TAttrVal_t& operator[](TAttrType_t index)
	{
		gxAssert(index > 0 && index < MaxAttrNum);
		return attrs[index];
	}

public:
	TAttrVal_t getValue(const TAttrType_t index) const override { return attrs[index]; }
	void setValue(const TAttrType_t index, const TAttrVal_t val) override { attrs[index] = val; }
	TAttrVal_t addValue(const TAttrType_t index, const TAttrVal_t val) override { return attrs[index] += val; return getValue(index); }

public:
	void addValue(CAttrBase<T, MaxAttrNum>& rhs)
	{
		for (uint32 i = 1; i < MaxAttrNum; ++i)
		{
			attrs[i] += rhs;
		}
	}
	void reset() { memset(attrs, 0, sizeof(attrs)); }
};

// 附加属性
typedef struct AddAttr
{
public:
	AddAttr()
	{
		cleanUp();
	}

	AddAttr(TValueType_t valueType, TAttrVal_t attrValue)
	{
		this->addType = valueType;
		this->attrValue = attrValue;
	}

public:
	bool isRate()
	{
		return addType == NUMERICAL_TYPE_ODDS;
	}
	bool isValid()
	{
		return addType != NUMERICAL_TYPE_INVALID;
	}
	void cleanUp()
	{
		addType = NUMERICAL_TYPE_INVALID;
		attrValue = 0;
	}

public:
	TAttrType_t getAddType() const { return addType; }
	void setAddType(TAttrType_t val) { addType = val; }
	TAttrVal_t getAttrValue() const { return attrValue; }
	void setAttrValue(TAttrVal_t val) { attrValue = val; }

	// @member
public:
	TAttrType_t		addType;		///< 属性类型
	TAttrVal_t	    attrValue;		///< 属性值
}TAddAttr;
typedef struct Attr
{
	// @member
public:
	TAttrType_t attrType;	///< 属性类型
	TAttrVal_t attrValue;	///< 属性值

public:
	TAttrType_t getAttrType() const { return attrType; }
	void setAttrType(TAttrType_t val) { attrType = val; }
	TAttrVal_t getAttrValue() const { return attrValue; }
	void setAttrValue(TAttrVal_t val) { attrValue = val; }

public:
	Attr() :
	attrType(INVALID_ATTR_INDEX)
		,attrValue(INVALID_ATTR_VAL)
	{
	}

	Attr(TAttrType_t attrType, TAttrVal_t attrVal)
	{
		this->attrType = attrType;
		this->attrValue = attrVal;
	}

	void cleanUp(EAttributes attrType = (EAttributes)0, sint32 values = 0)
	{
		this->attrType = attrType;
		this->attrValue = values;
	}

	bool isValid()
	{
		return attrValue != INVALID_ATTR_VAL && attrType != INVALID_ATTR_INDEX;
	}

	bool operator==(const Attr& rhs)
	{
		return memcmp(this, &rhs, sizeof(*this)) == 0;
	}
}TAttr;
typedef struct ExtendAttr
{
	// @member
public:
	TAttrType_t		attrType;	///< 属性类型
	TValueType_t    valueType;	///< 值类型
	TAttrVal_t		attrValue;	///< 属性值

public:
	ExtendAttr()
	{
		attrType = 0;
		valueType = NUMERICAL_TYPE_VALUE;
		attrValue = 0;
	}

	ExtendAttr(TAttrType_t attrType, TValueType_t valueType, TAttrVal_t attrValue)
	{
		this->attrType = attrType;
		this->valueType = valueType;
		this->attrValue = attrValue;
	}

public:
	bool operator== (const ExtendAttr& ls) const
	{
		return attrType == ls.attrType;
	}

	bool isRate()
	{
		return valueType == NUMERICAL_TYPE_ODDS;
	}

	void cleanUp()
	{
		attrType	= 0;
		valueType	= 0;
		attrValue	= 0;
	}

public:
	TAttrType_t getAttrType() const { return attrType; }
	void setAttrType(TAttrType_t val) { attrType = val; }
	TValueType_t getValueType() const { return valueType; }
	void setValueType(TValueType_t val) { valueType = val; }
	TAttrVal_t getAttrValue() const { return attrValue; }
	void setAttrValue(TAttrVal_t val) { attrValue = val; }
}TExtendAttr;
typedef std::vector<TExtendAttr> TExtentAttrVec;
typedef std::vector<TAddAttr> TAddAttrVec;
typedef std::vector<TAttr> TAttrVec;
typedef CArray1<TExtendAttr> TExtAttrAry;

template <typename T, int MaxAttrNum>
class CDetailAttrBase
{
public:
	CAttrBase<T, MaxAttrNum>	valueAttr;	// 具体数值
	CAttrBase<T, MaxAttrNum>	oddsAttr;	// 百分比数值

public:
	void reset() { valueAttr.reset(); oddsAttr.reset(); }
	void setValue(const TAttrType_t index, TValueType_t valueType, const uint32 val)
	{
		switch(valueType)
		{
		case NUMERICAL_TYPE_VALUE:
			{
				valueAttr[index] = val; 
			}break;
		case NUMERICAL_TYPE_ODDS:
			{
				oddsAttr[index] = val; 
			}break;
		}
	}

	void addValue(const TAttrType_t index, TValueType_t valueType, const uint32 val)
	{
		switch(valueType)
		{
		case NUMERICAL_TYPE_VALUE:
			{
				valueAttr.addValue(index, val);
			}break;
		case NUMERICAL_TYPE_ODDS:
			{
				oddsAttr.addValue(index, val); 
			}break;
		}
	}

	void addValue(TExtendAttr& attr)
	{
		switch(attr.valueType)
		{
		case NUMERICAL_TYPE_VALUE:
			{
				valueAttr.addValue(attr.attrType, attr.attrValue);
			}break;
		case NUMERICAL_TYPE_ODDS:
			{
				oddsAttr.addValue(attr.attrType, attr.attrValue); 
			}break;
		}
	}
	void addValue(CDetailAttrBase<T, MaxAttrNum>& rhs)
	{
		valueAttr.addValue(rhs.valueAttr);
		oddsAttr.addValue(rhs.oddsAttr);
	}
	void addValue(TExtentAttrVec& rhs)
	{
		for(uint32 i = 0; i < rhs.size(); ++i)
		{
			addValue(rhs[i]);
		}
	}
};
// 行为禁止
class CActionBan
{
public:
	bool getValue(const TAttrType_t index){ return _banFlag[index]; }
	void setValue(const TAttrType_t index, bool flag){ if(!flag) {_banFlag.clear(index);}else{ _banFlag.set(index);} }
	void cleanUp(){ _banFlag.clearAll(); }

public:
	const TObjActionBan_t* getState() const { return &_banFlag; }
	bool getState(const TAttrType_t index) const { return _banFlag[index]; }

public:
	void reset()
	{
		_banFlag.clearAll();
	}

private:
	TObjActionBan_t _banFlag;
};

typedef GXMISC::CFixBitSet<ATTR_CHAR_CURR_MAX> TAttrDirtySet;   // 属性脏集合
typedef GXMISC::CFixBitSet<ACTION_BAN_MAX> TActionBanDirtySet;  // 行为禁止脏集合
typedef CAttrBase<sint32, ATTR_CHAR_CURR_MAX> TChartAttrs;      // 最终总的属性
typedef CAttrBase<sint32, ATTR_CHAR_CURR_MAX> TBaseAttrs;       // 基础属性

// 攻击时临时战斗数据
typedef struct SkillAttr
{
public:
	SkillAttr()
	{
		cleanUp();
	}

public:
	void cleanUp()
	{
		memset(attrs, 0, sizeof(attrs));
	}

	void setValue(TAttrVal_t val)
	{
		attrs[0] = val;
	}
	void setRate(TAttrVal_t val)
	{
		attrs[1] = val;
	}
	TAttrVal_t addValue(TAttrVal_t val)
	{
		attrs[0] += val;
		return attrs[0];
	}
	TAttrVal_t addRate(TAttrVal_t val)
	{
		attrs[1] += val;
		return attrs[1];
	}
	TAttrVal_t getValue() const
	{
		return attrs[0];
	}
	TAttrVal_t getRate() const
	{
		return attrs[1];
	}
	void add(const SkillAttr* rhs)
	{
		attrs[0] += rhs->getValue();
		attrs[1] += rhs->getRate();
	}
	bool isEmpty() const
	{
		return attrs[0] == 0 && attrs[1] == 0;
	}

public:
	TAttrVal_t attrs[2];
}TSkillAttr;
class CSkillAttr : public CDetailAttrBase<sint32, ATTR_CHAR_CURR_MAX>
{
public:
	typedef CDetailAttrBase<sint32, ATTR_CHAR_CURR_MAX> TBaseType;

public:
	CSkillAttr() : TBaseType()
	{
		cleanUp();
	}
	~CSkillAttr()
	{
		cleanUp();
	}

public:
	void cleanUp()
	{
		TBaseType::reset();
		_critHurt.cleanUp();
		_impactType = INVALID_ATTACK_IMPACT_TYPE;
		_appendCritHurtRate = 0;
	}

public:
	void setFixCritHurt(TValueType_t valueType, TAttrVal_t val);
	TAttrVal_t getFixCritHurt(TValueType_t valueType) const;
	TAttrVal_t addFixCritHurt(TValueType_t valueType, TAttrVal_t val); 
	bool isFixCritHurt() const;
	const TSkillAttr* getFixCritHurt() const;
	void setAppendCritRate(TAttrVal_t val);
	TAttrVal_t getAppendCritRate();

private:
	TSkillAttr _critHurt;							// 固定暴击伤害
	TAttrVal_t _appendCritHurtRate;					// 附加的暴击几率
	TAttackImpactType_t _impactType;				// 效果类型(参考EAttackImpactType)
};

typedef GXMISC::CFixArray<TAttrVal_t, MAX_BUFF_EFFECT_TYPE_NUM> TBuffAttrParam;      // Buff属性参数
// Buffer属性
class CBufferAttr : public CDetailAttrBase<sint32, ATTR_CHAR_CURR_MAX>
{
public:
	typedef CDetailAttrBase<sint32, ATTR_CHAR_CURR_MAX> TBaseType;

public:
	CActionBan actionBanFlags;      // 行为禁止
	TBuffAttrParam attrParam;       // 其他属性参数(如:经验倍数)

public:
	void reset()
	{
		TBaseType::reset();
		actionBanFlags.reset();
	}
	void resetBase()
	{
		TBaseType::reset();
	}

	std::string toString()
	{
		std::string str;
		str = "\n=====================ValueAttr\n";
		for (uint32 i = 1; i < ATTR_CHAR_CURR_MAX; ++i)
		{
			if (valueAttr[i] != 0)
			{
				str += GXMISC::gxToString("[%d:%d]", i, valueAttr[i]);
			}
		}
		str += "\n=====================OddsAttr\n";
		for (uint32 i = 1; i < ATTR_CHAR_CURR_MAX; ++i)
		{
			if (oddsAttr[i] != 0)
			{
				str += GXMISC::gxToString("[%d:%d]", i, oddsAttr[i]);
			}
		}
		str += "\n=====================ActionBan\n";
		for (uint32 i = 1; i < ACTION_BAN_MAX; ++i)
		{
			if (actionBanFlags.getValue(i))
			{
				str += GXMISC::gxToString("[%d:%d]", i, actionBanFlags.getValue(i));
			}
		}

		return str;
	}
};
typedef CBufferAttr TBufferAttrs;                               // Buffer增加的属性

#define DAddFuncImpl(Class, Type, FuncName)		\
	Type Class::add##FuncName(Type val, bool logFlag)	\
	{	\
		Type oldVal = get##FuncName();	\
		set##FuncName(oldVal+val);	\
		refreshFast(true);	\
		if(logFlag)	\
		{	\
			gxInfo("Add "#FuncName"!OldValue={0},NewVal={1},{2},RoleUID={3},AccountID={4}",	\
			sint32(oldVal), sint32(get##FuncName()), toString(), getRoleUID(), getAccountID());	\
		}	\
		return get##FuncName();	\
		\
	}

#pragma pack(pop)

#endif