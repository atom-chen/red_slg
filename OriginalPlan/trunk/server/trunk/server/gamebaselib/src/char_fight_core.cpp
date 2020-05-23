#include "char_fight_core.h"
#include "obj_character.h"
#include "skill_core.h"
#include "char_attribute_core.h"
#include "map_scene_base.h"
#include "map_data_base.h"
#include "game_config.h"
#include "ai_character.h"
#include "buffer_manager_base.h"
#include "packet_cm_fight.h"


THp_t CCombatResult::getHpChanged()
{
	return hpChangedAry[0];
}

void CCombatResult::setHpChanged(THp_t hp)
{
	hpChangedAry[0] = hp;
}

THp_t CCombatResult::addHpChanged(THp_t hp)
{
	hpChangedAry[0] += hp;
	return hpChangedAry[0];
}

void CCombatResult::setHit()
{
	hit = true;
}

bool CCombatResult::isHit()
{
	return hit;
}

bool CCombatResult::isDoubleHit()
{
	return hpChangedAry.size() > 1;
}

void CCombatResult::cleanUp()
{
	impactType = INVALID_ATTACK_IMPACT_TYPE;
	hit = false;
	doubleHit = false;
	hpChangedAry.assign(0, 1);
	mpChangedAry.assign(0, 1);
}

void CCombatResult::pushDoubleHitHp(THp_t hp)
{
	doubleHit = true;
	hpChangedAry.pushBack(hp);
}

EAttackImpactType CCombatResult::getImpactType()
{
	return impactType;
}

bool CCombatResult::isHitBack()
{
	return false;
}

bool CCombatResult::isCrit()
{
	return impactType == ATTACK_IMPACT_TYPE_CRIT;
}

void CCombatResult::setImpactType(EAttackImpactType type)
{
	impactType = type;
	combatState.set(type);
}

void CCombatResult::setParam(sint32 index, sint32 paramVal)
{
	paramAry[index] = paramVal;
}

THp_t CCombatResult::getMpChanged()
{
	return mpChangedAry[0];
}

void CCombatResult::setMpChanged(TMp_t mp)
{
	mpChangedAry[0] = mp;
}

bool CCombatTempData::canAttackTeammer()
{
	return (DTimeManager.nowSysTime() - lastUseSkillTime) < g_GameConfig.randKillRoleStateTime && result.combatState.get(ATTACK_IMPACT_TYPE_RAND_ATTACK_ROLE);
}

void CCharFightCore::cleanUp()
{
	_lastHurtMeObjUID = INVALID_OBJ_UID;
	_lastHurtMeObjType = INVALID_OBJ_TYPE;
	_lastHurtOtherObjUID = INVALID_OBJ_UID;
	_lastHurtOtherObjType = INVALID_OBJ_TYPE;
	_banAction.cleanUp();
	_skillCoolDown.reset();
	_skillCommCoolDown.reset();
	_assistantID = INVALID_OBJ_UID;
	_lastAttackMeTime = GXMISC::MAX_GAME_TIME;
	_lastAttackOtherTime = GXMISC::MAX_GAME_TIME;
	_lastAttackDieOtherObjUID = INVALID_OBJ_UID;
	_combatState = COMBAT_STATE_TYPE_END;
	_character = NULL;
}

bool CCharFightCore::init( const TCharacterInit* inits )
{
	if(inits->die)
	{
		clearActionBan(ACTION_BAN_LIVE);
	}
	else
	{
		setActionBan(ACTION_BAN_LIVE);
	}

	return true;
}

bool CCharFightCore::update( GXMISC::TDiffTime_t diff )
{
	_skillCoolDown.heartBeat(diff);
	_skillCommCoolDown.heartBeat(diff);

	return true;
}

bool CCharFightCore::updateOutBlock( GXMISC::TDiffTime_t diff )
{
	return true;
}

void CCharFightCore::setCharacter(CCharacterObject* character)
{
	_character = character;
}

CCharSkillCore* CCharFightCore::getSkillCore()
{
	return _character;
}

// CBufferManagerBase* CCharFightCore::getBufferMgr()
// {
// 	return _bufferMgr;
// }

bool CCharFightCore::getActionBan(EActionBan banType) const
{
	return _banAction.getState(banType);
}

TObjActionBan_t* CCharFightCore::getActionBan() const
{
	return (TObjActionBan_t*)_banAction.getState();
}

void CCharFightCore::setActionBan(EActionBan banType)
{
	_banAction.setValue(banType, true); onActionBanChange(banType);
}

