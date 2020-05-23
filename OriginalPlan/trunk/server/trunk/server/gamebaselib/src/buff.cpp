#include "buff.h"
#include "game_exception.h"
#include "module_def.h"
#include "buff_tbl.h"
#include "packet_cm_fight.h"
#include "obj_character.h"
#include "game_struct.h"
#include "object.h"
#include "game_config.h"
#include "obj_character.h"
#include "map_scene_base.h"

CBufferEffect::CBufferEffect()
{
	active = false;
	buffTypeID = INVALID_BUFFER_TYPE_ID;
	buffType = INVALID_BUFF_TYPE;
	casterObjUID = INVALID_OBJ_UID;
	casterObjGUID = INVALID_OBJ_GUID;
	casterType = INVALID_OBJ_TYPE;
	otherID = INVALID_ITEM_TYPE_ID;
	startTime = GXMISC::INVALID_GAME_TIME;
	totalTime = 0;
	intervalTime = 0;
	lastTime = 0;
	timeElapsed = 0;
	times = 0;
	level = 0;
	buffImpact = NULL;
	buffRow = NULL;
}

CBufferEffect::~CBufferEffect()
{
}

void CBufferEffect::reload()
{
	FUNC_BEGIN(BUFF_MOD);

	active = true;
	lastTime = 0;
	timeElapsed = 0;
	times = 0;

	FUNC_END(DRET_NULL);
}

void CBufferEffect::log()
{
	gxDebug("{0}", toString());
}

bool CBufferEffect::isActive()
{
	return active;
}

bool CBufferEffect::isNeedSave()
{
	return getRemainTime() > MAX_BUFF_NEED_SAVE_TIME && isActive() && !buffRow->isOfflineDisa();
}

GXMISC::TDiffTime_t CBufferEffect::getRemainTime()
{
	if (buffRow->isPermanence())
	{
		return GXMISC::MAX_GAME_TIME;
	}

	if (timeElapsed >= totalTime)
	{
		return 0;
	}

	return GXMISC::TDiffTime_t((totalTime - timeElapsed) / 1000);
}

void CBufferEffect::getOwnerBuff(TOwnerBuffer* buff)
{
	buff->buffTypeID = buffTypeID;
	buff->buffType = buffType;
	buff->casterObjUID = casterObjUID;
	buff->casterObjGUID = casterObjGUID;
	buff->casterType = casterType;
	buff->otherID = otherID;
	buff->startTime = startTime;
	buff->totoalTime = totalTime;
	buff->lastTime = lastTime;
	buff->timeElapsed = timeElapsed;
	buff->times = times;
	buff->level = level;
	buff->params = params;
}

void CBufferEffect::getPackBuff(TPackBuffer* buff)
{
	buff->bufferTypeID = buffTypeID;
	buff->timeElapsed = getRemainTime();
	buff->level = level + 1;
	buff->param = 0;
	if (params.size())
	{
		buff->param = params[0];
	}
}

void CBufferImpactBase::update(CBufferEffect* buff, GXMISC::TDiffTime_t diff)
{
	buff->timeElapsed += diff;
}

void CBufferImpactBase::onAdd(CBufferEffect* buff, CCharacterObject* rMe)
{
	FUNC_BEGIN(BUFF_MOD);

	FUNC_END(DRET_NULL);
}

sint32 CBufferImpactBase::onActive(CBufferEffect* buff, CCharacterObject* rMe)
{
	return addAttr(buff, rMe);
}

bool CBufferImpactBase::isTimeout(CBufferEffect* buff)
{
	if (_buffRow->isPermanence())
	{
		return false;
	}

	return buff->totalTime <= buff->timeElapsed || 
		(_buffRow->isOfflineCountTime() && (DTimeManager.nowSysTime() > (buff->startTime + buff->totalTime / 1000)));
}

bool CBufferImpactBase::isIntervaled(CBufferEffect* buff)
{
	if (!buff->buffRow->isInterval())
	{
		return false;
	}

	return buff->intervalTime <= (buff->timeElapsed - buff->lastTime);
}

void CBufferImpactBase::onFadeout(CBufferEffect* buff, CCharacterObject* rMe)
{
	buff->timeElapsed = buff->totalTime;
	buff->active = false;
}

