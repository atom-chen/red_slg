#include "char_skill_core.h"
#include "skill_core.h"
#include "obj_character.h"
#include "game_exception.h"
#include "module_def.h"
#include "game_config.h"
#include "map_scene_base.h"

void CCharSkillCore::cleanUp()
{

}

bool CCharSkillCore::init(const TCharacterInit* inits)
{
	setCommSkillID(inits->commSkillID, inits->commSkillLevel);
	return true;
}

bool CCharSkillCore::update(GXMISC::TDiffTime_t diff)
{
	return true;
}

bool CCharSkillCore::updateOutBlock(GXMISC::TDiffTime_t diff)
{
	return true;
}

EGameRetCode CCharSkillCore::use(TObjUID_t destObjUID, TSkillTypeID_t skillTypeID, TAxisPos_t x, TAxisPos_t y)
{
	_attckMsg.destObjUID = destObjUID;
	_attckMsg.skilTypeID = skillTypeID;
	_attckMsg.pos.x = x;
	_attckMsg.pos.y = y;

	_skillLogic = DSkillLogicManager.getSkillLogic(skillTypeID);
	if (NULL == _skillLogic)
	{
		return RC_SKILL_NO_USE;
	}

	if (NULL == _character->getScene())
	{
		return RC_SKILL_NO_DISTANCE;
	}

	if (!_character->canBeAttack())
	{
		_character->clearActionBan(ACTION_BAN_UNBE_ATTACK);
	}

	EGameRetCode retCode = RC_SKILL_NO_USE_SKILL;
	retCode = _skillLogic->load(_character, &_attckMsg);
	if (!IsSuccess(retCode))
	{
		clean();
		return retCode;
	}

	retCode = onBeforeUse();
	if (!IsSuccess(retCode))
	{
		return retCode;
	}

	if (_skillLogic->getSkillInfo()->isUseOwner() && _character->isMonster())
	{
		_attckMsg.destObjUID = _character->getObjUID();
		_attckMsg.skilTypeID = skillTypeID;
		_attckMsg.pos.x = _character->getAxisPos()->x;
		_attckMsg.pos.y = _character->getAxisPos()->y;
	}

	retCode = _skillLogic->check(_character, &_attckMsg, &_attackTarget);
	if (!IsSuccess(retCode))
	{
		clean();
		return retCode;
	}

	retCode = _skillLogic->selectTarget(_character, &_attckMsg, &_attackTarget);
	if (!IsSuccess(retCode))
	{
		clean();
		return retCode;
	}

	_skillLogic->onAfterSelectTarget(_character, &_attckMsg, &_attackTarget);
	_character->cleanLastCombatData();
	//_SN = _character->getScene()->getAttackImpactPacketMgr().genSN();

	return RC_SUCCESS;
}

void CCharSkillCore::clean()
{
	_attckMsg.cleanUp();
	_attackTarget.cleanUp();
	if (NULL != _skillLogic)
	{
		_skillLogic->onAfterUse(_character, &_attckMsg, &_attackTarget);
	}
	_skillLogic = NULL;
}

EGameRetCode CCharSkillCore::onBeforeUse()
{
	FUNC_BEGIN(SKILL_MOD);

	if (NULL == _character->getScene())
	{
		gxError("Can't find scene!{0}", _character->toString());
		return RC_SKILL_NO_USE;
	}

	EGameRetCode retCode = RC_SUCCESS;
	retCode = _skillLogic->onBeforeUse(_character, &_attckMsg, &_attackTarget);
	if (!IsSuccess(retCode))
	{
		return retCode;
	}

	return RC_SUCCESS;

	FUNC_END(RC_SKILL_NO_USE);
}

void CCharSkillCore::onAfterUse()
{
	//	gxDebug("Use skill!%s", toString());
	_skillLogic->doConsume(_character, &_attckMsg, &_attackTarget);
	doImpact();
	doBroad();
	clean();
}