void CCharFightCore::clearActionBan(EActionBan banType)
{
	_banAction.setValue(banType, false); onActionBanChange(banType);
}

EGameRetCode CCharFightCore::checkAction(bool moveFlag, bool useSkillFlag, bool beAttackFlag)
{
	if (moveFlag && !canMove())
	{
		return RC_LIMIT_MOVE;
	}

	if (useSkillFlag && !canUseSkill())
	{
		return RC_SKILL_NO_USE_SKILL;
	}

	if (beAttackFlag && canBeAttack())
	{
		return RC_SKILL_NO_BE_ATTACK;
	}

	return RC_SUCCESS;
}


bool CCharFightCore::canUseSkill()
{
	return !_banAction.getValue(ACTION_BAN_ATTACK) && !_character->getBufferManager()->getBuffAttrs()->actionBanFlags.getValue(ACTION_BAN_ATTACK);
}

bool CCharFightCore::canMove()
{
	return !_banAction.getValue(ACTION_BAN_MOVE) && !_character->getBufferManager()->getBuffAttrs()->actionBanFlags.getValue(ACTION_BAN_MOVE);
}

bool CCharFightCore::canBeAttack()
{
	return !_banAction.getValue(ACTION_BAN_UNBE_ATTACK) && !_character->getBufferManager()->getBuffAttrs()->actionBanFlags.getValue(ACTION_BAN_UNBE_ATTACK);
}

bool CCharFightCore::canBeUseItem()
{
	return !_banAction.getValue(ACTION_BAN_USE_ITEM) && !_character->getBufferManager()->getBuffAttrs()->actionBanFlags.getValue(ACTION_BAN_USE_ITEM);
}

void CCharFightCore::setUnBeAttack(bool flag /*= false*/)
{
	_banAction.setValue(ACTION_BAN_UNBE_ATTACK, flag);
}

EGameRetCode CCharFightCore::canAttackMe(CCharacterObject* pCharacter)
{
	if (!_banAction.getValue(ACTION_BAN_UNBE_ATTACK) && !_character->getBufferManager()->getBuffAttrs()->actionBanFlags.getValue(ACTION_BAN_UNBE_ATTACK))
	{
		return RC_SUCCESS;
	}

	return RC_SKILL_NO_BE_ATTACK;
}

void CCharFightCore::logState()
{
	//     std::string logStr = "State:";
	// 
	//     if(getState(OBJ_STATE_TEAM))
	//     {
	//         logStr += "(Team);";
	//     }
	//     if(getState(OBJ_STATE_LEADER))
	//     {
	//         logStr += "(TeamLeader);";
	//     }
	// 
	//     gxDebug("%s", logStr.c_str());
}

void CCharFightCore::logActionBan()
{
	// 	std::string logStr = "ActionBan:";
	// 	if(!getActionBan(ACTION_BAN_LIVE))
	// 	{
	// 		logStr += "(Die);";
	// 	}
	// 	else
	// 	{
	// 		logStr += "(Live);";
	// 	}
	// 
	// 	gxDebug("%s", logStr.c_str());
}

bool CCharFightCore::relive(TReliveInfo* reliveInfo, CCharacterObject* pChart)
{
	setReliveInfo(reliveInfo);
	if (NULL != _character->getCharacterAI())
	{
		_character->getCharacterAI()->relive(pChart);
	}

	return true;
}

TReliveInfo* CCharFightCore::getReliveInfo()
{
	return &_reliveInfo;
}

void CCharFightCore::setReliveInfo(TReliveInfo* reliveInfo)
{
	if (reliveInfo)
	{
		_reliveInfo = *reliveInfo;
	}
	else
	{
		_reliveInfo.reset();
	}
}

void CCharFightCore::resetReliveInfo()
{
	_reliveInfo.reset();
}

EGameRetCode CCharFightCore::useSkill(TObjUID_t destObjUID, TSkillTypeID_t skillTypeID, TAxisPos_t x, TAxisPos_t y)
{
	// 技能使用后事件
	EGameRetCode retCode = _character->use(destObjUID, skillTypeID, x, y);
	if (IsSuccess(retCode))
	{
		_character->onAfterUse();
		return RC_SUCCESS;
	}

	return retCode;
}

