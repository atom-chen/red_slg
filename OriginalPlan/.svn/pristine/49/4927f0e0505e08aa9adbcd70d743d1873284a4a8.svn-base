#include "skill_core.h"
#include "obj_character.h"
#include "map_scene_base.h"
#include "game_exception.h"
#include "module_def.h"

void CSkillInfo::cleanUp()
{
	_skillLevel = 0;
}

EGameRetCode CSkillInfo::load(TSkillTypeID_t skillIDType, CCharacterObject* pObj)
{
// 	_skillRow = DSkillTblMgr.find(skillIDType);
// 	if (NULL == _skillRow)
// 	{
// 		gxError("Can't find skill! SkillTypeID = %u", skillIDType);
// 		return RC_SKILL_NO_FIND;
// 	}

	_skillLevel = pObj->getSkillLevel(skillIDType);
	if (_skillLevel == INVALID_SKILL_LEVEL)
	{
		return RC_SKILL_NO_USE;
	}

	_skillLevel--;

	if (!effects.empty())
	{
		for (TSkillEffectAttrVec::iterator iter = effects[0].begin(); iter != effects[0].end(); ++iter)
		{
			TExtendAttr& val = *iter;
			gxAssert(val.valueType != 0);
			if (val.attrValue > 0)
			{
				_impactType |= IMPACT_TYPE_ME;
			}
			else
			{
				_impactType |= IMPACT_TYPE_OTHER;
			}
		}
	}

	if (buffEffectID != INVALID_BUFFER_TYPE_ID)
	{
		assert(false);
// 		CBufferConfigTbl* pBuffRow = DBuffTblMgr.find(buffEffectID);
// 		if (NULL == pBuffRow)
// 		{
// 			gxError("Can't find buff!BuffID=%u", buffEffectID);
// 			return false;
// 		}
// 
// 		if (pBuffRow->getAttrArySize() > 0)
// 		{
// 			TBuffAttrAry& buffAttrAry = pBuffRow->getAttrAry(0);
// 			for (TBuffAttrAry::iterator iter = buffAttrAry.begin(); iter != buffAttrAry.end(); ++iter)
// 			{
// 				TExtendAttr& val = *iter;
// 				gxAssert(val.valueType != 0);
// 				if (val.attrValue > 0)
// 				{
// 					_impactType |= IMPACT_TYPE_ME;
// 				}
// 				else
// 				{
// 					_impactType |= IMPACT_TYPE_OTHER;
// 				}
// 			}
// 		}
	}

	return RC_SUCCESS;
}

bool CSkillInfo::isNeedJobCheck()
{
	return true;
}

bool CSkillInfo::isUseOwner()
{
	return getTargetType() == SKILL_TARGET_TYPE_OWN || getTargetType() == SKILL_TARGET_TYPE_TEAM;
}

void CSkillInfo::doEffect(CCharacterObject* rObj, bool des)
{
	if (_skillLevel >= (TSkillLevel_t)effects.size())
	{
		return;
	}

	for (uint32 i = 0; i < effects[_skillLevel].size(); ++i)
	{
		TExtendAttr effect = effects[_skillLevel][i];
		if (effect.attrValue < 0 && des)
		{
			// 负的技能效果是对敌方
			rObj->getSkillAttr()->addValue(effect);
		}
		else if (effect.attrValue > 0 && !des)
		{
			// 正的技能效果是对已方
			rObj->getSkillAttr()->addValue(effect);
		}
	}
}

CSkillInfo::CSkillInfo()
{
	cleanUp();
}

CSkillInfo::~CSkillInfo()
{
	cleanUp();
}

TSkillTypeID_t CSkillInfo::getSkillTypeID()
{
	return id;
}

TJob_t CSkillInfo::getJob()
{
	return job;
}

uint8 CSkillInfo::getType()
{
	return type;
}

uint8 CSkillInfo::getAttackType()
{
	return attackType;
}

uint8 CSkillInfo::getTargetType()
{
	return targetType;
}

uint32 CSkillInfo::getOdds()
{
	return buffOdds[_skillLevel];
}

uint8 CSkillInfo::getDistance()
{
	return triggerDis;
}

uint32 CSkillInfo::getCD()
{
	return cd;
}

uint32 CSkillInfo::getCommCD()
{
	return commCd;
}

TMp_t CSkillInfo::getNeedEnery()
{
	if (_skillLevel >= (TSkillLevel_t)needMp.size()) return 0; return needMp[_skillLevel].attrValue;
}

uint32 CSkillInfo::getParamSize()
{
	return parameter.size();
}

TSkillParamsVec* CSkillInfo::getParamVec()
{
	return &parameter[_skillLevel];
}