void CBufferImpactBase::reload(CBufferEffect* buff, CCharacterObject* rMe)
{
	buff->active = true;
	buff->buffRow = _buffRow;
	buff->buffImpact = this;

	// 时间
	if (_buffRow->isTimeOverlap() && !_buffRow->isPermanence())
	{
		buff->totalTime += _buffRow->getTotalTime(buff->level);
	}
	else
	{
		// 重新加载时间
		buff->times = 0;
		buff->lastTime = 0;
		buff->timeElapsed = 0;
		buff->totalTime = getBufferConfig()->getTotalTime(buff->level);
		buff->intervalTime = getBufferConfig()->getIntervalTime(buff->level);
	}

	// 参数
	if (_buffRow->isParamOverlap())
	{
		TBuffParamVec buffParam;
		_buffRow->getParamAry(buff->level, &buffParam);
		for (uint32 i = 0; i < buffParam.size(); ++i)
		{
			buff->params[i] += buffParam[i];
		}
	}
	else if (_buffRow->getParamArySize() > 0)
	{
		buff->params.clear();
		_buffRow->getParamAry(buff->level, &buff->params);
	}
}

void CBufferImpactBase::onEffectAtStart(CBufferEffect* buff, CCharacterObject* rMe)
{
	onActive(buff, rMe);
	logAttr(buff->level);
	logActionBan();
}

void CBufferImpactBase::onReload(CBufferEffect* buff, CCharacterObject* rMe)
{
	FUNC_BEGIN(BUFF_MOD);

	onActive(buff, rMe);

	FUNC_END(DRET_NULL);
}

bool CBufferImpactBase::initFromData(CBufferEffect* buff, CCharacterObject* rMe, bool loadDbFlag)
{
	buff->buffRow = _buffRow;
	buff->buffImpact = this;

	if (!loadDbFlag)
	{
		buff->totalTime = getBufferConfig()->getTotalTime(buff->level);
	}
	buff->intervalTime = getBufferConfig()->getIntervalTime(buff->level);

	if (_buffRow->getParamArySize() > 0 && !loadDbFlag)
	{
		buff->params.clear();
		_buffRow->getParamAry(buff->level, &buff->params);
	}

	return true;
}

bool CBufferImpactBase::loadFromDb(CBufferEffect* buff, CCharacterObject* rMe)
{
	initFromData(buff, rMe, true);
	return true;
}

void CBufferImpactBase::updateBuff(CBufferEffect* buff)
{
	buff->times++;
	buff->lastTime = buff->timeElapsed;
}

void CBufferImpactBase::getAttrs(CBufferEffect* buff, CCharacterObject* rMe, TBufferAttrs* buffAttrs)
{
	FUNC_BEGIN(BUFF_MOD);

	if (buff->level <= _buffRow->getAttrArySize())
	{
		TBuffAttrAry* addAttrAry = _buffRow->getAttrAry(buff->level);
		buffAttrs->addValue(*addAttrAry);
	}

	FUNC_END(DRET_NULL);
}

void CBufferImpactBase::markModifiedAttrDirty(CBufferEffect* buff, CCharacterObject* rMe)
{
	TBuffAttrAry* addAttrAry = _buffRow->getAttrAry(buff->level);
	for (TBuffAttrAry::iterator iter = addAttrAry->begin(); iter != addAttrAry->end(); ++iter)
	{
		TExtendAttr& attr = *iter;
		rMe->markAttrDirty(attr.attrType);
	}
}

void CBufferImpactBase::getActionBan(CBufferEffect* buff, CCharacterObject* rMe, CActionBan* bans)
{
	if (!isActionBan())
	{
		return;
	}

	for (uint32 i = 0; i < ACTION_BAN_MAX; ++i)
	{
		bans->setValue(i, _buffBan.getValue(i));
	}
}

bool CBufferImpactBase::isActionBan()
{
	return false;
}

sint32 CBufferImpactBase::addAttr(CBufferEffect* buff, CCharacterObject* rMe)
{
	if (buff->level < _buffRow->getAttrArySize())
	{
		return addAttr(buff, rMe, (_buffRow->getAttrAry(buff->level)));
	}
	return 0;
}