void CCharFightCore::onAfterUseSkill()
{
	CSkillInfo* skillInfo = _character->getSkillLogicBase()->getSkillInfo();
	GXMISC::TDiffTime_t cd = skillInfo->getCD();
	_skillCoolDown.registerCooldown(skillInfo->getSkillTypeID(), cd);
	_skillCommCoolDown.registerCooldown(SKILL_COMM_COOL_DOWN_ID, skillInfo->getCommCD());
	_combatTempData.reset();
	_combatTempData.lastUseSkillTime = DTimeManager.nowSysTime();
}

void CCharFightCore::onAfterBeSkill()
{
	_combatTempData.reset();
}

void CCharFightCore::cleanLastCombatData()
{
	_combatTempData.result.combatState.clearAll();
}

bool CCharFightCore::canAttackTeammer()
{
	return _combatTempData.canAttackTeammer();
}

void CCharFightCore::attackBack(TDir_t dir, TRange_t range)
{
	static const TAdjust DirAdjust[8] =
	{
		{ 0, -1 },
		{ 1, -1 },
		{ 1, 0 },
		{ 1, 1 },
		{ 0, 1 },
		{ -1, 1 },
		{ -1, 0 },
		{ -1, -1 }
	};

	bool canHitBack = true;
	for (sint32 i = range; i > 0; --i)
	{
		TAxisPos hitBackPos = *_character->getAxisPos();
		hitBackPos.x += DirAdjust[dir].x*i;
		hitBackPos.y += DirAdjust[dir].y*i;
		if (!_character->getScene()->getMapData()->isCanWalk(&hitBackPos))
		{
			canHitBack = false;
		}
	}

	if (canHitBack)
	{
		TAxisPos hitBackPos = *_character->getAxisPos();
		hitBackPos.x += DirAdjust[dir].x*range;
		hitBackPos.y += DirAdjust[dir].y*range;
		_character->resetPos(&hitBackPos, RESET_POS_TYPE_HIT_BACK, true, false);
	}
}

TObjUID_t CCharFightCore::getLastHurtMeObjUID()
{
	return _lastHurtMeObjUID;
}

TObjUID_t CCharFightCore::getLastHurtOtherObjUID()
{
	return _lastHurtOtherObjUID;
}

EObjType CCharFightCore::getLastHurtMeObjType()
{
	return _lastHurtMeObjType;
}

EObjType CCharFightCore::getLastHurtOtherObjType()
{
	return _lastHurtOtherObjType;
}

void CCharFightCore::setLastHurtOtherObjUID(TObjUID_t objUID)
{
	_lastHurtOtherObjUID = objUID;
}

void CCharFightCore::setLastHurtOtherObjType(EObjType objType)
{
	_lastHurtOtherObjType = objType;
}

bool CCharFightCore::canHit(CCharacterObject* character)
{
	assert(false);
	return false;

// 	double hitRate = (double)character->getFightHit() / (character->getFightHit() + getFightDodge()) + 0.5;
// 	hitRate = hitRate * 100;
// 	THit_t hitValue = GXMISC::gxDouble2Int<THit_t>(hitRate);
// 	return DRandGen.randOdds(100, hitValue);
}

bool CCharFightCore::canCrit()
{
	double critOdds = _character->getFightCrit() / 500.00;
	TCrit_t critValues = GXMISC::gxDouble2Int<TCrit_t>(critOdds * 100);
	return DRandGen.randOdds(MAX_BASE_RATE, critValues + _character->getSkillAttr()->getAppendCritRate());
}

TObjUID_t CCharFightCore::getAssistantUID()
{
	return _assistantID;
}

void CCharFightCore::setLastAttackMeTime(GXMISC::TGameTime_t curTime)
{
	_lastAttackMeTime = curTime;
}

GXMISC::TGameTime_t CCharFightCore::getLastAttackMeTime()
{
	return _lastAttackMeTime;
}

void CCharFightCore::setLastAttackDieObjUID(TObjUID_t objUID)
{
	_lastAttackDieOtherObjUID = objUID;
}

TObjUID_t CCharFightCore::getLastAttackDieObjUID()
{
	return _lastAttackDieOtherObjUID;
}

CCombatResult* CCharFightCore::getCombatResult()
{
	return &_combatTempData.result;
}

