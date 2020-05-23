#include "core/common.h"

#include "char_attribute_core.h"
#include "obj_character.h"
#include "game_misc.h"

#define DAddAttr(T, AN, vt, val)	\
	T _val = get##AN();	\
	set##AN(_val + val);	\
	markAttrDirty(vt);	\
	refreshFast(true);	\
	if (logFlag)	\
	{	\
	gxInfo("Add "#AN"!Old"#AN"={0},New"#AN"={1},{2}", _val, get##AN(), _character->toString());	\
	}	\
	return get##AN();

EJobType CCharAttributeCore::getJob() const
{
	return (EJobType)_job;
}

void CCharAttributeCore::setJob( TJob_t job )
{
	_job = job;
}

TLevel_t CCharAttributeCore::getMaxLevel() const
{
	return MAX_LEVEL;
}

void CCharAttributeCore::setLevel( TLevel_t level )
{
	_level = level;
	CGameMisc::RefixValue(_level, 0, getMaxLevel());
}

TLevel_t CCharAttributeCore::getLevel() const
{
	return _level;
}

TLevel_t CCharAttributeCore::addLevel( TLevel_t level, bool logFlag )
{
	TLevel_t tempLevel = getLevel();
	if(tempLevel+level > getMaxLevel())
	{
		level = getMaxLevel()-tempLevel;
	}
	setLevel(tempLevel+level);
	gxAssert(tempLevel <= getLevel());
	if(tempLevel < getLevel())
	{
		onLevelChanged(tempLevel, getLevel());
	}
	refreshFast(true);
	if(logFlag)
	{
		gxInfo("Add level!OldLevel={0},NewLevel={1},{2}", (sint32)tempLevel, (sint32)getLevel(), _character->toString());
	}
	return getLevel();
}

void CCharAttributeCore::onLevelChanged( uint32 sLvl, uint32 dLvl )
{
	gxDebug("Character level up!{0},oldLvl={1},newLvl={2}", _character->toString(), sLvl, dLvl);			// @todo 日志记录等级改变
	loadBaseAttr(&_baseAttr);
}

THp_t CCharAttributeCore::hpChange(THp_t increment, CCharacterObject* pDestObj)
{
	if (!_character->isActive())
	{
		return 0;
	}

	THp_t nHp = getHp() + increment;
	THp_t nInc = increment;
	THp_t nOldHP = getHp();

	// 调整血量
	if (getMaxHp() < nHp)
	{
		nHp = getMaxHp();
		nInc = getMaxHp() - getHp();
	}
	if (0 > nHp)
	{
		nHp = 0;
		nInc = 0 - getHp();
	}

	THp_t hpd = getHp() + nInc;
	setHp(hpd);

	if (0 <= increment)
	{
		if (nOldHP <= 0 && getHp() > 0)
		{
			TObjUID_t destObjUID = INVALID_OBJ_UID;
			if (pDestObj != NULL)
			{
				destObjUID = pDestObj->getObjUID();
			}
			_character->onRelive(destObjUID);
		}
	}
	else
	{
		_character->onHurt(-1 * increment, pDestObj->getObjUID());
	}

	return nInc;
}

TExp_t CCharAttributeCore::getMaxExp( TLevel_t lvl /*= 0*/ ) const
{
	return 0;
}

TExp_t CCharAttributeCore::getExp() const
{
	return _exp;
}

void CCharAttributeCore::setExp( TExp_t exp )
{
	_exp = exp;
	CGameMisc::RefixValue(_exp, 0, getMaxExp());
}

TExp_t CCharAttributeCore::addExp( TExp_t val, bool logFlag )
{
	TExp_t oldExp = getExp();
	TExp_t expd = getExp()+val;
	if(expd >= getMaxExp(1))
	{
		if(getLevel() < getMaxLevel())
		{
			expd = doExpLevelUp(expd);
		}
		else
		{
			expd = getMaxExp();
		}
	}
	setExp(expd);
	refreshFast();
	if(logFlag)
	{
		gxInfo("Add exp!OldExp={0},NewExp={1},{2}", oldExp, getExp(), _character->toString());
	}
	return getExp();
}

TExp_t CCharAttributeCore::doExpLevelUp( TExp_t val )
{
	TLevel_t lvl = getLevel();
	TExp_t maxExps = getMaxExp(lvl);
	while(val >= maxExps && lvl < getMaxLevel())
	{
		val -= maxExps;
		lvl++;
		maxExps = getMaxExp(lvl);
	}

	if(lvl > getLevel())
	{
		addLevel(lvl-getLevel());
	}

	return val;
}

TAttackPhysic_t CCharAttributeCore::getPhysicAttck() const
{
	return getFormulaAttrValue(ATTR_ATTACK);
}

TAttackPhysic_t CCharAttributeCore::getFightPhysicAttack() const
{
	double val = getPhysicAttck()*(MAX_BASE_RATE+getSkillAttr()->oddsAttr.getValue(ATTR_ATTACK))
		/MAX_BASE_RATE+getSkillAttr()->valueAttr.getValue(ATTR_ATTACK);
	return GXMISC::gxDouble2Int<TAttackPhysic_t>(val);
}

TAttackPhysic_t CCharAttributeCore::addPhysicAttack(TAttrVal_t val)
{
	_baseAttr.addValue(ATTR_ATTACK, val) ;
	markAttrDirty(ATTR_ATTACK);
	return getPhysicAttck();
}

TDefensePhysic_t CCharAttributeCore::addPhysicDefense(TAttrVal_t val)
{
	_baseAttr.addValue(ATTR_DEFENSE, val);
	markAttrDirty(ATTR_DEFENSE);
	return getPhysicDefense();
}

TDefensePhysic_t CCharAttributeCore::getPhysicDefense() const
{
	return getFormulaAttrValue(ATTR_DEFENSE);
}

TDefensePhysic_t CCharAttributeCore::getFightPhysicDefense() const
{
	double val = getPhysicDefense()*(MAX_BASE_RATE+getSkillAttr()->oddsAttr.getValue(ATTR_DEFENSE))
		/MAX_BASE_RATE+getSkillAttr()->valueAttr.getValue(ATTR_DEFENSE);
	return GXMISC::gxDouble2Int<TDefensePhysic_t>(val);
}

THp_t CCharAttributeCore::getMaxHp() const
{
	return getFormulaAttrValue(ATTR_MAX_HP);
}

THp_t CCharAttributeCore::addMaxHp( TAttrVal_t val, bool logFlag )
{
	THp_t oldMaxHp = getMaxHp();
	_baseAttr.addValue(ATTR_MAX_HP, val);
	markAttrDirty(ATTR_MAX_HP);
	refreshFast(true);
	if(logFlag)
	{
		gxInfo("Add max hp!OldMaxHp={0},NewMaxHp={1},{2}", oldMaxHp, getMaxHp(), _character->toString());
	}
	return getMaxHp();
}

THp_t CCharAttributeCore::addHp( TAttrVal_t hp, bool logFlag )
{
	THp_t hpd = getHp();
	setHp(hpd+hp);
	refreshFast(true);
	if(logFlag)
	{
		gxInfo("Add hp!OldHp={0},NewHp={1},{2}", hpd, getHp(), _character->toString());
	}
	return getHp();
}

THp_t CCharAttributeCore::getHp() const
{
	return _hp;
}

void CCharAttributeCore::setHp(THp_t hp)
{
	_hp = hp; 
	CGameMisc::RefixValue(_hp, 0, getMaxHp());
}

THp_t CCharAttributeCore::getNeedAddHpToMax() const
{
	THp_t hpd = getMaxHp()-getHp();
	if(hpd > 0)
	{
		return hpd;
	}

	return 0;
}

CSkillAttr* CCharAttributeCore::getSkillAttr() const
{
	return (CSkillAttr*)&_skillAttr;
}

void CCharAttributeCore::cleanUp()
{
	_hp = 0;
	_job = INVALID_JOB_TYPE;

	_attrDirtySet.setAll();
	_baseAttr.reset();
	_characterAttrs.reset();
}

bool CCharAttributeCore::update( GXMISC::TDiffTime_t diff )
{
	return true;
}

bool CCharAttributeCore::updateOutBlock( GXMISC::TDiffTime_t diff )
{
	return true;
}

void CCharAttributeCore::setCharacter( CCharacterObject* character )
{
	_character = character;
}

TMoveSpeed_t CCharAttributeCore::getMoveSpeed() const
{
	return _moveSpeed;
}

TMoveSpeed_t CCharAttributeCore::addMoveSpeed( TAttrVal_t val, bool logFlag )
{
	TMoveSpeed_t moveSpeed = getMoveSpeed();
	setMoveSpeed(moveSpeed+val);
	refreshFast(true);
	if(logFlag)
	{
		gxInfo("Add move speed!OldMoveSpeed={0},NewMoveSpeed={1},{2}", moveSpeed, getMoveSpeed(), _character->toString());
	}
	return getMoveSpeed();
}

void CCharAttributeCore::setMoveSpeed( TMoveSpeed_t speed )
{
	_moveSpeed = speed;
}

TAttackRange_t CCharAttributeCore::getAttackRange() const
{
	return _attackRange;
}

void CCharAttributeCore::setAttackRange( TAttrVal_t val )
{
	_attackRange = val;
}

TAttackRange_t CCharAttributeCore::addAttackRange( TAttrVal_t val )
{
	TAttackRange_t tempVal = getAttackRange() + val;
	setAttackRange(tempVal);
	return getAttackRange();
}

TAttackSpeed_t CCharAttributeCore::getAttackSpeed() const
{
	return _attackSpeed;
}

void CCharAttributeCore::setAttackSpeed( TAttrVal_t val )
{
	_attackSpeed = val;
}

TAttackSpeed_t CCharAttributeCore::addAttackSpeed( TAttrVal_t val )
{
	TAttackSpeed_t tempVal = getAttackSpeed() + val;
	setAttackSpeed(tempVal);
	refreshFast(true);
	return getAttackSpeed();
}

TAttrVal_t CCharAttributeCore::getFormulaAttrValue( TAttrType_t attrType ) const
{
	return 0;
}

// TAttrVal_t CCharAttributeCore::getFightFormulaAttrValue(TAttrType_t attrType) const
// {
// 	return 0;
// }

TAttrVal_t CCharAttributeCore::addAttrValue( TAttrType_t index, TAttrVal_t val )
{
	const CObjAddAttrFunc<CCharAttributeCore>::Func& pFunc = _addFunc.getFunc(index);
	if ( pFunc == NULL )
	{
		return INVALID_ATTR_VAL;
	}
	return (this->*pFunc)(val);
}

void CCharAttributeCore::setAttrValue( TAttrType_t index, uint32 val )
{
}

TAttrVal_t CCharAttributeCore::getAttrValue( TAttrType_t index ) const
{
	const CObjGetAttrFunc<CCharAttributeCore>::Func& pFunc = _getFunc.getFunc(index);
	if ( pFunc == NULL )
	{
		return INVALID_ATTR_VAL;
	}
	return (this->*pFunc)();
}

TAttrVal_t CCharAttributeCore::getFightAttrValue( TAttrType_t index ) const
{
	const CObjGetAttrFunc<CCharAttributeCore>::Func& pFunc = _getFightFunc.getFunc(index);
	if ( pFunc == NULL )
	{
		return INVALID_ATTR_VAL;
	}
	return (this->*pFunc)();
}

TAttrVal_t CCharAttributeCore::getNeedAddToMax( TAttrType_t index ) const
{
	const CObjGetAttrFunc<CCharAttributeCore>::Func& pFunc = _getNeedAddToMaxFunc.getFunc(index);
	if ( pFunc == NULL )
	{
		gxAssert(false);
		return 0;
	}
	return (this->*pFunc)();
}

void CCharAttributeCore::markAttrDirty( TAttrType_t index )
{

}

void CCharAttributeCore::refreshFast( bool sendFlag /*= true*/ )
{
}

void CCharAttributeCore::markAllAttrDirty()
{
}

const std::string CCharAttributeCore::logTotalAttr(bool logFlag)
{
	return "";
}

const std::string CCharAttributeCore::logBaseAttr(bool logFlag)
{
	return "";
}

const std::string CCharAttributeCore::logEquipAttr(bool logFlag)
{
	return "";
}

const std::string CCharAttributeCore::logBufferAttr(bool logFlag)
{
	return "";
}

const std::string CCharAttributeCore::logCombatResult(bool logFlag)
{
	return "";
}

TAttrVal_t CCharAttributeCore::getBaseAttrValue(TAttrType_t index) const
{
	gxAssert(false); // @TODO 实现
	return 0;
}

TPower_t CCharAttributeCore::getPower() const
{
	return _baseAttr.getValue(ATTR_POWER);
}

void CCharAttributeCore::setPower(TPower_t val)
{
	_baseAttr.setValue(ATTR_POWER, val);
}

TPower_t CCharAttributeCore::addPower(TAttrVal_t val, bool logFlag /*= false*/)
{
	DAddAttr(TPower_t, Power, ATTR_POWER, val);
}

TPower_t CCharAttributeCore::getFightPower() const
{
	gxAssert(false);
	return 0;
}

TAgility_t CCharAttributeCore::getAgility() const
{
	return _baseAttr.getValue(ATTR_AGILITY);
}

void CCharAttributeCore::setAgility(TAgility_t hp)
{
	_baseAttr.setValue(ATTR_AGILITY, hp);
}

TAgility_t CCharAttributeCore::getFightAgility() const
{
	gxAssert(false);
	return 0;
}

TStrength_t CCharAttributeCore::addAgility(TAttrVal_t hp, bool logFlag /*= false*/)
{
	DAddAttr(TAgility_t, Agility, ATTR_AGILITY, hp);
}

TWisdom_t CCharAttributeCore::getWisdom() const
{
	return _baseAttr.getValue(ATTR_WISDOM);
}

void CCharAttributeCore::setWisdom(TWisdom_t hp)
{
	_baseAttr.setValue(ATTR_WISDOM, hp);
}

TWisdom_t CCharAttributeCore::getFightWisdom() const
{
	gxAssert(false);
	return 0;
}

TWisdom_t CCharAttributeCore::addWisdom(TAttrVal_t hp, bool logFlag /*= false*/)
{
	DAddAttr(TWisdom_t, Wisdom, ATTR_WISDOM, hp);;
}

TStrength_t CCharAttributeCore::addStrength(TAttrVal_t val, bool logFlag)
{
	DAddAttr(TStrength_t, Strength, ATTR_STRENGTH, val);
}

void CCharAttributeCore::setStrength(TStrength_t val)
{
	_baseAttr.addValue(ATTR_STRENGTH, val);
}

TStrength_t  CCharAttributeCore::getStrength() const
{
	return getFormulaAttrValue(ATTR_STRENGTH);
}

TStrength_t CCharAttributeCore::getFightStrength() const
{
	gxAssert(false);
	return 0;
}

TCrit_t CCharAttributeCore::getCrit() const
{
	return getFormulaAttrValue(ATTR_CRIT);
}

void CCharAttributeCore::setCrit(TCrit_t val)
{
	_baseAttr.setValue(ATTR_CRIT, val);
}

TCrit_t CCharAttributeCore::getFightCrit() const
{
	double val = getCrit()*(MAX_BASE_RATE + getSkillAttr()->oddsAttr.getValue(ATTR_CRIT))
		/ MAX_BASE_RATE + getSkillAttr()->valueAttr.getValue(ATTR_CRIT);
	return GXMISC::gxDouble2Int<TCrit_t>(val);
}

TCrit_t CCharAttributeCore::addCrit(TAttrVal_t val)
{
	_baseAttr.addValue(ATTR_CRIT, val);
	markAttrDirty(ATTR_CRIT);
	return getCrit();
}

TDodge_t CCharAttributeCore::getDodge() const
{
	return _baseAttr.getValue(ATTR_DODGE);
}

void CCharAttributeCore::setDodge(TDodge_t val)
{
	_baseAttr.setValue(ATTR_DODGE, val);
}

TDodge_t CCharAttributeCore::getFightDodge() const
{
	gxAssert(false);
	return 0;
}

TDodge_t CCharAttributeCore::addDodge(TAttrVal_t val, bool logFlag)
{
	DAddAttr(TDodge_t, Dodge, ATTR_DODGE, val);
}

TDamage_t CCharAttributeCore::getDamage() const
{
	return _baseAttr.getValue(ATTR_DAMAGE);
}

void CCharAttributeCore::setDamage(TDamage_t val)
{
	_baseAttr.setValue(ATTR_DAMAGE, val);
}

TDamage_t CCharAttributeCore::getFightDamage() const
{
	gxAssert(false);
	return 0;
}

TDamage_t CCharAttributeCore::addDamage(TAttrVal_t val, bool logFlag /*= false*/)
{
	DAddAttr(TDamage_t, Damage, ATTR_DAMAGE, val);
}

TAttackPhysic_t CCharAttributeCoreExt::getSkillAttack() const
{
	return getFormulaAttrValue(ATTR_SKILL_ATTACK);
}

TAttackPhysic_t CCharAttributeCoreExt::getFightSkillAttack() const
{
	double val = getSkillAttack()*(MAX_BASE_RATE + getSkillAttr()->oddsAttr.getValue(ATTR_SKILL_ATTACK))
		/ MAX_BASE_RATE + getSkillAttr()->valueAttr.getValue(ATTR_SKILL_ATTACK);
	return GXMISC::gxDouble2Int<TAttackPhysic_t>(val);
}

TAttackPhysic_t CCharAttributeCoreExt::addSkillAttack(TAttrVal_t val)
{
	_baseAttr.addValue(ATTR_SKILL_ATTACK, val);
	markAttrDirty(ATTR_SKILL_ATTACK);
	return getSkillAttack();
}

TDamage_t CCharAttributeCoreExt::getDamageReduce() const
{
	return _baseAttr.getValue(ATTR_DAMAGE_REDUCE);
}

void CCharAttributeCoreExt::setDamageReduce(TDamage_t val)
{
	_baseAttr.setValue(ATTR_DAMAGE_REDUCE, val);
}

TDamage_t CCharAttributeCoreExt::getFightDamageReduce() const
{
	gxAssert(0);
	return 0;
}

TDamage_t CCharAttributeCoreExt::addDamageReduce(TAttrVal_t val, bool logFlag /*= false*/)
{
	DAddAttr(TDamage_t, DamageReduce, ATTR_DAMAGE_REDUCE, val);
}

TEnergy_t CCharAttributeCoreExt::getMaxEnergy() const
{
	return getFormulaAttrValue(ATTR_MAX_ENERGY);
}

TEnergy_t CCharAttributeCoreExt::addMaxEnergy(TAttrVal_t val, bool logFlag /*= false*/)
{
	TEnergy_t _val = getMaxEnergy();
	_baseAttr.addValue(ATTR_MAX_ENERGY, val);
	markAttrDirty(ATTR_MAX_ENERGY);
	refreshFast(true);
	if (logFlag)
	{
		gxInfo("Add max energy!OldMaxEnergy={0},NewMaxEnergy={1},{2}", _val, getMaxEnergy(), _character->toString());
	}
	return getMaxEnergy();
}

TEnergy_t CCharAttributeCoreExt::getNeedAddEnergyToMax() const
{
	TEnergy_t val = getMaxEnergy() - getEnergy();
	if (val > 0)
	{
		return val;
	}

	return 0;
}

TEnergy_t CCharAttributeCoreExt::getEnergy() const
{
	return _characterAttrs.getValue(ATTR_CUR_ENERGY);
}

void CCharAttributeCoreExt::setEnergy(TEnergy_t val)
{
	_characterAttrs.setValue(ATTR_CUR_ENERGY, val);
}

TEnergy_t CCharAttributeCoreExt::addEnergy(TAttrVal_t val, bool logFlag /*= false*/)
{
	TEnergy_t _val = getEnergy();
	setEnergy(_val + val);
	refreshFast(true);
	if (logFlag)
	{
		gxInfo("Add energy!OldEnergy={0},NewEnergy={1},{2}", _val, getEnergy(), _character->toString());
	}
	return getEnergy();
}

void CCharAttributeCoreExt::initMemberFunc()
{
	_addFunc.registerFunc(ATTR_CUR_HP, (CObjAddAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::addHp);
	_addFunc.registerFunc(ATTR_MAX_HP, (CObjAddAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::addMaxHp);
	_addFunc.registerFunc(ATTR_ATTACK, (CObjAddAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::addPhysicAttack);
	_addFunc.registerFunc(ATTR_DEFENSE, (CObjAddAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::addPhysicDefense);
	_addFunc.registerFunc(ATTR_CRIT, (CObjAddAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::addCrit);
	_addFunc.registerFunc(ATTR_MOVE_SPEED, (CObjAddAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::addMoveSpeed);

	_getFunc.registerFunc(ATTR_CUR_HP, (CObjGetAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::getHp);
	_getFunc.registerFunc(ATTR_MAX_HP, (CObjGetAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::getMaxHp);
	_getFunc.registerFunc(ATTR_ATTACK, (CObjGetAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::getPhysicAttck);
	_getFunc.registerFunc(ATTR_DEFENSE, (CObjGetAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::getPhysicDefense);
	_getFunc.registerFunc(ATTR_CRIT, (CObjGetAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::getCrit);
	_getFunc.registerFunc(ATTR_MOVE_SPEED, (CObjGetAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::getMoveSpeed);

	_getFightFunc.registerFunc(ATTR_CUR_HP, (CObjGetAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::getHp);
	_getFightFunc.registerFunc(ATTR_MAX_HP, (CObjGetAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::getMaxHp);
	_getFightFunc.registerFunc(ATTR_ATTACK, (CObjGetAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::getFightPhysicAttack);
	_getFightFunc.registerFunc(ATTR_DEFENSE, (CObjGetAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::getFightPhysicDefense);
	_getFightFunc.registerFunc(ATTR_CRIT, (CObjGetAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::getFightCrit);
	_getFightFunc.registerFunc(ATTR_MOVE_SPEED, (CObjGetAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::getMoveSpeed);

	_getNeedAddToMaxFunc.registerFunc(ATTR_CUR_HP, (CObjGetAttrFunc<CCharAttributeCore>::Func)&CCharAttributeCore::getNeedAddHpToMax);
}

bool CCharAttributeCoreExt::init(const TCharacterInit* inits)
{
	initMemberFunc();

	loadBaseAttr(&_baseAttr);
	setHp(inits->hp);
	_bufferMgr = inits->bufferManager;

	return true;
}

TEnergy_t CCharAttributeCoreExt::energyChange(TEnergy_t increment, CCharacterObject* pDestObj)
{
	// @todo
	if (!_character->isActive())
	{
		return 0;
	}

	TEnergy_t nMp = getEnergy() + increment;
	TEnergy_t nInc = increment;
	//    TMp_t nOldMp = getMp();

	// 调整血量
	if (getMaxEnergy() < nMp)
	{
		nMp = getMaxEnergy();
		nInc = getMaxEnergy() - getEnergy();
	}
	if (0 > nMp)
	{
		nMp = 0;
		nInc = getEnergy();
	}
	addEnergy(nInc);

	return nInc;
}

CBufferManager* CCharAttributeCoreExt::getBufferManager()
{
	return _bufferMgr;
}