sint32 CBufferImpactBase::addAttr(CBufferEffect* buff, CCharacterObject* rMe, TBuffAttrAry* addAttrAry)
{
	TBuffImpactAry buffImpactAry;
	for (TBuffAttrAry::iterator iter = addAttrAry->begin(); iter != addAttrAry->end(); ++iter)
	{
		TExtendAttr& attr = *iter;
		if (isAddFilterAttr(attr.attrType))
		{
			addFilterAttr(buff, rMe, &attr, &buffImpactAry);
		}
	}

	TAttrVal_t attrVal = 0;
	if (!buffImpactAry.empty())
	{
		// 加血Buff效果(通知所有视野范围内的玩家)
		MCAttackImpact impacts;
		impacts.skillID = INVALID_SKILL_TYPE_ID;

		for (uint32 i = 0; i < buffImpactAry.size(); ++i)
		{
			if (buffImpactAry[i].attr.attrValue > 0)
			{
				impacts.attackors.pushBack(&buffImpactAry[i]);
			}

			attrVal += buffImpactAry[i].attr.attrValue;
		}
		if (!impacts.attackors.empty())
		{
			if (NULL != rMe->getScene())
			{
				rMe->getScene()->broadCast(impacts, rMe, true, g_GameConfig.broadcastRange);
			}
		}

		if (impacts.attackors.size() != buffImpactAry.size())
		{
			// 减血Bufff效果(通知施加者及当前所有者)
			impacts.attackors.clear();
			MCAttackImpact toOtherImpacts;
			for (uint32 i = 0; i < buffImpactAry.size(); ++i)
			{
				if (buffImpactAry[i].attr.attrValue >= 0)
				{
					continue;
				}

				if (rMe->getScene() == NULL)
				{
					continue;
				}

				// 通知BuffImpact的所有者
				if (buffImpactAry[i].destObjUID == rMe->getObjUID())
				{
					// 统一通知
					if (rMe->getRoleBaseOwner() != NULL)
					{
						// 当前所有者
						impacts.attackors.pushBack(&buffImpactAry[i]);
					}
				}
				else
				{
					// 单独的通知
					toOtherImpacts.attackors.clear();
					toOtherImpacts.attackors.pushBack(&buffImpactAry[i]);
					CCharacterObject* pChart = rMe->getScene()->getCharacterByUID(buffImpactAry[i].objUID);
					if (NULL != pChart && !rMe->isInValidRadius(pChart, g_GameConfig.getSameScreenRadius()))
					{
						CRoleBase* pRoleOwner = pChart->getRoleBaseOwner();
						if (NULL != pRoleOwner && pRoleOwner->getObjUID() != rMe->getObjUID())
						{
							toOtherImpacts.attackors.clear();
							toOtherImpacts.attackors.pushBack(&buffImpactAry[i]);
							pRoleOwner->sendPacket(toOtherImpacts);
						}
					}
				}

				// 通知添加此Buff效果的玩家
				if (rMe->getObjUID() == buffImpactAry[i].objUID)
				{
					// 自己制造的此Buff效果

					// 统一通知
					if (rMe->getRoleBaseOwner() != NULL)
					{
						// 当前所有者
						impacts.attackors.pushBack(&buffImpactAry[i]);
					}
				}
				else
				{
					CCharacterObject* pChart = rMe->getScene()->getCharacterByUID(buffImpactAry[i].objUID);
					if (NULL == pChart || !rMe->isInValidRadius(pChart, g_GameConfig.getSameScreenRadius()))
					{
						continue;
					}

					CRoleBase* pRoleOwner = pChart->getRoleBaseOwner();
					if (NULL != pRoleOwner && pRoleOwner->getObjUID() != rMe->getObjUID())
					{
						toOtherImpacts.attackors.clear();
						toOtherImpacts.attackors.pushBack(&buffImpactAry[i]);
						pRoleOwner->sendPacket(toOtherImpacts);
					}
				}
			}

			if (!impacts.attackors.empty())
			{
				rMe->getRoleBaseOwner()->sendPacket(impacts);
			}
		}
	}

	return attrVal;
}

TAttrVal_t CBufferImpactBase::addFilterAttr(CBufferEffect* buff, CCharacterObject* rMe, TExtendAttr* attr, TBuffImpactAry* impactAry)
{
	CCharacterObject* pChart = NULL;
	if (NULL != rMe->getScene())
	{
		pChart = rMe->getScene()->getCharacterByUID(buff->casterObjUID);
	}
	if (NULL == pChart)
	{
		return addFilterAttr(rMe, rMe, attr, impactAry);
	}
	else
	{
		return addFilterAttr(pChart, rMe, attr, impactAry);
	}
}

TAttrVal_t CBufferImpactBase::addFilterAttr(CCharacterObject* rMe, CCharacterObject* rOther, TExtendAttr* attr, TBuffImpactAry* impactAry)
{
	TAttrVal_t maxVal = getMaxAttr(rOther, attr);
	TAttrVal_t oldValue = rOther->getAttrValue(attr->attrType);
	if (attr->isRate())
	{
		double incVal = ((double)maxVal*attr->attrValue) / MAX_BASE_RATE;
		TAttrVal_t result = GXMISC::gxDouble2Int<TAttrVal_t>(incVal);
		rOther->addAttrValue(attr->attrType, result);
	}
	else
	{
		rOther->addAttrValue(attr->attrType, attr->attrValue);
	}
	TAttrVal_t newValue = rOther->getAttrValue(attr->attrType);
	if ((newValue - oldValue) != 0)
	{
		TBuffImpact impact;
		impact.objUID = rMe->getObjUID();
		impact.destObjUID = rOther->getObjUID();
		impact.attr.attrValue = newValue - oldValue;
		impact.attr.attrType = attr->attrType;
		impactAry->push_back(impact);
		gxDebug("Buff add hp: hp={0}", newValue - oldValue);
	}
	return newValue - oldValue;
}