void CCharSkillCore::getAttackors(TPackAttackorList* attackors)
{
	for (uint32 i = 0; i < _attackTarget.attackorList.impacts.size(); ++i)
	{
		TAttackorImpact& impact = _attackTarget.attackorList.impacts[i];
		if (!attackors->isMax() && (impact.hp != 0 || impact.hp == 0 && impact.impactType == ATTACK_IMPACT_TYPE_DODGE))
		{
			attackors->pushBack(impact);
		}
	}
}

void CCharSkillCore::doImpact()
{
	_skillLogic->onBeforeCalcHurt(_character, &_attckMsg, &_attackTarget);
	_skillLogic->calcHurt(_character, &_attckMsg, &_attackTarget);
	_skillLogic->onAfterCalcHurt(_character, &_attckMsg, &_attackTarget);
	_skillLogic->showImpact(_character, &_attckMsg, &_attackTarget);
}

CCharSkillCore::CCharSkillCore()
{
	_SN = 0;
	_character = NULL;
}

void CCharSkillCore::doBroad()
{
	assert(false);
	// 技能攻击广播
// 	MCAttackBroad broad;
// 	broad.srcObjUID = _character->getObjUID();
// 	broad.destObjUID = _attckMsg.destObjUID;
// 	broad.skillID = _attckMsg.skilTypeID;
// 	broad.x = _attckMsg.pos.x;
// 	broad.y = _attckMsg.pos.y;
// 	_attackTarget.attackorList.getAttactorList(broad.objs);
// 	CMapSceneBase* scene = _character->getScene();
// 	if (NULL == scene)
// 	{
// 		gxWarning("Can't find scene! {0}", _character->toString());
// 		return;
// 	}
// 	scene->broadCast(broad, _character, true, g_GameConfig.broadcastRange);
// 
// 	// 技能攻击效果
// 	TAttackImpactDelay delay;
// 	delay.objUID = _character->getObjUID();
// 	delay.SN = _SN;
// 	delay.diff = getDelayTime();
// 	delay.impacts.skillID = _attckMsg.skilTypeID;
// 	delay.attackBackFlag = false;
// 	if (_character->isRole() && DRandGen.randOdds(MAX_BASE_RATE, g_GameConfig.rateAttackBack))
// 	{
// 		delay.attackBackFlag = true;
// 	}
// 	getAttackors(delay.impacts.attackors);
// 	if (delay.impacts.attackors.size() > 0)
// 	{
// 		_character->getScene()->getAttackImpactPacketMgr().addImpact(delay);
// 	}
}

GXMISC::TDiffTime_t CCharSkillCore::getDelayTime()
{
	return _skillLogic->getSkillInfo()->getDelayTime();
}

TSkillTypeID_t CCharSkillCore::getSkillID()
{
	return _skillLogic->getSkillInfo()->getSkillTypeID();
}

uint32 CCharSkillCore::getSN()
{
	return _SN;
}

CSkillLogicBase* CCharSkillCore::getSkillLogicBase() const
{
	return _skillLogic;
}

TSkillLevel_t CCharSkillCore::getSkillLevel(TSkillTypeID_t skillID)
{
	if (skillID == getCommSkillID())
	{
		return _commonSkill.level;
	}

	return INVALID_SKILL_LEVEL;
}

TOwnSkill* CCharSkillCore::getCommonSkill() const
{
	return (TOwnSkill*)&_commonSkill;
}

void CCharSkillCore::setCommSkillID(TSkillTypeID_t skillID, TSkillLevel_t level)
{
	_commonSkill.skillID = skillID;
	_commonSkill.level = level;
}

TSkillTypeID_t CCharSkillCore::getCommSkillID()
{
	return _commonSkill.skillID;
}

TRange_t CCharSkillCore::getCommSkillAttackDis()
{
	if (getCommSkillID() != INVALID_SKILL_TYPE_ID)
	{
		CSkillLogicBase* pSkillBase = DSkillLogicManager.getSkillLogic(getCommSkillID());
		if (NULL == pSkillBase)
		{
			pSkillBase->getSkillInfo()->getDistance();
		}
	}

	return std::numeric_limits<TRange_t>::max();
}

void CCharSkillCore::setCharacter(CCharacterObject* character)
{
	_character = character;
}