uint32 CSkillInfo::getDelayTime()
{
	return delayTime;
}

sint32 CSkillInfo::getEffectSize()
{
	return effects.size();
}

bool CSkillInfo::isSingle()
{
	return attackType == SKILL_ATTACK_TYPE_SINGLE;
}

bool CSkillInfo::isGroup()
{
	return attackType == SKILL_ATTACK_TYPE_GROUP;
}

bool CSkillInfo::isToSelf()
{
	return (_impactType & IMPACT_TYPE_ME) || targetType == SKILL_TARGET_TYPE_OWN || SKILL_TARGET_TYPE_TEAM;
}

bool CSkillInfo::isToEmeny()
{
	return (_impactType & IMPACT_TYPE_OTHER) || targetType == SKILL_TARGET_TYPE_ENEMY;
}

bool CSkillInfo::isPassiveSkill()
{
	return type == SKILL_TYPE_PASSIVE;
}

bool CSkillInfo::isActive()
{
	return type == SKILL_TYPE_ACTIVE || type == SKILL_TYPE_ASSIST;
}

EScanReturn CSkillTargetScan::onFindObject(CGameObject* pObj)
{
	CSkillTargetScanInit* init = (CSkillTargetScanInit*)_init;
	if (NULL == init)
	{
		return SCAN_RETURN_RETURN;
	}

	if (init->targets.getAttackObjSize() >= init->attackNum)
	{
		return SCAN_RETURN_RETURN;
	}

	CCharacterObject* pCharacter = pObj->toCharacter();
	if (NULL == pCharacter)
	{
		return SCAN_RETURN_CONTINUE;
	}

	if (pCharacter->isDie() || !pCharacter->canBeAttack() || pCharacter->isSafeZone())
	{
		return SCAN_RETURN_CONTINUE;
	}

	if (!pCharacter->isInValidRadius(pCharacter->getMapID(), &init->pos, init->skillRanage))
	{
		return SCAN_RETURN_CONTINUE;
	}

	if (_attacker->isMonster() && pObj->isMonster() && _attacker->getCampData()->isInvalid())
	{
		// 怪物攻击怪物无效, 在阵营战中有效
		return SCAN_RETURN_CONTINUE;
	}

	if (!IsSuccess(pCharacter->canAttackMe(_attacker)))
	{
		return SCAN_RETURN_CONTINUE;
	}

	if (init->skillInfo.getTargetType() == SKILL_TARGET_TYPE_TEAM && !pCharacter->isTeamMember(init->pChartMe))
	{
		// 队伍技能, 敌人
		return SCAN_RETURN_CONTINUE;
	}

	if (init->skillInfo.getTargetType() == SKILL_TARGET_TYPE_ENEMY && pCharacter->isSameCamp(init->pChartMe) && !(_attacker->canAttackTeammer()))
	{
		// 攻击技能, 同阵营的玩家(乱杀除外)及安全区的玩家除外
		return SCAN_RETURN_CONTINUE;
	}

	init->targets.push(pCharacter);

	return SCAN_RETURN_CONTINUE;
}

CSkillTargetScan::CSkillTargetScan(CCharacterObject* attacker) : TBaseType(), _attacker(attacker)
{
}

CSkillTargetScan::~CSkillTargetScan()
{

}

void CSkillLogicBase::init()
{
	FUNC_BEGIN(SKILL_MOD);

	FUNC_END(DRET_NULL);
}

void CSkillLogicBase::cleanUp()
{
	FUNC_BEGIN(SKILL_MOD);

	_skillInfo.cleanUp();

	FUNC_END(DRET_NULL);
}

CSkillInfo* CSkillLogicBase::getSkillInfo()
{
	return &_skillInfo;
}

EGameRetCode CSkillLogicBase::load(CCharacterObject* rMe, const CAttackPos* attackPos)
{
	FUNC_BEGIN(SKILL_MOD);

	EGameRetCode retCode = RC_SUCCESS;
	retCode = _skillInfo.load(attackPos->skilTypeID, rMe);
	if (!IsSuccess(retCode))
	{
		return retCode;
	}
	if (!checkLevel())
	{
		return RC_SKILL_NO_USE;
	}

	if (!onLoad(rMe, attackPos))
	{
		return RC_SKILL_NO_USE;
	}

	return RC_SUCCESS;

	FUNC_END(RC_SKILL_NO_USE);
}

EGameRetCode CSkillLogicBase::onBeforeUse(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget)
{
	FUNC_BEGIN(SKILL_MOD);

	EGameRetCode retCode = RC_SUCCESS;

	return retCode;

	return RC_SUCCESS;

	FUNC_END(RC_SKILL_NO_USE);
}