bool CBufferImpactBase::isAddFilterAttr(TAttrType_t type)
{
	switch (type)
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

CBufferConfigTbl* CBufferImpactBase::getBufferConfig()
{
	return _buffRow;
}

sint8 CBufferImpactBase::getRange(TSkillLevel_t level)
{
	return 1;
}

bool CBufferImpactBase::isRangeBuff()
{
	return false;
}

bool CBufferImpactBase::isDurationTime()
{
	return !_buffRow->isPermanence();
}

bool CBufferImpactBase::isCountTime()
{
	return _buffRow->isInterval();
}

void CBufferImpactBase::getBuffEvent(CBufferEffect* buff, CCharacterObject* rMe, TBuffEventFlagSet* buffEvents)
{
	FUNC_BEGIN(BUFF_MOD);

	if (!isEvent())
	{
		return;
	}

	*buffEvents |= _buffEventFlags;

	FUNC_END(DRET_NULL);
}

bool CBufferImpactBase::isEvent()
{
	return false;
}

bool CBufferImpactBase::isEvent(EBuffEventFlag flag)
{
	return _buffEventFlags.get(flag);
}

bool CBufferImpactBase::isRefreshAttr()
{
	return _buffRow->getAttrArySize() > 0;
}

void CBufferImpactBase::logAttr(TSkillLevel_t level)
{
	FUNC_BEGIN(BUFF_MOD);

	if (level >= (TSkillLevel_t)_buffRow->getAttrArySize())
	{
		return;
	}

	std::string logStr;
	logStr = "============================Buff" + GXMISC::gxToString("ID:%u", _buffRow->getID()) + "============================\n";
	TBuffAttrAry* buffAry = _buffRow->getAttrAry(level);
	for (uint32 i = 0; i < buffAry->size(); ++i)
	{
		logStr += GXMISC::gxToString("Attr[%u:%u:%u]\n", buffAry->at(i).attrType, buffAry->at(i).valueType, buffAry->at(i).attrValue);
	}
	logStr += "\n\n";

	FUNC_END(DRET_NULL);
}

void CBufferImpactBase::logActionBan()
{
	FUNC_BEGIN(BUFF_MOD);

	std::string logStr;
	logStr = "============================Buff" + GXMISC::gxToString("ID:%u", _buffRow->getID()) + "============================\n";
	for (uint32 i = 0; i < ACTION_BAN_MAX; ++i)
	{
		logStr += GXMISC::gxToString("Ban[%u]\n", (uint8)_buffBan.getValue(i));
	}
	logStr += "\n\n";

	FUNC_END(DRET_NULL);
}

CBufferImpactBase::CBufferImpactBase(TBufferTypeID_t buffID)
{
	_buffRow = DBuffTblMgr.find(buffID);
	gxAssert(NULL != _buffRow);
	_buffEventFlags.clearAll();
	_buffEffectType = BUFF_EFFECT_TYPE_ADD_EXTRA_ATTR;
	if (_buffRow->getAttrArySize())
	{
		TBuffAttrAry* attrAry = _buffRow->getAttrAry(0);
		for (uint32 i = 0; i < attrAry->size(); ++i)
		{
			if (attrAry->at(i).attrType == ATTR_CUR_HP || attrAry->at(i).attrType == ATTR_CUR_ENERGY)
			{
				_buffEffectType = BUFF_EFFECT_TYPE_ADD_HPMP;
			}
		}
	}
}

void CBufferImpactBase::logBuffer(CBufferEffect* buff)
{
	FUNC_BEGIN(BUFF_MOD);

	logAttr(buff->level);
	logActionBan();
	gxDebug("{0}", buff->toString());

	FUNC_END(DRET_NULL);
}

EBuffEffectType CBufferImpactBase::getEffectType()
{
	return _buffEffectType;
}

TAttrVal_t CBufferImpactBase::getMaxAttr(CCharacterObject* rMe, TExtendAttr* attr)
{
	switch (attr->attrType)
	{
	case ATTR_CUR_HP:
	{
						return rMe->getMaxHp();
	}break;
	case ATTR_CUR_ENERGY:
	{
							return rMe->getMaxEnergy();
	}break;
	default:
		return 0;
	}

	return 0;
}