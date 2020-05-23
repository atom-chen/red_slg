#include "buffer_manager_base.h"
#include "obj_character.h"
#include "packet_cm_fight.h"
#include "map_scene_base.h"
#include "buff_tbl.h"
#include "game_config.h"
#include "role_base.h"

CBufferImpactBase* CBufferManager::BufferImpactList[MAX_BUFFER_EFFECT_NUM];


CBufferManager::CBufferManager()
{
	_owner = NULL;
	_passiveBuffAttr.reset();
	_activeBuffAttr.reset();
	_itemBuffAttr.reset();
	_buffEventFlags.clearAll();
}

bool CBufferManager::InitImpacts()
{
	return true;
}

void CBufferManager::processPassivEffect()
{
	FUNC_BEGIN(BUFF_MOD);

	bool refreshAttr = false;
	for (TEffectHashMap::iterator iter = _passivenessSkillEffect.begin(); iter != _passivenessSkillEffect.end(); ++iter)
	{
		CBufferEffect& buff = iter->second;
		CBufferImpactBase* impactBase = BufferImpactList[buff.buffTypeID];
		impactBase->onActive(&buff, _owner);

		if (impactBase->isRefreshAttr())
		{
			refreshAttr = true;
		}
	}

	if (refreshAttr)
	{
		gxDebug("Process passive effect,refresh passive attr!");
		calcPassiveAttr();
	}

	FUNC_END(DRET_NULL);
}

void CBufferManager::processActiveEffect(GXMISC::TDiffTime_t diff)
{
	FUNC_BEGIN(BUFF_MOD);

	typedef std::list<TBufferTypeID_t> TBufferTypeList;

	TBufferTypeList fadeoutList;
	for (TEffectHashMap::iterator iter = _activeSkillEffect.begin(); iter != _activeSkillEffect.end(); ++iter)
	{
		CBufferEffect& buff = iter->second;
		CBufferImpactBase* impactBase = BufferImpactList[buff.buffTypeID];

		impactBase->update(&buff, diff);
		gxAssert(buff.lastTime <= buff.timeElapsed);
		if (impactBase->isTimeout(&buff) || !buff.isActive())
		{
			gxDebug("Skill buffer timeout!{0}", buff.toString());
			buff.active = false;
			fadeoutList.push_back(buff.buffTypeID);
		}
		else if (impactBase->isCountTime() && impactBase->isIntervaled(&buff))
		{
			gxDebug("Skill buffer interavl!%s", buff.toString());
			impactBase->onActive(&buff, _owner);
			impactBase->updateBuff(&buff);
		}

		if (buff.timeElapsed > buff.totalTime && !buff.buffRow->isPermanence())
		{
			gxAssert(buff.totalTime > 0);
			buff.timeElapsed = buff.totalTime;
		}
	}

	bool refreshAttrFlag = false;
	bool refreshEventFlag = false;
	bool refreshBanFlag = false;
	for (TBufferTypeList::iterator iter = fadeoutList.begin(); iter != fadeoutList.end(); ++iter)
	{
		CBufferEffect& buff = _activeSkillEffect.find(*iter)->second;
		CBufferImpactBase* impactBase = buff.buffImpact;
		impactBase->onFadeout(&buff, _owner);
		onDelEffect(&buff, true);
		_activeSkillEffect.erase(buff.buffTypeID);

		if (impactBase->isRefreshAttr())
		{
			refreshAttrFlag = true;
		}
		if (impactBase->isEvent())
		{
			refreshEventFlag = true;
		}
		if (impactBase->isActionBan())
		{
			refreshBanFlag = true;
		}
	}

	if (refreshAttrFlag)
	{
		gxDebug("Process active effect,refresh active attr!");
		calcActiveAttr();
	}

	if (refreshEventFlag)
	{
		gxDebug("Process active effect,refresh event flag!");
		rebuildEventFlags();
	}

	if (refreshBanFlag)
	{
		gxDebug("Process active effect,refresh ban flag!");
		rebuildActionFlags();
	}

	if (_owner->getHp() <= 0)
	{
		// 所有者已经死亡
		//_owner->onDie();
	}

	FUNC_END(DRET_NULL);
}

void CBufferManager::processItemEffect(GXMISC::TDiffTime_t diff)
{
	FUNC_BEGIN(BUFF_MOD);

	typedef std::list<TBufferTypeID_t> TBufferTypeList;

	TBufferTypeList fadeoutList;
	for (TEffectHashMap::iterator iter = _activeItemEffect.begin(); iter != _activeItemEffect.end(); ++iter)
	{
		CBufferEffect& buff = iter->second;
		CBufferImpactBase* impactBase = buff.buffImpact;

		impactBase->update(&buff, diff);
		gxAssert(buff.lastTime <= buff.timeElapsed);

		if (impactBase->isTimeout(&buff) || !buff.isActive())
		{
			gxDebug("Item buffer timeout!%s", buff.toString());
			buff.active = false;
			fadeoutList.push_back(buff.buffTypeID);
		}
		else if (impactBase->isCountTime() && impactBase->isIntervaled(&buff))
		{
			if (impactBase->onActive(&buff, _owner) > 0)
			{
				impactBase->updateBuff(&buff);
			}
		}

		if (buff.timeElapsed > buff.totalTime && !buff.buffRow->isPermanence())
		{
			gxAssert(buff.totalTime > 0);
			buff.timeElapsed = buff.totalTime;
		}
	}

	bool refreshAttrFlag = false;
	for (TBufferTypeList::iterator iter = fadeoutList.begin(); iter != fadeoutList.end(); ++iter)
	{
		CBufferEffect& buff = _activeItemEffect.find(*iter)->second;
		CBufferImpactBase* impactBase = buff.buffImpact;
		impactBase->onFadeout(&buff, _owner);
		onDelEffect(&buff, true);
		_activeItemEffect.erase(buff.buffTypeID);

		if (impactBase->isRefreshAttr())
		{
			refreshAttrFlag = true;
		}
	}

	if (refreshAttrFlag)
	{
		gxDebug("Process item effect,refresh item attr!");
		calcItemAttr();
	}

	FUNC_END(DRET_NULL);
}