EGameRetCode CSkillLogicBase::onAfterUse(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget)
{
	FUNC_BEGIN(SKILL_MOD);

	_skillInfo.cleanUp();

	return RC_SUCCESS;

	FUNC_END(RC_SKILL_NO_USE);
}

EGameRetCode CSkillLogicBase::check(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget)
{
	FUNC_BEGIN(SKILL_MOD);

	EGameRetCode retCode;

	if (!rMe->canUseSkill())
	{
		return RC_SKILL_NO_USE_SKILL;
	}

	retCode = checkJob(rMe, attackPos, attackTarget);
	if (!IsSuccess(retCode))
	{
		return retCode;
	}

	// 检测自身状态
	retCode = checkOwer(rMe, attackPos, attackTarget);
	if (!IsSuccess(retCode))
	{
		return retCode;
	}

	// 检测目标的状态
	retCode = checkObj(rMe, attackPos, attackTarget);
	if (!IsSuccess(retCode))
	{
		return retCode;
	}

	// 距离检测
	retCode = checkDistance(rMe, attackPos, attackTarget);
	if (!IsSuccess(retCode))
	{
		return retCode;
	}

	// CD时间
	if (!rMe->isSkillCoolDown(attackPos->skilTypeID))
	{
		return RC_SKILL_NO_CD;
	}

	// MP
	if (_skillInfo.needMp.size() > 0 && !rMe->isMonster() && !rMe->isPet())
	{
		TAddAttr& attrs = _skillInfo.needMp[_skillInfo.getLevel()];
		if (attrs.addType == NUMERICAL_TYPE_ODDS)
		{
			if (rMe->getEnergy() < ((TMp_t)(rMe->getMaxEnergy()*attrs.attrValue / ((double)MAX_BASE_RATE))))
			{
				return RC_SKILL_NO_ENOUGH_MP;
			}
		}
		else if (rMe->getEnergy() < _skillInfo.getNeedEnery())
		{
			return RC_SKILL_NO_ENOUGH_MP;
		}
	}

	// 与目标关系检测
	retCode = checkTarget(rMe, attackPos, attackTarget);
	if (!IsSuccess(retCode))
	{
		return retCode;
	}

	// 攻击类型和目标类型检测
	retCode = checkType(rMe, attackPos, attackTarget);
	if (!IsSuccess(retCode))
	{
		return retCode;
	}

	return RC_SUCCESS;

	FUNC_END(RC_SKILL_NO_USE);
}

EGameRetCode CSkillLogicBase::selectTarget(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget)
{
	FUNC_BEGIN(SKILL_MOD);

	if (_skillInfo.getAttackType() == SKILL_ATTACK_TYPE_SINGLE)
	{
		gxAssert(attackTarget->destObj);
		if (!attackTarget->destObj->canBeAttack())
		{
			return RC_SKILL_NO_BE_ATTACK;
		}
		attackTarget->attackorList.push(attackTarget->destObj);
	}
	else if (_skillInfo.getAttackType() == SKILL_ATTACK_TYPE_GROUP)
	{
		CSkillTargetScanInit init(&attackTarget->attackorList, &_skillInfo);
		init.blockID = rMe->getScene()->calcBlockID(&attackPos->pos);
		init.scene = rMe->getScene();
		init.attackNum = getMaxAttackNum();
		init.skillRanage = _skillInfo.range;
		init.scanRole = false;
		init.pos = attackPos->pos;
		init.pChartMe = rMe;
		init.scanRange = rMe->getScene()->axisRange2BlockRange(&attackPos->pos, _skillInfo.range);  // 根据技能效果范围来确定搜索范围

		CSkillTargetScan scan(rMe);
		if (!scan.init(&init))
		{
			attackTarget->attackorList.cleanUp();
			return RC_SKILL_NO_BE_ATTACK;
		}
		if (false == rMe->getScene()->scan(&scan, true))
		{
			attackTarget->attackorList.cleanUp();
			return RC_SKILL_NO_BE_ATTACK;
		}
	}

	return RC_SUCCESS;

	FUNC_END(RC_SKILL_NO_USE);
}