void CCharFightCore::appendSkillBuff(CCharacterObject* rMe, CSkillInfo* skillInfo)
{
	if (_character->isDie())
	{
		return;
	}

	TSkillLevel_t level = rMe->getSkillLevel(skillInfo->getSkillTypeID()) - 1;
	level = std::max(level, (TSkillLevel_t)0);
	if (level >= (TSkillLevel_t)skillInfo->buffOdds.size())
	{
		return;
	}

	if (INVALID_BUFFER_TYPE_ID != skillInfo->buffEffectID && DRandGen.randOdds(MAX_BASE_RATE, skillInfo->buffOdds[level]))
	{
		// 技能Buff产生
		CSkillBuff skillBuff;
		skillBuff.casterObjUID = rMe->getObjUID();
		skillBuff.casterObjGUID = rMe->getObjGUID();
		skillBuff.casterType = rMe->getObjType();
		skillBuff.buffTypeID = skillInfo->buffEffectID;
		skillBuff.skillID = skillInfo->getSkillTypeID();
		skillBuff.level = level + 1;
		_character->getBufferManager()->addEffect(&skillBuff, true);

		if (skillInfo->targetType == SKILL_TARGET_TYPE_TEAM)
		{
			_assistantID = rMe->getObjUID();
		}
		else if (skillInfo->targetType == SKILL_TARGET_TYPE_ENEMY)
		{
			assert(false); // @TODO
// 			if (isMonster())
// 			{
// 				//CMonster* pMonster = this->toMonster();
// 				//pMonster->getMonsterAI()->addEnemy(rMe->getObjUID(), 0);
// 				_character->getAI()->onAddEnemy(rMe->getObjUID(), 0);
// 			}
		}
	}
}

void CCharFightCore::calcHurt(CCharacterObject* pCharacter, CSkillInfo* pSkillInfo)
{
// 	//1. 普通伤害
// 	double totalHurt = 0.0;
// 	double dymicRate = DRandGen.getRand(145, 150) / 100.00;
// 	if (pCharacter->isMagicJob())
// 	{
// 		double magicAttack = pCharacter->getFightMagicAttack();
// 		if (!isPet())
// 		{
// 			totalHurt = (magicAttack*magicAttack) / (magicAttack + getFightMagicDefense())*dymicRate;
// 		}
// 		else
// 		{
// 			totalHurt = (magicAttack*magicAttack) / (magicAttack + getFightPhysicDefense())*dymicRate;
// 		}
// 	}
// 	else
// 	{
// 		double physicAttack = pCharacter->getFightPhysicAttack();
// 		totalHurt = (physicAttack*physicAttack) / (physicAttack + getFightPhysicDefense())*dymicRate;
// 	}
// 
// 	//2. 技能伤害百分比
// 	totalHurt = (totalHurt*(pCharacter->getFightSkillHurtRate() + MAX_BASE_RATE)) / MAX_BASE_RATE;
// 
// 	//3. 暴击百分比
// 	TSkillAttr critAttr;
// 	critAttr.cleanUp();
// 	if (pCharacter->canCrit() || getCombatResult().isCrit())
// 	{
// 		critAttr.addRate(15000);
// 		critAttr.addValue(pCharacter->getFightCritHurt());
// 		critAttr.addRate(pCharacter->getFightCritHurtRate());
// 
// 		_combatTempData.result.setImpactType(ATTACK_IMPACT_TYPE_CRIT);
// 		gxDebug("You are be crit!");
// 	}
// 	else
// 	{
// 		_combatTempData.result.setImpactType(ATTACK_IMPACT_TYPE_NORMAL);
// 	}
// 
// 	if (critAttr.getRate() > 0)
// 	{
// 		totalHurt *= critAttr.getRate();
// 		totalHurt /= MAX_BASE_RATE;
// 	}
// 
// 	//4. 固定暴击倍数, 只有在技能中才有
// 	TSkillAttr fixCritHurt = pCharacter->getSkillAttr().getFixCritHurt();
// 	if (fixCritHurt.getRate() > 0)
// 	{
// 		totalHurt *= fixCritHurt.getRate();
// 		totalHurt /= MAX_BASE_RATE;
// 	}
// 
// 	//5. 固定暴击伤害
// 	if (fixCritHurt.getValue() > 0)
// 	{
// 		totalHurt += fixCritHurt.getValue();
// 	}
// 
// 	//6. 等级压制
// 	totalHurt -= getLevel();
// 
// 	//7. 修正至少出现1点血
// 	CGameMisc::RefixValue(totalHurt, 1);
// 
// 	//8. 技能伤害值
// 	totalHurt += pCharacter->getFightSkillHurt();
// 
// 	//9. 减少自身血量
// 	THp_t hps = GXMISC::gxDouble2Int<THp_t>(totalHurt);
// 
// 	if (getBufferMgr().isReflectEvt() && hps > 0)
// 	{
// 		// 反弹状态
// 		hpChange(hps, pCharacter);
// 		_combatTempData.result.setHpChanged(hps);
// 	}
// 	else
// 	{
// 		_combatTempData.result.setHpChanged(hpChange(0 - hps, pCharacter));
// 	}
}