EGameRetCode CBufferManager::addEffect(CSkillBuff* buff, bool isNew)
{
	FUNC_BEGIN(BUFF_MOD);

	buff->level -= 1;

	// 主动技能BUFFER
	bool reloadFlag = false;

	if (buff->buffTypeID >= MAX_BUFFER_EFFECT_NUM)
	{
		return RC_BUFFER_NO_EXIST;
	}

	CBufferImpactBase* impactBase = BufferImpactList[buff->buffTypeID];
	if (NULL == impactBase)
	{
		return RC_BUFFER_NO_EXIST;
	}

	// 添加Buffer
	CBufferEffect buffEffect;
	TEffectHashMap::iterator iter = _activeSkillEffect.find(buff->buffTypeID);
	if (iter != _activeSkillEffect.end())
	{
		// 找到已经存在的Buffer
		buffEffect = iter->second;
		if (buffEffect.level > buff->level)
		{
			return RC_BUFFER_EXIST_HIGHER;
		}
		buffEffect.level = buff->level;
		buffEffect.startTime = DTimeManager.nowSysTime();
		reloadFlag = true;
	}
	else
	{
		// 新的Buffer
		memset(&buffEffect, 0, sizeof(CBufferEffect));

		buffEffect.buffTypeID = buff->buffTypeID;
		buffEffect.casterObjUID = buff->casterObjUID;
		buffEffect.casterObjGUID = buff->casterObjGUID;
		buffEffect.casterType = buff->casterType;
		buffEffect.otherID = buff->skillID;
		buffEffect.level = buff->level;
		buffEffect.buffType = BUFF_TYPE_SKILL;
		buffEffect.startTime = DTimeManager.nowSysTime();
	}
	buffEffect.active = true;

	// 加载数据
	if (!reloadFlag)
	{
		if (!impactBase->initFromData(&buffEffect, _owner, !isNew))
		{
			return RC_BUFFER_NO_EXIST;
		}
		gxDebug("Add skill buffer!%s", buffEffect.toString());
	}
	else
	{
		// 重新加载
		impactBase->reload(&buffEffect, _owner);
		gxDebug("Reload skill buffer!%s", buffEffect.toString());
	}

	// 添加新的Buffer
	_activeSkillEffect[buffEffect.buffTypeID] = buffEffect;

	// 刷新属性
	if (impactBase->isRefreshAttr())
	{
		gxDebug("Refresh attr!%s", buffEffect.toString());
		// 刷新属性
		calcActiveAttr();
	}
	if (impactBase->isActionBan())
	{
		gxDebug("Refresh ban!%s", buffEffect.toString());
		// 刷新行为禁止
		rebuildActionFlags();
	}
	if (impactBase->isEvent())
	{
		gxDebug("Refresh event!%s", buffEffect.toString());
		// 刷新事件
		rebuildEventFlags();
	}
	impactBase->logBuffer(&buffEffect);

	// 触发效果
	if (!reloadFlag)
	{
		if (isNew)
		{
			// 添加后的效果
			impactBase->onEffectAtStart(&buffEffect, _owner);
		}
		else
		{
			// 从数据库加载
			impactBase->loadFromDb(&buffEffect, _owner);
		}
	}
	else
	{
		impactBase->onReload(&buffEffect, _owner);
	}

	onAddEffect(&buffEffect, reloadFlag, isNew);

	return RC_SUCCESS;

	FUNC_END(RC_BUFFER_FAILED);
}