EGameRetCode CSkillLogicBase::checkDistance(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget)
{
	FUNC_BEGIN(SKILL_MOD);

	if (_skillInfo.isUseOwner())
	{
		return RC_SUCCESS;
	}

	if (_skillInfo.getAttackType() == SKILL_ATTACK_TYPE_SINGLE)
	{
		if (!rMe->isInValidRadius(attackTarget->destObj, _skillInfo.getDistance()))
		{
			//            gxError("Attack range not enough! %s", toString());
			return RC_SKILL_NO_DISTANCE;
		}

		if (rMe->isMonster())
		{
			// 怪物技能的直线判断需要和人物及宠物的颠倒过来
			if (!rMe->getScene()->getMapData()->isSkillLineEmpty(rMe->getAxisPos(), attackTarget->destObj->getAxisPos(), BLOCK_FLAG_SKILL))
			{
				return RC_SKILL_NO_EMPTY_POS;
			}
		}
		else
		{
			if (!rMe->getScene()->getMapData()->isSkillLineEmpty(attackTarget->destObj->getAxisPos(), rMe->getAxisPos(), BLOCK_FLAG_SKILL))
			{
				return RC_SKILL_NO_EMPTY_POS;
			}
		}
	}
	else if (_skillInfo.getAttackType() == SKILL_ATTACK_TYPE_GROUP)
	{
		if (!rMe->isInValidRadius(rMe->getMapID(), &attackPos->pos, _skillInfo.getDistance()))
		{
			//            gxError("Attack range not enough! %s", toString());
			return RC_SKILL_NO_DISTANCE;
		}

		if (!rMe->getScene()->getMapData()->isSkillLineEmpty(&attackPos->pos, rMe->getAxisPos(), BLOCK_FLAG_SKILL))
		{
			return RC_SKILL_NO_EMPTY_POS;
		}
	}
	else
	{
		//        gxError("Unkown attack type! %u", _skillInfo.getAttackType());
		return RC_SKILL_NO_DISTANCE;
	}

	return RC_SUCCESS;

	FUNC_END(RC_SKILL_NO_USE);
}

EGameRetCode CSkillLogicBase::checkTarget(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget)
{
	FUNC_BEGIN(SKILL_MOD);

	CCharacterObject* pChart = NULL;
	if (_skillInfo.isSingle())
	{
		pChart = rMe->getScene()->getCharacterByUID(attackPos->destObjUID);
		if (NULL == pChart)
		{
			return RC_SKILL_NO_DEST_OBJ;
		}

		if (_skillInfo.getTargetType() == SKILL_TARGET_TYPE_OWN)
		{
			if (attackPos->destObjUID != rMe->getObjUID())
			{
				return RC_SKILL_NO_USE_ON_OBJ;
			}
		}

		if (_skillInfo.getTargetType() == SKILL_TARGET_TYPE_TEAM)
		{
			if (!rMe->isTeamMember(pChart))
			{
				return RC_SKILL_NO_USE_ON_OBJ;
			}
		}

		if (_skillInfo.getTargetType() == SKILL_TARGET_TYPE_ENEMY)
		{
			if (rMe->isSameCamp(pChart) && !rMe->canAttackTeammer())
			{
				return RC_SKILL_NO_USE_ON_OBJ;
			}

			if (pChart->isSafeZone())
			{
				return RC_SKILL_IN_SAFE_ZONE;
			}

			if (rMe->isSafeZone())
			{
				return RC_SKILL_IN_SAFE_ZONE;
			}
		}

		EGameRetCode retCode = pChart->canAttackMe(rMe);
		if (!IsSuccess(retCode))
		{
			return retCode;
		}
	}

	return RC_SUCCESS;

	FUNC_END(RC_SKILL_NO_USE);
}

EGameRetCode CSkillLogicBase::checkType(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget)
{
	FUNC_BEGIN(SKILL_MOD);

	if (_skillInfo.getTargetType() == SKILL_TARGET_TYPE_OWN)
	{
		if (_skillInfo.getAttackType() != SKILL_ATTACK_TYPE_SINGLE)
		{
			return RC_SKILL_NO_SKILL_TYPE;
		}
	}

	if (_skillInfo.getSkillTypeID() == SKILL_TYPE_PASSIVE)
	{
		//        gxError("Skill type invalid! %s", toString());
		return RC_SKILL_NO_SKILL_TYPE;
	}

	if (_skillInfo.getTargetType() == SKILL_TARGET_TYPE_OWN)
	{
		if (rMe->getObjUID() != attackTarget->destObj->getObjUID())
		{
			//            gxError("Target and attack type not valid! %s", toString());
			return RC_SKILL_NO_ATTACK_AND_TARGET_TYPE;
		}
	}

	return RC_SUCCESS;

	FUNC_END(RC_SKILL_NO_USE);
}