bool CCharFightCore::isSkillCoolDown(TSkillTypeID_t skillID)
{
	return _skillCoolDown.isCooldowned(skillID) && _skillCommCoolDown.isCooldowned(SKILL_COMM_COOL_DOWN_ID);
}

bool CCharFightCore::isCommonSkillCdDown(TSkillTypeID_t skillID)
{
	return _skillCommCoolDown.isCooldowned(SKILL_COMM_COOL_DOWN_ID);
}

bool CCharFightCore::isCombatStart()
{
	return _combatState == COMBAT_STATE_TYPE_START;
}

bool CCharFightCore::isCombatEnd()
{
	return _combatState == COMBAT_STATE_TYPE_END;
}

ECombatStateType CCharFightCore::getCombatState()
{
	return _combatState;
}

EGameRetCode CCharFightCore::onBeforeHit(CCharacterObject* character)
{
	return RC_SUCCESS;
}

void CCharFightCore::onDie()
{
	clearActionBan(ACTION_BAN_LIVE);
	_lastDieTime = DTimeManager.nowSysTime();
	CCharacterObject* pChart = _character->getScene()->getCharacterByUID(_lastHurtMeObjUID);
	if (NULL != pChart)
	{
		pChart->setLastAttackDieObjUID(_character->getObjUID());
	}
	if (_character->getCharacterAI())
	{
		_character->getCharacterAI()->onDie(pChart);
	}
	_character->getBufferManager()->clearActiveEffect();
	_character->clearAllApproachMon();
}

void CCharFightCore::onHurt(THp_t hp, TObjUID_t objUID)
{
	// AI调用

	_lastHurtMeObjUID = objUID;
	_lastHurtMeObjType = _character->getObjType();

	CCharacterObject* pDestObj = _character->getScene()->getCharacterByUID(objUID);
	if (NULL == pDestObj)
	{
		return;
	}

	pDestObj->onStartAttackOther(_character);
	if (NULL != _character->getCharacterAI())
	{
		_character->getCharacterAI()->onHurt(hp, pDestObj);
	}

	if (_character->getHp() <= 0)
	{
		onDie();
		pDestObj->onKillObject(_character);
	}

	if (pDestObj->isMonster() && !_character->isDie())
	{
		_character->addApproachMon(objUID, ADD_APPROACH_MON_TYPE_DAMAGE);
	}

	pDestObj->setLastHurtOtherObjUID(_character->getObjUID());
	pDestObj->onAttackChart(_character);

	pDestObj->onAfterAttackOther(_character);
}

void CCharFightCore::onUseSkillSuccess(CCharacterObject* attackor, TSkillTypeID_t skill)
{
}

bool CCharFightCore::onBeUseSkill(CCharacterObject* attackor, TSkillTypeID_t skillID, bool goodSkill)
{
	_combatTempData.skillTypeID = skillID;
	_combatTempData.attackorUID = attackor->getObjUID();

	CSkillLogicBase* pSkillBase = DSkillLogicManager.getSkillLogic(skillID);
	CSkillInfo* pSkillInfo = pSkillBase->getSkillInfo();
	if (NULL == pSkillInfo)
	{
		gxWarning("Can't find skill row!SkillID={0}", skillID);
		return false;
	}

	if (_character->getCharacterAI() && !_character->isDie())
	{
		_character->getCharacterAI()->onBeSkill(attackor, goodSkill);
	}

	if (!goodSkill)
	{
		// 伤害攻击技能(如果有睡眠状态则直接解除)
		if (_character->getBufferManager()->isSleepEvt())
		{
			_character->getBufferManager()->onBeUseSkill(attackor);
		}

		if (!canHit(attackor))
		{
			return false;
		}

		// 命中对方直接
		_combatTempData.result.setHit();
		calcHurt(attackor, pSkillInfo);
		// 	logTotalAttr(true);
		// 	logCombatResult(true);   
	}
	else
	{
		// 辅助技能
		_combatTempData.result.setHit();
		if (attackor->getObjUID() != _character->getObjUID())
		{
			// 为他人使用辅助技能
			_assistantID = attackor->getObjUID();
			CCharacterObject* pCurEnemy = _character->getScene()->getCharacterByUID(_lastHurtOtherObjUID);
			if (NULL != pCurEnemy && !pCurEnemy->isDie() && pCurEnemy->isMonster() && pCurEnemy->isInValidRadius(attackor, g_GameConfig.getSameScreenRadius()))
			{
				// 辅助技能会造成敌人的仇恨增加
				pCurEnemy->getCharacterAI()->onAddEnemy(attackor->getObjUID(), g_GameConfig.useAssistSkillAddHate);
			}
			pCurEnemy = _character->getScene()->getCharacterByUID(_lastHurtMeObjUID);
			if (NULL != pCurEnemy && !pCurEnemy->isDie() && pCurEnemy->isMonster() && pCurEnemy->isInValidRadius(attackor, g_GameConfig.getSameScreenRadius()))
			{
				// 辅助技能会造成敌人的仇恨增加
				pCurEnemy->getCharacterAI()->onAddEnemy(attackor->getObjUID(), g_GameConfig.useAssistSkillAddHate);
			}
		}
	}

	return true;
}