EGameRetCode CBufferManager::addEffect(CItemBuff* buff, bool isNew)
{
	FUNC_BEGIN(BUFF_MOD);

	buff->quality -= 1;

	// 物品BUFFER
	bool reloadFlag = false;

	if (buff->buffTypeID >= MAX_BUFFER_EFFECT_NUM)
	{
		return RC_BUFFER_NO_EXIST;
	}

	CBufferImpactBase* impactBase = BufferImpactList[buff->buffTypeID];
	if (NULL == impactBase)
	{
		return RC_BUFFER_NO_EXIST;
	}

	// 添加Buffer
	CBufferEffect buffEffect;
	TEffectHashMap::iterator iter = _activeItemEffect.find(buff->buffTypeID);
	if (iter != _activeItemEffect.end())
	{
		// 找到已经存在的Buffer
		buffEffect = iter->second;
		if (buffEffect.level > buff->quality)
		{
			return RC_BUFFER_EXIST_HIGHER;
		}
		buffEffect.level = buff->quality;
		buffEffect.startTime = DTimeManager.nowSysTime();
		reloadFlag = true;
	}
	else
	{
		// 新的Buffer
		memset(&buffEffect, 0, sizeof(CBufferEffect));

		buffEffect.buffTypeID = buff->buffTypeID;
		buffEffect.casterObjUID = buff->casterObjUID;
		buffEffect.casterObjGUID = buff->casterObjGUID;
		buffEffect.casterType = buff->casterType;
		buffEffect.otherID = buff->itemID;
		buffEffect.level = buff->quality;
		buffEffect.buffType = BUFF_TYPE_ITEM;
		buffEffect.startTime = DTimeManager.nowSysTime();

		if (impactBase->getEffectType() == BUFF_EFFECT_TYPE_ADD_EXTRA_ATTR)
		{
			// 清除掉需要覆盖的Buff
			for (TEffectHashMap::iterator iter = _activeItemEffect.begin(); iter != _activeItemEffect.end();)
			{
				if (iter->second.buffImpact->getEffectType() == impactBase->getEffectType())
				{
					onDelEffect(&iter->second, true);
					_activeItemEffect.erase(iter++);
					continue;
				}

				++iter;
			}
		}
	}
	buffEffect.active = true;

	// 加载数据
	if (!reloadFlag)
	{
		if (!impactBase->initFromData(&buffEffect, _owner, !isNew))
		{
			return RC_BUFFER_NO_EXIST;
		}
		gxDebug("Add item buffer!{0}", buffEffect.toString());
	}
	else
	{
		// 重新加载
		impactBase->reload(&buffEffect, _owner);
		gxDebug("Reload item buffer!%s", buffEffect.toString());
	}

	// 添加新的Buffer
	_activeItemEffect[buffEffect.buffTypeID] = buffEffect;

	if (impactBase->isRefreshAttr())
	{
		gxDebug("Refresh attr!%s", buffEffect.toString());
		// 刷新属性
		calcItemAttr();
	}
	if (impactBase->isActionBan())
	{
		gxDebug("Refresh ban!%s", buffEffect.toString());
		// 刷新行为禁止
		rebuildActionFlags();
	}
	if (impactBase->isEvent())
	{
		gxDebug("Refresh event!%s", buffEffect.toString());
		// 刷新事件
		rebuildEventFlags();
	}
	impactBase->logBuffer(&buffEffect);

	// 触发效果
	if (!reloadFlag)
	{
		if (isNew)
		{
			// 添加后的效果
			impactBase->onEffectAtStart(&buffEffect, _owner);
		}
		else
		{
			// 从数据库加载
			impactBase->loadFromDb(&buffEffect, _owner);
		}
	}
	else
	{
		impactBase->onReload(&buffEffect, _owner);
	}

	onAddEffect(&buffEffect, reloadFlag, isNew);

	return RC_SUCCESS;

	FUNC_END(RC_BUFFER_FAILED);
}

EGameRetCode CBufferManager::addPassiveEffect(CSkillBuff* buff, bool isNew)
{
	FUNC_BEGIN(BUFF_MOD);

	buff->level -= 1; // @todo

	bool reloadFlag = false;

	if (buff->buffTypeID >= MAX_BUFFER_EFFECT_NUM)
	{
		return RC_BUFFER_NO_EXIST;
	}

	CBufferImpactBase* impactBase = BufferImpactList[buff->buffTypeID];
	if (NULL == impactBase)
	{
		return RC_BUFFER_NO_EXIST;
	}

	// 添加Buffer
	CBufferEffect buffEffect;
	TEffectHashMap::iterator iter = _passivenessSkillEffect.find(buff->buffTypeID);
	if (iter != _passivenessSkillEffect.end())
	{
		// 找到已经存在的Buffer
		buffEffect = iter->second;
		if (buffEffect.level > buff->level)
		{
			return RC_BUFFER_EXIST_HIGHER;
		}
		buffEffect.level = buff->level;
		reloadFlag = true;
	}
	else
	{
		// 新的Buffer
		memset(&buffEffect, 0, sizeof(CBufferEffect));

		buffEffect.buffTypeID = buff->buffTypeID;
		buffEffect.casterObjUID = buff->casterObjUID;
		buffEffect.casterObjGUID = buff->casterObjGUID;
		buffEffect.casterType = buff->casterType;
		buffEffect.otherID = buff->skillID;
		buffEffect.level = buff->level;
		buffEffect.buffType = BUFF_TYPE_SKILL;
	}
	buffEffect.active = true;

	// 加载数据
	if (!reloadFlag)
	{
		if (!impactBase->initFromData(&buffEffect, _owner, !isNew))
		{
			return RC_BUFFER_NO_EXIST;
		}
		gxDebug("Add passive skill buffer!%s", buffEffect.toString());
	}
	else
	{
		// 重新加载
		impactBase->reload(&buffEffect, _owner);
		gxDebug("Reload passive skill buffer!%s", buffEffect.toString());
	}

	// 添加新的Buffer
	_passivenessSkillEffect[buffEffect.buffTypeID] = buffEffect;

	// 刷新属性
	if (impactBase->isRefreshAttr())
	{
		gxDebug("Refresh attr!%s", buffEffect.toString());
		// 刷新属性
		calcPassiveAttr();
	}
	if (impactBase->isActionBan())
	{
		gxDebug("Refresh ban!%s", buffEffect.toString());
		// 刷新行为禁止
		rebuildActionFlags();
	}
	if (impactBase->isEvent())
	{
		gxDebug("Refresh event!%s", buffEffect.toString());
		// 刷新事件
		rebuildEventFlags();
	}
	impactBase->logBuffer(&buffEffect);

	return RC_SUCCESS;

	FUNC_END(RC_BUFFER_FAILED);
}