EGameRetCode CSkillLogicBase::checkObj(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget)
{
	FUNC_BEGIN(SKILL_MOD);

	if (_skillInfo.getAttackType() == SKILL_ATTACK_TYPE_SINGLE)
	{
		attackTarget->destObj = rMe->getScene()->getCharacterByUID(attackPos->destObjUID);
		if (NULL == attackTarget->destObj)
		{
			//            gxError("Can't find obj! %s, %s", toString(), _attckMsg.toString());
			return RC_SKILL_NO_DEST_OBJ;
		}

		if (attackTarget->destObj->isDie())
		{
			//            gxError("Dest obj is die! %s, %s", toString(), _attckMsg.toString());
			return RC_SKILL_DEST_OBJ_IS_DIE;
		}
	}

	return RC_SUCCESS;

	FUNC_END(RC_SKILL_NO_USE);
}

EGameRetCode CSkillLogicBase::checkJob(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget)
{
	FUNC_BEGIN(SKILL_MOD);

	if (!_skillInfo.isNeedJobCheck())
	{
		return RC_SUCCESS;
	}

	// 职业检查
	if (_skillInfo.getJob() != rMe->getJob())
	{
		//        gxError("Job not right! %s", toString());
		return RC_SKILL_NO_JOB;
	}

	return RC_SUCCESS;

	FUNC_END(RC_SKILL_NO_USE);
}

EGameRetCode CSkillLogicBase::checkOwer(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget)
{
	FUNC_BEGIN(SKILL_MOD);

	if (rMe->isDie())
	{
		return RC_SKILL_OWN_ISDIE;
	}

	return RC_SUCCESS;

	FUNC_END(RC_SKILL_NO_USE);
}

void CSkillLogicBase::calcHurt(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget)
{
	FUNC_BEGIN(SKILL_MOD);

	loadEffect(rMe, attackPos, attackTarget, rMe, false);

	// 对别人的技能效果
	for (uint32 i = 0; i < attackTarget->attackorList.getAttackObjSize(); ++i)
	{
		CCharacterObject* pCharacter = attackTarget->attackorList.characterList[i];
		if (NULL == pCharacter)
		{
			continue;
		}

		bool goodSkill = false;
		if (rMe->getObjUID() == pCharacter->getObjUID() && _skillInfo.isToSelf())
		{
			// 技能对自身, 肯定命中
			goodSkill = true;
			pCharacter->getCombatResult()->setHit();
		}
		else if (rMe->isSameCamp(pCharacter) && _skillInfo.isToSelf())
		{
			loadEffect(rMe, attackPos, attackTarget, pCharacter, false);
			goodSkill = true;
		}
		else if (!rMe->isSameCamp(pCharacter) && _skillInfo.isToEmeny() || rMe->canAttackTeammer())
		{
			loadEffect(rMe, attackPos, attackTarget, pCharacter, true);
			goodSkill = false;
		}
		else
		{
			gxAssert(false);
		}

		if (needCalcHurt() && rMe->getObjUID() != pCharacter->getObjUID())
		{
			// 对技能接受者使用技能
			if (pCharacter->onBeUseSkill(rMe, attackPos->skilTypeID, goodSkill))
			{
				rMe->onUseSkillSuccess(pCharacter, attackPos->skilTypeID);
			}
		}

		if (pCharacter->getCombatResult()->isHit())
		{
			// 命中对方加上Buff
			pCharacter->appendSkillBuff(rMe, &_skillInfo);
		}
	}

	rMe->onUseSkill(attackPos->skilTypeID, &attackTarget->attackorList.characterList);

	FUNC_END(DRET_NULL);
}