bool CCharFightCore::onUseSkill(TSkillTypeID_t skill, TImpactCharacterList* impactObjs)
{
	// 附加自身的血量变化
	_combatTempData.result.addHpChanged(_character->hpChange(_combatTempData.skillAttr.valueAttr.getHp(), _character));

	return true;
}

void CCharFightCore::onRelive(TObjUID_t caster)
{
	setActionBan(ACTION_BAN_LIVE);

	_lastDieTime = GXMISC::MAX_GAME_TIME;
	_lastReliveTime = DTimeManager.nowSysTime();
}

void CCharFightCore::onKillObject(CCharacterObject* pDestObj)
{
	pDestObj->onBeKill(_character);
	if (NULL != _character->getCharacterAI())
	{
		_character->getCharacterAI()->onKillObject(pDestObj);
	}
}

void CCharFightCore::onBeKill(CCharacterObject* pDestObj)
{
}

void CCharFightCore::onAttackChart(CCharacterObject* pDestObj)
{
	pDestObj->setLastAttackMeTime(DTimeManager.nowSysTime());
	_lastAttackOtherTime = DTimeManager.nowSysTime();
}

void CCharFightCore::onStateChange()
{
	//    gxDebug("state change!");
	logState();
}

void CCharFightCore::onActionBanChange(EActionBan actionBan)
{
	MCObjActionBan objState;
	objState.objUID = _character->getObjUID();
	objState.state = *getActionBan();

	if (actionBan == ACTION_BAN_LIVE)
	{
		_character->getScene()->broadCast(objState, _character, true, g_GameConfig.broadcastRange);
	}
	else if (_character->isRole())
	{
		CRoleBase* pRole = _character->getRoleBaseOwner();
		if (NULL != pRole)
		{
			pRole->sendPacket(objState);
		}
	}

	logActionBan();
}


bool CCharFightCore::combatStart()
{
	if (_combatState != COMBAT_STATE_TYPE_START)
	{
		ECombatStateType combatState = _combatState;
		_combatState = COMBAT_STATE_TYPE_START;
		onCombatChange(combatState, COMBAT_STATE_TYPE_START);
	}

	return true;
}

bool CCharFightCore::combatEnd()
{
	if (_combatState != COMBAT_STATE_TYPE_END)
	{
		ECombatStateType combatState = _combatState;
		_combatState = COMBAT_STATE_TYPE_END;
		onCombatChange(combatState, COMBAT_STATE_TYPE_END);
	}

	return true;
}

void CCharFightCore::onCombatStart()
{

}

void CCharFightCore::onCombatEnd()
{

}

void CCharFightCore::onCombatChange(ECombatStateType beforeState, ECombatStateType curState)
{
	if (curState == COMBAT_STATE_TYPE_START)
	{
		onCombatStart();
	}
	else if (curState == COMBAT_STATE_TYPE_END)
	{
		onCombatEnd();
	}
}

void CCharFightCore::onStartAttackOther(CCharacterObject* pDestObj)
{
	pDestObj->onStartBeAttack(_character);
}

void CCharFightCore::onStartBeAttack(CCharacterObject* pDestObj)
{
	//	combatStart();
}

void CCharFightCore::onAfterAttackOther(CCharacterObject* pDestObj)
{
	pDestObj->onAfterBeAttack(_character);
	if (!pDestObj->isDie())
	{
		combatStart();
	}
}

void CCharFightCore::onAfterBeAttack(CCharacterObject* pDestObj)
{
	if (!_character->isDie())
	{
		combatStart();
	}
}