bool CBufferManager::onAfterChangeLine(TChangeLineTempData* tempData)
{
	FUNC_BEGIN(BUFF_MOD);

	_activeItemEffect.clear();
	_activeSkillEffect.clear();
	_passivenessSkillEffect.clear();

	if (!(_owner->isPet() || _owner->isRole()))
	{
		return false;
	}

	TOwnerBuffAry* buffAry = NULL;
	CRoleBase* pRole = NULL;
	if (_owner->isPet())
	{
		pRole = _owner->getRoleBaseOwner();
		if (NULL != pRole)
		{
			buffAry = &tempData->saveData.petBuffAry;
		}
	}
	else if (_owner->isRole())
	{
		pRole = _owner->toRoleBase();
		if (NULL != pRole)
		{
			buffAry = &tempData->buffAry;
		}
	}

	return _onLoad(buffAry);

	FUNC_END(false);
}

bool CBufferManager::onBeforeChangeLine(TChangeLineTempData* tempData)
{
	FUNC_BEGIN(BUFF_MOD);

	if (!(_owner->isPet() || _owner->isRole()))
	{
		return false;
	}

	TOwnerBuffAry* buffAry = NULL;
	CRoleBase* pRole = NULL;
	if (_owner->isPet())
	{
		pRole = _owner->getRoleBaseOwner();
		if (NULL != pRole)
		{
			buffAry = &tempData->saveData.petBuffAry;
		}
	}
	else if (_owner->isRole())
	{
		pRole = _owner->toRoleBase();
		if (NULL != pRole)
		{
			buffAry = &tempData->buffAry;
		}
	}

	_onSave(buffAry, true);

	FUNC_END(false);
}

bool CBufferManager::onLoad()
{
	FUNC_BEGIN(BUFF_MOD);

	if (!(_owner->isPet() || _owner->isRole()))
	{
		return false;
	}

	TOwnerBuffAry* buffAry = NULL;
	CRoleBase* pRole = NULL;
	if (_owner->isPet())
	{
		// @TODO
// 		CObjPet* pPet = _owner->toPet();
// 		if (NULL != pPet)
// 		{
// 			CRole* pOwer = pPet->getRoleOwner();
// 			if (NULL != pOwer)
// 			{
// 				buffAry = &(pOwer->getHummanDB()->_data.dbHuman.petBuffAry.data);
// 			}
// 		}
	}
	else if (_owner->isRole())
	{
		// @TODO
// 		pRole = _owner->toRoleBase();
// 		if (NULL != pRole)
// 		{
// 			buffAry = &(pRole->getHummanDB()->_data.dbHuman.buffAry.data);
// 		}
	}

	if (NULL == buffAry)
	{
		return false;
	}

	return _onLoad(buffAry);

	FUNC_END(false);
}

void CBufferManager::onSave(bool offLineFlag)
{
	FUNC_BEGIN(BUFF_MOD);

	if (!(_owner->isPet() || _owner->isRole()))
	{
		return;
	}

	TOwnerBuffAry* buffAry = NULL;
	CRoleBase* pRole = NULL;
// 	if (_owner->isPet())
// 	{
// 		CObjPet* pPet = _owner->toPet();
// 		if (NULL != pPet)
// 		{
// 			pRole = pPet->getRoleBaseOwner();
// 			if (NULL != pRole)
// 			{
// 				buffAry = &(pRole->getHummanDB()->_data.dbHuman.petBuffAry.data);
// 			}
// 		}
// 	}
// 	else if (_owner->isRole())
// 	{
// 		pRole = _owner->toRoleBase();
// 		if (NULL != pRole)
// 		{
// 			buffAry = &(pRole->getHummanDB()->_data.dbHuman.buffAry.data);
// 		}
// 	}

	if (NULL == buffAry)
	{
		return;
	}

	_onSave(buffAry, offLineFlag);

	FUNC_END(DRET_NULL);
}