void CSkillLogicBase::showImpact(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget)
{
	FUNC_BEGIN(SKILL_MOD);

	// 对别人的技能效果
	for (uint32 i = 0; i < attackTarget->attackorList.getAttackObjSize(); ++i)
	{
		TAttackorImpact impact;
		CCharacterObject* pCharacter = attackTarget->attackorList.characterList[i];
		if (NULL == pCharacter)
		{
			continue;
		}

		impact.objUID = pCharacter->getObjUID();
		CCombatResult* combatResult = pCharacter->getCombatResult();
		impact.impactType = combatResult->getImpactType();
		if (combatResult->isHit())
		{
			if (pCharacter->getCombatResult()->getMpChanged() > 0)
			{
				impact.attrType = ATTR_CUR_ENERGY;
				impact.hp = pCharacter->getCombatResult()->getMpChanged();
				attackTarget->attackorList.push(&impact);

				// 连续加魔
				TAttackorImpact impact;
				for (sint32 j = 1; j < combatResult->mpChangedAry.size(); ++j)
				{
					impact.objUID = pCharacter->getObjUID();
					impact.impactType = ATTACK_IMPACT_TYPE_NORMAL;
					impact.attrType = ATTR_CUR_ENERGY;
					impact.hp = combatResult->mpChangedAry[j];
					attackTarget->attackorList.push(&impact);
				}
			}
			else
			{
				if (!(rMe->getObjUID() == pCharacter->getObjUID() && 0 == pCharacter->getCombatResult()->getHpChanged()))
				{
					// 统一给自身加血技能或给队友加血技能
					// 加血

					if (rMe->isSameCamp(pCharacter))
					{
						impact.attrType = ATTR_CUR_HP;
						impact.hp = std::max<THp_t>(pCharacter->getCombatResult()->getHpChanged(), 0);
						attackTarget->attackorList.push(&impact);
					}
					else
					{
						impact.attrType = ATTR_CUR_HP;
						impact.hp = pCharacter->getCombatResult()->getHpChanged();
						attackTarget->attackorList.push(&impact);

						if (combatResult->isDoubleHit())
						{
							TAttackorImpact impact;
							// 产生了连击, 把连击效果放入进去
							for (sint32 j = 1; j < combatResult->hpChangedAry.size(); ++j)
							{
								impact.objUID = pCharacter->getObjUID();
								impact.impactType = ATTACK_IMPACT_TYPE_HIT_DOUBLE;
								impact.attrType = ATTR_CUR_HP;
								impact.hp = combatResult->hpChangedAry[j];
								attackTarget->attackorList.push(&impact);
							}
						}
					}
				}
			}
		}
		else if (needCalcHurt())
		{
			impact.hp = 0;
			impact.impactType = ATTACK_IMPACT_TYPE_DODGE;
			attackTarget->attackorList.push(&impact);

			if (rMe->isRole())
			{
				gxDebug("Skill dodge!{0}", rMe->toString());
			}
		}

		pCharacter->onAfterBeSkill();
	}

	if (rMe->isRole())
	{
		attackTarget->attackorList.logImpact();
	}

	rMe->onAfterUseSkill();

	FUNC_END(DRET_NULL);
}

void CSkillLogicBase::doConsume(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget)
{
	FUNC_BEGIN(SKILL_MOD);

	// 魔量消耗
	if (!_skillInfo.needMp.empty())
	{
		TAttrVal_t attrVal = 1;
		TAddAttr& attrs = _skillInfo.needMp[_skillInfo.getLevel()];
		if (attrs.addType == NUMERICAL_TYPE_ODDS)
		{
			attrVal = GXMISC::gxDouble2Int<TAttrVal_t>(rMe->getMaxEnergy()*attrs.attrValue / ((double)MAX_BASE_RATE));
		}
		else
		{
			attrVal = attrs.attrValue;
		}

		rMe->energyChange(0 - attrVal, rMe);
	}

	FUNC_END(DRET_NULL);
}

void CSkillLogicBase::onActivate(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget){}

CSkillLogicBase::CSkillLogicBase(TSkillTypeID_t skillTypeID)
{
}

CSkillLogicBase::~CSkillLogicBase()
{
	cleanUp();
}

void CSkillLogicBase::onBeforeCalcHurt(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget){}
void CSkillLogicBase::onAfterCalcHurt(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget){}
void CSkillLogicBase::onAfterSelectTarget(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget){}

TAxisPos CSkillLogicBase::getAttackPos(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget)
{
	FUNC_BEGIN(SKILL_MOD);

	if (_skillInfo.getAttackType() == SKILL_ATTACK_TYPE_SINGLE)
	{
		// 单体技能
		return *attackTarget->destObj->getAxisPos();
	}
	else
	{
		return attackPos->pos;
	}

	FUNC_END(*rMe->getAxisPos());
}

void CSkillLogicBase::loadEffect(CCharacterObject* rMe, const CAttackPos* attackPos, CAttackTarget* attackTarget, CCharacterObject* rObj, bool des)
{
	FUNC_BEGIN(SKILL_MOD);

	TSkillLevel_t skillLevel = _skillInfo.getLevel();
	if (_skillInfo.getLevel() >= (TSkillLevel_t)_skillInfo.effects.size())
	{
		return;
	}

	for (uint32 i = 0; i < _skillInfo.effects[skillLevel].size(); ++i)
	{
		TExtendAttr& effect = _skillInfo.effects[skillLevel][i];
		if (effect.attrValue < 0 && des)
		{
			// 负的技能效果是对敌方
			if (isDirectAddAttr(effect.attrType))
			{
				THp_t hp = addDirectAttr(rMe, attackPos, attackTarget, rObj, &effect);
				if (hp < 0)
				{
					TAttackorImpact impact;
					impact.objUID = rObj->getObjUID();
					impact.attrType = effect.attrType;
					impact.hp = hp;
					impact.impactType = ATTACK_IMPACT_TYPE_NORMAL;
					attackTarget->attackorList.push(&impact);

					rObj->onHurt(impact.hp, rMe->getObjUID());
				}
			}
			else
			{
				rObj->getSkillAttr()->addValue(effect);
			}
		}
		else if (effect.attrValue > 0 && !des)
		{
			// 正的技能效果是对已方
			if (isDirectAddAttr(effect.attrType) && (_skillInfo.isSingle() && attackTarget->destObj->getObjUID() == rObj->getObjUID()
				|| !_skillInfo.isSingle()))
			{
				// 直接添加的效果, 并且要冒血效果
				THp_t hp = addDirectAttr(rMe, attackPos, attackTarget, rObj, &effect);
				if (hp > 0)
				{
					TAttackorImpact impact;
					impact.objUID = rObj->getObjUID();
					impact.attrType = effect.attrType;
					impact.hp = hp;
					impact.impactType = ATTACK_IMPACT_TYPE_NORMAL;
					attackTarget->attackorList.push(&impact);
				}
			}
			else
			{
				rObj->getSkillAttr()->addValue(effect);
			}
		}
	}

	FUNC_END(DRET_NULL);
}