bool CBufferManager::_onLoad(TOwnerBuffAry* buffAry)
{
	FUNC_BEGIN(BUFF_MOD);

	_activeItemEffect.clear();
	_activeSkillEffect.clear();
	_passivenessSkillEffect.clear();

	if (NULL == buffAry)
	{
		return false;
	}

	for (sint32 i = 0; i < buffAry->size(); ++i)
	{
		CBufferEffect buff;
		buff = buffAry->at(i);
		CBufferImpactBase* pBuffBase = BufferImpactList[buff.buffTypeID];
		if (NULL == pBuffBase)
		{
			continue;
		}

		if (!pBuffBase->loadFromDb(&buff, _owner))
		{
			continue;
		}
		if (buff.buffType == BUFF_TYPE_ITEM)
		{
			_activeItemEffect.insert(TEffectHashMap::value_type(buff.buffTypeID, buff));
		}
		else if (buff.buffType == BUFF_TYPE_SKILL)
		{
			_activeSkillEffect.insert(TEffectHashMap::value_type(buff.buffTypeID, buff));
		}
	}

	loadPassiveEffect();

	calcActiveAttr();
	calcPassiveAttr();
	calcItemAttr();
	rebuildActionFlags();
	rebuildEventFlags();

	return true;

	FUNC_END(false);
}

void CBufferManager::_onSave(TOwnerBuffAry* buffAry, bool offlineFlag)
{
	FUNC_BEGIN(BUFF_MOD);

	if (NULL == buffAry)
	{
		return;
	}

	buffAry->clear();

	if (offlineFlag)
	{
		for (TEffectHashMap::iterator iter = _activeSkillEffect.begin(); iter != _activeSkillEffect.end(); ++iter)
		{
			if (buffAry->isMax())
			{
				break;
			}
			CBufferEffect& buff = iter->second;
			if (!buff.isNeedSave())
			{
				continue;
			}

			buffAry->resize(buffAry->size() + 1);
			buff.getOwnerBuff(&buffAry->at(buffAry->size() - 1));
		}
	}

	for (TEffectHashMap::iterator iter = _activeItemEffect.begin(); iter != _activeItemEffect.end(); ++iter)
	{
		if (buffAry->isMax())
		{
			break;
		}
		CBufferEffect& buff = iter->second;
		if (!buff.isNeedSave())
		{
			continue;
		}

		buffAry->resize(buffAry->size() + 1);
		buff.getOwnerBuff(&buffAry->at(buffAry->size() - 1));
	}

	FUNC_END(DRET_NULL);
}

void CBufferManager::update(GXMISC::TDiffTime_t diff)
{
	processActiveEffect(diff);
	processItemEffect(diff);
}

void CBufferManager::clearActiveEffect()
{
	FUNC_BEGIN(BUFF_MOD);

	MCDelBuffer delBuffAry;
	for (TEffectHashMap::iterator iter = _activeSkillEffect.begin(); iter != _activeSkillEffect.end(); ++iter)
	{
		CBufferEffect& buff = iter->second;
		CBufferImpactBase* impactBase = BufferImpactList[buff.buffTypeID];
		delBuffAry.ary.pushBack(buff.buffTypeID);
		impactBase->onFadeout(&buff, _owner);
		onDelEffect(&buff, false);
	}

	_activeSkillEffect.clear();
	if (_owner->getScene() != NULL)
	{
		delBuffAry.objUID = _owner->getObjUID();
		_owner->getScene()->broadCast(delBuffAry, _owner, true, g_GameConfig.broadcastRange);
	}

	gxDebug("Clear all active buff!");

	calcActiveAttr();
	rebuildActionFlags();
	rebuildEventFlags();

	FUNC_END(DRET_NULL);
}

void CBufferManager::clearItemEffect()
{
	FUNC_BEGIN(BUFF_MOD);

	for (TEffectHashMap::iterator iter = _activeItemEffect.begin(); iter != _activeItemEffect.end(); ++iter)
	{
		CBufferEffect& buff = iter->second;
		CBufferImpactBase* impactBase = buff.buffImpact;

		impactBase->onFadeout(&buff, _owner);
		onDelEffect(&buff, false);
	}

	_activeItemEffect.clear();

	gxDebug("Clear all item buff!");

	calcItemAttr();

	FUNC_END(DRET_NULL);
}

void CBufferManager::onAddEffect(CBufferEffect* buffer, bool reloadFlag, bool sendFlag)
{
	FUNC_BEGIN(BUFF_MOD);

	CBufferConfigTbl* buffRow = buffer->buffRow;
	if (NULL == buffRow)
	{
		return;
	}

	if (sendFlag && buffRow->isShow())
	{
		sendAdd(buffer);
	}

	FUNC_END(DRET_NULL);
}

void CBufferManager::onDelEffect(CBufferEffect* buffer, bool sendFlag)
{
	FUNC_BEGIN(BUFF_MOD);

	CBufferConfigTbl* buffRow = buffer->buffRow;
	if (NULL == buffRow)
	{
		return;
	}

	if (sendFlag && buffRow->isShow())
	{
		sendDel(buffer);
	}

	FUNC_END(DRET_NULL);
}

void CBufferManager::sendAddAllEffect(CRoleBase* pRole)
{
	FUNC_BEGIN(BUFF_MOD);

	MCAddBuffer addBuffer;
	getBuffAry(&addBuffer.ary);
	if (addBuffer.ary.empty())
	{
		return;
	}

	CRoleBase* role = _owner->toRoleBase();
	if (NULL == role)
	{
		return;
	}

	if (NULL == pRole && role->getScene())
	{
		role->getScene()->broadCast(addBuffer, true, g_GameConfig.broadcastRange);
	}
	else
	{
		pRole->sendPacket(addBuffer);
	}

	FUNC_END(DRET_NULL);
}

void CBufferManager::sendDelAllEffect()
{
	FUNC_BEGIN(BUFF_MOD);

	MCDelBuffer delBuffer;
	delBuffer.objUID = _owner->getObjUID();
	for (TEffectHashMap::iterator iter = _activeSkillEffect.begin(); iter != _activeSkillEffect.end() && !delBuffer.ary.isMax(); ++iter)
	{
		CBufferEffect& buffer = iter->second;
		delBuffer.ary.pushBack(buffer.buffTypeID);
	}

	CRoleBase* role = NULL;
	switch (_owner->getObjType())
	{
	case OBJ_TYPE_ROLE:
	case OBJ_TYPE_PET:
	{
						 role = _owner->getRoleBaseOwner();
	}break;
	default:
	{
			   return;
	}
	}

	if (NULL == role)
	{
		return;
	}

	CMapSceneBase* pMapScene = role->getScene();
	if (NULL != pMapScene)
	{
		pMapScene->broadCast(delBuffer, role, true, g_GameConfig.broadcastRange);
	}

	FUNC_END(DRET_NULL);
}

void CBufferManager::onDie()
{
	FUNC_BEGIN(BUFF_MOD);

	FUNC_END(DRET_NULL);
}

void CBufferManager::onHurt()
{
	FUNC_BEGIN(BUFF_MOD);

	FUNC_END(DRET_NULL);
}

void CBufferManager::onHit()
{
	FUNC_BEGIN(BUFF_MOD);

	FUNC_END(DRET_NULL);
}

void CBufferManager::onStudySkill(TSkillTypeID_t skillID, TSkillLevel_t level)
{
	FUNC_BEGIN(BUFF_MOD);
// 
// 	CSkillConfigTbl* skillRow = DSkillTblMgr.find(skillID);
// 	if (NULL == skillRow)
// 	{
// 		return;
// 	}
// 
// 	if (skillRow->isPassiveSkill())
// 	{
// 		CSkillBuff skillBuff;
// 		skillBuff.buffTypeID = skillRow->buffEffectID;
// 		skillBuff.casterObjGUID = _owner->getObjGUID();
// 		skillBuff.casterObjUID = _owner->getOwnerUID();
// 		skillBuff.casterType = _owner->getObjType();
// 		skillBuff.skillID = skillID;
// 		skillBuff.level = level;
// 		addPassiveEffect(skillBuff);
// 	}

	FUNC_END(DRET_NULL);
}

void CBufferManager::sendAdd(CBufferEffect* buffer)
{
	FUNC_BEGIN(BUFF_MOD);

	MCAddBuffer addBuffer;
	TPackSimpleBuff packBuffer;
	packBuffer.objUID = _owner->getObjUID();
	packBuffer.bufferTypeID = buffer->buffTypeID;
	addBuffer.ary.pushBack(packBuffer);

	CMapSceneBase* pMapScene = _owner->getScene();
	if (NULL != pMapScene)
	{
		pMapScene->broadCast(addBuffer, _owner, true, g_GameConfig.broadcastRange);
	}
	gxAssert(!_owner->isDie());

	FUNC_END(DRET_NULL);
}

void CBufferManager::sendDel(CBufferEffect* buffer)
{
	FUNC_BEGIN(BUFF_MOD);

	MCDelBuffer delBuffer;
	delBuffer.objUID = _owner->getObjUID();
	delBuffer.ary.pushBack(buffer->buffTypeID);

	//     CRole* role = NULL;
	//     switch(_owner->getObjType())
	//     {
	//     case OBJ_TYPE_ROLE:
	//     case OBJ_TYPE_PET:
	//         {
	// 			role = _owner->getRoleOwner();
	//         }break;
	//     default:
	//         {
	//             return;
	//         }
	//     }
	// 
	//     if(NULL == role)
	//     {
	//         return;
	//     }

	CMapSceneBase* pMapScene = _owner->getScene();
	if (NULL != pMapScene)
	{
		pMapScene->broadCast(delBuffer, _owner, true, g_GameConfig.broadcastRange);
	}

	FUNC_END(DRET_NULL);
}

void CBufferManager::calcActiveAttr()
{
	FUNC_BEGIN(BUFF_MOD);

	_activeBuffAttr.resetBase();
	// 计算主动技能属性
	for (TEffectHashMap::iterator iter = _activeSkillEffect.begin(); iter != _activeSkillEffect.end(); ++iter)
	{
		CBufferEffect& buffer = iter->second;
		CBufferImpactBase* impactBase = buffer.buffImpact;
		if (NULL == impactBase)
		{
			continue;
		}

		if (impactBase->isRefreshAttr())
		{
			impactBase->getAttrs(&buffer, _owner, &_activeBuffAttr);
		}
	}

	_owner->markAllAttrDirty();

	FUNC_END(DRET_NULL);
}