uint8 CSkillLogicBase::getMaxAttackNum()
{
	return MAX_ATTACKOR_NUM;
}

bool CSkillLogicBase::isDirectAddAttr(TAttrType_t attrType)
{
	switch (attrType)
	{
	case ATTR_CUR_HP:
	case ATTR_CUR_ENERGY:
	{
		return true;
	}
	default:
	{
		return false;
	}
	}

	return false;
}

TAttrVal_t CSkillLogicBase::addDirectAttr(CCharacterObject* rMe, const CAttackPos* attackPos, 
	CAttackTarget* attackTarget, CCharacterObject* rObj, TExtendAttr* attr)
{
	TAttrVal_t oldValue = rObj->getAttrValue(attr->attrType);
	if (attr->isRate())
	{
		TAttrVal_t val = rObj->getAttrValue(attr->attrType);
		double incVal = ((double)val*attr->attrValue) / MAX_BASE_RATE;
		TAttrVal_t result = GXMISC::gxDouble2Int<TAttrVal_t>(incVal);
		rObj->addAttrValue(attr->attrType, result);
	}
	else
	{
		rObj->addAttrValue(attr->attrType, attr->attrValue);
	}
	TAttrVal_t newValue = rObj->getAttrValue(attr->attrType);
	return newValue - oldValue;
}

bool CSkillLogicBase::needCalcHurt()
{
	return _skillInfo.getEffectSize() > 0;
}

bool CSkillLogicBase::onLoad(CCharacterObject* rMe, const CAttackPos* pos)
{
	return true;
}