void CBufferManager::calcPassiveAttr()
{
	FUNC_BEGIN(BUFF_MOD);

	// 计算被动技能属性
	_passiveBuffAttr.resetBase();
	for (TEffectHashMap::iterator iter = _passivenessSkillEffect.begin(); iter != _passivenessSkillEffect.end(); ++iter)
	{
		CBufferEffect& buffer = iter->second;
		CBufferImpactBase* impactBase = buffer.buffImpact;
		if (NULL == impactBase)
		{
			continue;
		}

		if (impactBase->isRefreshAttr())
		{
			impactBase->getAttrs(&buffer, _owner, &_passiveBuffAttr);
		}
	}

	_owner->markAllAttrDirty();

	FUNC_END(DRET_NULL);
}

void CBufferManager::calcItemAttr()
{
	FUNC_BEGIN(BUFF_MOD);

	// 计算物品属性
	_itemBuffAttr.resetBase();
	for (TEffectHashMap::iterator iter = _activeItemEffect.begin(); iter != _activeItemEffect.end(); ++iter)
	{
		CBufferEffect& buffer = iter->second;
		CBufferImpactBase* impactBase = buffer.buffImpact;
		if (NULL == impactBase)
		{
			continue;
		}

		if (impactBase->isRefreshAttr())
		{
			impactBase->getAttrs(&buffer, _owner, &_itemBuffAttr);
		}
	}

	_owner->markAllAttrDirty();

	FUNC_END(DRET_NULL);
}

void CBufferManager::rebuildActionFlags()
{
	FUNC_BEGIN(BUFF_MOD);

	// 计算主动技能行为禁止
	_activeBuffAttr.actionBanFlags.cleanUp();
	for (TEffectHashMap::iterator iter = _activeSkillEffect.begin(); iter != _activeSkillEffect.end(); ++iter)
	{
		CBufferEffect& buffer = iter->second;
		CBufferImpactBase* impactBase = buffer.buffImpact;
		if (NULL == impactBase)
		{
			continue;
		}

		if (impactBase->isActionBan())
		{
			impactBase->getActionBan(&buffer, _owner, &_activeBuffAttr.actionBanFlags);
		}
	}

	FUNC_END(DRET_NULL);
}

void CBufferManager::rebuildEventFlags()
{
	FUNC_BEGIN(BUFF_MOD);

	// 重建主动技能事件
	_buffEventFlags.clearAll();
	for (TEffectHashMap::iterator iter = _activeSkillEffect.begin(); iter != _activeSkillEffect.end(); ++iter)
	{
		CBufferEffect& buff = iter->second;
		if (!buff.isActive())
		{
			continue;
		}

		buff.buffImpact->getBuffEvent(&buff, _owner, &_buffEventFlags);
	}

	FUNC_END(DRET_NULL);
}

TBufferAttrs* CBufferManager::getBuffAttrs()
{
	return &_activeBuffAttr;
}

TBufferAttrs* CBufferManager::getPassiveAttrs()
{
	return &_passiveBuffAttr;
}

TBufferAttrs* CBufferManager::getItemAttrs()
{
	return &_itemBuffAttr;
}

TAttrVal_t CBufferManager::getExpRate()
{
	return _itemBuffAttr.attrParam[BUFF_EFFECT_TYPE_ADD_EXP];
}

void CBufferManager::loadPassiveEffect()
{
	FUNC_BEGIN(BUFF_MOD);

// 	gxDebug("Load passive buffer!");
// 
// 	TOwnSkillVec skills;
// 	_owner->getSkillList(skills);
// 
// 	_passivenessSkillEffect.clear();
// 	for (uint32 i = 0; i < skills.size(); ++i)
// 	{
// 		CSkillConfigTbl* pSkillRow = DSkillTblMgr.find(skills[i].skillID);
// 		if (NULL == pSkillRow)
// 		{
// 			continue;
// 		}
// 
// 		if (pSkillRow->isPassiveSkill())
// 		{
// 			CSkillBuff skillBuffer;
// 			skillBuffer.buffTypeID = pSkillRow->buffEffectID;
// 			skillBuffer.skillID = skills[i].skillID;
// 			skillBuffer.casterType = _owner->getObjType();
// 			skillBuffer.casterObjUID = _owner->getObjUID();
// 			skillBuffer.casterObjGUID = _owner->getObjGUID();
// 			skillBuffer.level = skills[i].level;
// 			addPassiveEffect(skillBuffer);
// 		}
// 	}

	processPassivEffect();

	FUNC_END(DRET_NULL);
}

CBufferEffect* CBufferManager::getBuff(TBufferTypeID_t buffID)
{
	FUNC_BEGIN(BUFF_MOD);

	TEffectHashMap::iterator iter = _activeSkillEffect.find(buffID);
	if (iter != _activeSkillEffect.end())
	{
		return &(iter->second);
	}

	iter = _passivenessSkillEffect.find(buffID);
	if (iter != _passivenessSkillEffect.end())
	{
		return &(iter->second);
	}

	iter = _activeItemEffect.find(buffID);
	if (iter != _activeItemEffect.end())
	{
		return &(iter->second);
	}

	return NULL;

	FUNC_END(NULL);
}

bool CBufferManager::isOnDieEvt()
{
	return _buffEventFlags.get(BUFF_EVENT_FLAG_DIE);
}

bool CBufferManager::isOnDamageEvt()
{
	return _buffEventFlags.get(BUFF_EVENT_FLAG_HURT);
}