void CSkillLogicManager::initSkills()
{
	FUNC_BEGIN(SKILL_MOD);

	memset(&_skillLogics, 0, sizeof(_skillLogics));
// 
// 	// 华山派
// 	_skillLogics[101] = new CSkillLogicBase(101);
// 	_skillLogics[102] = new CSkillLogicBase(102);
// 	_skillLogics[103] = new CSkillLogicBase(103);
// 	_skillLogics[104] = new CSkillLogic104(104);
// 	_skillLogics[105] = new CSkillLogic105(105);
// 	_skillLogics[106] = new CSkillLogicBase(106);
// 	_skillLogics[107] = new CSkillLogicBase(107);
// 	_skillLogics[108] = new CSkillLogicBase(108);
// 	_skillLogics[109] = new CSkillLogicBase(109);
// 	_skillLogics[110] = new CSkillLogicBase(110);
// 	_skillLogics[111] = new CSkillLogicBase(111);
// 	_skillLogics[112] = new CSkillLogicBase(112);
// 	_skillLogics[113] = new CSkillLogicBase(113);
// 	_skillLogics[114] = new CSkillLogic114(114);
// 	_skillLogics[115] = new CSkillLogic115(115);
// 
// 	// 日月神教
// 	_skillLogics[201] = new CSkillLogicBase(201);
// 	_skillLogics[202] = new CSkillLogicBase(202);
// 	_skillLogics[203] = new CSkillLogicBase(203);
// 	_skillLogics[204] = new CSkillLogicBase(204);
// 	_skillLogics[205] = new CSkillLogicBase(205);
// 	_skillLogics[206] = new CSkillLogicBase(206);
// 	_skillLogics[207] = new CSkillLogicBase(207);
// 	_skillLogics[208] = new CSkillLogicBase(208);
// 	_skillLogics[209] = new CSkillLogicBase(209);
// 	_skillLogics[210] = new CSkillLogicBase(210);
// 	_skillLogics[211] = new CSkillLogicBase(211);
// 	_skillLogics[212] = new CSkillLogicBase(212);
// 	_skillLogics[213] = new CSkillLogic213(213);
// 	_skillLogics[214] = new CSkillLogic214(214);
// 	_skillLogics[215] = new CSkillLogic115(215);
// 
// 	// 五仙教
// 	_skillLogics[301] = new CSkillLogicBase(301);
// 	_skillLogics[302] = new CSkillLogicBase(302);
// 	_skillLogics[303] = new CSkillLogicBase(303);
// 	_skillLogics[304] = new CSkillLogicBase(304);
// 	_skillLogics[305] = new CSkillLogicBase(305);
// 	_skillLogics[306] = new CSkillLogicBase(306);
// 	_skillLogics[307] = new CSkillLogicBase(307);
// 	_skillLogics[308] = new CSkillLogicBase(308);
// 	_skillLogics[309] = new CSkillLogicBase(309);
// 	_skillLogics[310] = new CSkillLogicBase(310);
// 	_skillLogics[311] = new CSkillLogicBase(311);
// 	_skillLogics[312] = new CSkillLogicBase(312);
// 	_skillLogics[313] = new CSkillLogicBase(313);
// 	_skillLogics[314] = new CSkillLogic314(314);
// 	_skillLogics[315] = new CSkillLogicBase(315);
// 	_skillLogics[316] = new CSkillLogic115(316);
// 
// 	// 怪物技能
// 	_skillLogics[501] = new CSkillLogicBase(501);
// 	_skillLogics[502] = new CSkillLogicBase(502);
// 	_skillLogics[503] = new CSkillLogicBase(503);
// 	_skillLogics[504] = new CSkillLogicBase(504);
// 	_skillLogics[505] = new CSkillLogicBase(505);
// 	_skillLogics[506] = new CSkillLogicBase(506);
// 	_skillLogics[507] = new CSkillLogicBase(507);
// 	_skillLogics[508] = new CSkillLogicBase(508);
// 	_skillLogics[509] = new CSkillLogic509(509);
// 	_skillLogics[510] = new CSkillLogic509(510);
// 	_skillLogics[511] = new CSkillLogicBase(511);
// 	_skillLogics[512] = new CSkillLogicBase(512);
// 	_skillLogics[513] = new CSkillLogicBase(513);
// 	_skillLogics[514] = new CSkillLogicBase(514);
// 	_skillLogics[515] = new CSkillLogic515(515);
// 	_skillLogics[516] = new CSkillLogicBase(516);
// 	_skillLogics[517] = new CSkillLogicBase(517);
// 	_skillLogics[518] = new CSkillLogicBase(518);
// 	_skillLogics[519] = new CSkillLogic519(519);
// 	_skillLogics[520] = new CSkillLogic519(520);
// 	_skillLogics[521] = new CSkillLogicBase(521);
// 	_skillLogics[522] = new CSkillLogicBase(522);
// 	_skillLogics[523] = new CSkillLogicBase(523);
// 	_skillLogics[524] = new CSkillLogicBase(524);
// 
// 	// 宠物技能
// 	_skillLogics[601] = new CSkillLogicBase(601);
// 	_skillLogics[602] = new CSkillLogicBase(602);
// 	_skillLogics[603] = new CSkillLogicBase(603);
// 	_skillLogics[604] = new CSkillLogicBase(604);
// 	_skillLogics[605] = new CSkillLogicBase(605);
// 	_skillLogics[606] = new CSkillLogicBase(606);
// 	_skillLogics[607] = new CSkillLogicBase(607);
// 	_skillLogics[608] = new CSkillLogicBase(608);
// 	_skillLogics[609] = new CSkillLogicBase(609);
// 	_skillLogics[610] = new CSkillLogicBase(610);
// 	_skillLogics[611] = new CSkillLogicBase(611);
// 	_skillLogics[612] = new CSkillLogicBase(612);
// 	_skillLogics[613] = new CSkillLogicBase(613);
// 	_skillLogics[614] = new CSkillLogic614(614);
// 	_skillLogics[615] = new CSkillLogicBase(615);
// 	_skillLogics[616] = new CSkillLogicBase(616);
// 	_skillLogics[617] = new CSkillLogic617(617);
// 	_skillLogics[618] = new CSkillLogic618(618);

	FUNC_END(DRET_NULL);
}

CSkillLogicBase* CSkillLogicManager::getSkillLogic(TSkillTypeID_t skillID)
{
	FUNC_BEGIN(SKILL_MOD);

	if (skillID >= 0 && skillID < MAX_SKILL_ID)
	{
		return _skillLogics[skillID];
	}

	return NULL;

	FUNC_END(NULL);
}