bool CBufferManager::isForceHateEvt()
{
	return _buffEventFlags.get(BUFF_EVENT_FLAG_FORCE_HATE);
}

bool CBufferManager::isReflectEvt()
{
	return _buffEventFlags.get(BUFF_EVENT_FLAG_REFLECT);
}

bool CBufferManager::isBuffIDExist(TBufferTypeID_t buffID)
{
	return _activeSkillEffect.find(buffID) != _activeSkillEffect.end()
		|| _passivenessSkillEffect.find(buffID) != _passivenessSkillEffect.end()
		|| _activeItemEffect.find(buffID) != _activeItemEffect.end();
}

void CBufferManager::logAttr(uint32 num)
{
	switch (num)
	{
	case 1:
	{
			  gxDebug("ActiveBuff:{0}", _activeBuffAttr.toString());
	}break;
	case 2:
	{
			  gxDebug("ItemBuff:{0}", _itemBuffAttr.toString());
	}break;
	case 3:
	{
			  gxDebug("PassiveBuff:{0}", _passiveBuffAttr.toString());
	}break;
	default:
	{

	}
	}
}

void CBufferManager::getBuffAry(TPackBufferAry* buffAry)
{
	for (TEffectHashMap::iterator iter = _activeSkillEffect.begin(); iter != _activeSkillEffect.end(); ++iter)
	{
		if (buffAry->isMax())
		{
			break;
		}

		CBufferEffect& buff = iter->second;
		buffAry->resize(buffAry->size() + 1);
		buffAry->at(buffAry->size() - 1).objUID = _owner->getObjUID();
		buffAry->at(buffAry->size() - 1).bufferTypeID = buff.buffTypeID;
	}

	for (TEffectHashMap::iterator iter = _activeItemEffect.begin(); iter != _activeItemEffect.end(); ++iter)
	{
		if (buffAry->isMax())
		{
			break;
		}

		CBufferEffect& buff = iter->second;
		buffAry->resize(buffAry->size() + 1);
		buffAry->at(buffAry->size() - 1).objUID = _owner->getObjUID();
		buffAry->at(buffAry->size() - 1).bufferTypeID = buff.buffTypeID;
	}
}

void CBufferManager::CalcPassiveAttr(TOwnSkillVec* skills, TBufferAttrs* buffAttrs)
{
	buffAttrs->resetBase();

// 	for (uint32 i = 0; i < skills.size(); ++i)
// 	{
// 		CSkillConfigTbl* pSkillConfig = DSkillTblMgr.find(skills[i].skillID);
// 		if (NULL == pSkillConfig)
// 		{
// 			gxError("Can't find skill!SkillID=%u", skills[i].skillID);
// 			continue;
// 		}
// 		if (!pSkillConfig->isPassiveSkill())
// 		{
// 			continue;
// 		}
// 		CBufferConfigTbl* pBuffRow = DBuffTblMgr.find(pSkillConfig->buffEffectID);
// 		if (NULL == pBuffRow)
// 		{
// 			gxError("Can't find skill!SkillID=%u", pSkillConfig->buffEffectID);
// 			continue;
// 		}
// 		if ((skills[i].level - 1) <= pBuffRow->getAttrArySize())
// 		{
// 			TBuffAttrAry& addAttrAry = pBuffRow->getAttrAry(skills[i].level - 1);
// 			buffAttrs.addValue(addAttrAry);
// 		}
// 	}
}

bool CBufferManager::isSleepEvt()
{
	return _buffEventFlags.get(BUFF_EVENT_FLAG_SLEEP);
}

void CBufferManager::onBeUseSkill(CCharacterObject* pAttacker)
{
	CBufferEffect* buff = _getEventBuff(BUFF_EVENT_FLAG_SLEEP);
	if (NULL == buff)
	{
		return;
	}

	if (pAttacker->isPet() && pAttacker->getRoleBaseOwner() != NULL &&
		pAttacker->getRoleBaseOwner()->getObjUID() == buff->casterObjUID)
	{
		return;
	}

	_delEventBuff(BUFF_EVENT_FLAG_SLEEP);
}

void CBufferManager::_delEventBuff(EBuffEventFlag eventFlag)
{
	for (TEffectHashMap::iterator iter = _activeSkillEffect.begin(); iter != _activeSkillEffect.end(); ++iter)
	{
		CBufferEffect& buff = iter->second;
		if (buff.buffImpact->isEvent(eventFlag))
		{
			buff.active = false;
		}
	}
}

CBufferEffect* CBufferManager::_getEventBuff(EBuffEventFlag eventFlag)
{
	for (TEffectHashMap::iterator iter = _activeSkillEffect.begin(); iter != _activeSkillEffect.end(); ++iter)
	{
		CBufferEffect& buff = iter->second;
		if (buff.buffImpact->isEvent(eventFlag))
		{
			return &buff;
		}
	}

	return NULL;
}

bool CBufferManager::isStopEvt()
{
	return _buffEventFlags.get(BUFF_EVENT_FLAG_STOP);
}

bool CBufferManager::isDizzEvt()
{
	return _buffEventFlags.get(BUFF_EVENT_FLAG_DIZZ);
}
