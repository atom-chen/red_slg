// #include "ai_pet.h"
// #include "obj_character.h"
// #include "time_util.h"
// #include "game_util.h"
// #include "debug.h"
// #include "server_define.h"
// #include "game_struct.h"
// #include "role.h"
// #include "map_scene.h"
// 
// #define DELAY_TIME (5000)
// #define PET_MOVE_RANGE (5)
// #define MAX_TRY_TIMES (5)
// 
// #define DGetPetScene(TYPEOFRETURN) \
// 	CObjPet* pObjPet = getCharacter(); \
// if (!pObjPet) { toIdle(); gxAssert(false); return TYPEOFRETURN; } \
// if (pObjPet->isDie()) { return TYPEOFRETURN; } \
// 	CMapScene* pScene = pObjPet->getScene(); \
// if (!pScene) { toIdle(); gxAssert(false); return TYPEOFRETURN; }
// 
// CPetAI::CPetAI(void)
// {
// 	_idleTimer.init(1000);
// }
// 
// CPetAI::~CPetAI(void)
// {
// }
// 
// bool CPetAI::init(CCharacterObject *pCharacter)
// {
// 	bool bResult = TBaseType::init(pCharacter);
// 	if (!bResult)
// 	{
// 		return false;
// 	}
// 
// 	_idleTimer.init(500);
// 
// 	return true;
// }
// 
// void CPetAI::term(void)
// {
// 	TBaseType::term();
// }
// 
// void CPetAI::AILogicIdle(GXMISC::TDiffTime_t diff)
// {
// 	if (!_idleTimer.update(diff))
// 	{
// 		return;
// 	}
// 	_idleTimer.reset(true);
// 
// 	CObjPet* pPet = getCharacter();
// 	if (pPet)
// 	{
// 		if (isCombatBeOver())
// 		{
// 			//clearCombat();
// 			changeMoveMode();
// 		}
// 		else
// 		{
// 			toApproach();
// 		}
// 	}
// }
// 
// void CPetAI::AILogicCombat(GXMISC::TDiffTime_t diff)
// {
// 	CObjPet* pPet = getCharacter();
// 	if (NULL == pPet)
// 	{
// 		gxAssertEx(false, "[AI_Pet::Logic_Combat]: NULL m_pCharacter Found!! check it now.");
// 		return;
// 	}
// 
// 	if (isGoToOwner())
// 	{
// 		if (pPet->canMove())
// 		{
// 			toIdle();
// 		}
// 
// 		return;
// 	}
// 
// 	if (!_idleTimer.update(diff))
// 	{
// 		return;
// 	}
// 	_idleTimer.reset(true);
// 
// 	// 是否结束战斗
// 	if (isCombatBeOver())
// 	{
// 		toIdle();
// 		return;
// 	}
// 
// 	// 如果当前攻击还没结束则不进行任何操作
// 	if (!pPet->canUseSkill())
// 	{
// 		return;
// 	}
// 
// 	if (pPet->isMoving())
// 	{// 如果还在Moving则不进行攻击
// 		return;
// 	}
// 
// 	if (!doAttack())
// 	{
// 		toApproach();
// 	}
// }
// 
// void CPetAI::AILogicApproach(GXMISC::TDiffTime_t diff)
// {
// 	if (!_idleTimer.update(diff))
// 	{
// 		return;
// 	}
// 	_idleTimer.reset(true);
// 
// 	if (isCombatBeOver())
// 	{
// 		toIdle();
// 		return;
// 	}
// 
// 	if (doAttack())
// 	{
// 		toAttack();
// 		return;
// 	}
// 
// 	DGetPetScene(DRET_NULL);
// 	CCharacterObject* pCurEnemy = pScene->getCharacterByUID(pObjPet->getTarObjUID());
// 	float fDist = CGameMisc::MySqrt(pObjPet->getAxisPos(), pCurEnemy->getAxisPos());
// 	if (ZERO_VALUE >= fDist)
// 	{/** 如果到达目的地 */
// 		toAttack();
// 	}
// 	else
// 	{
// 		doApproach();
// 	}
// }
// 
// void CPetAI::changeMoveMode()
// {
// 	FUNC_BEGIN(PET_MOD);
// 
// 	CObjPet* pPet = getCharacter();
// 	if (!pPet)
// 	{
// 		return;
// 	}
// 
// 	if (NULL == pPet->getScene())
// 	{
// 		return;
// 	}
// 
// 	CRole* pOwner = pPet->getRoleOwner();
// 	if (!pOwner)
// 	{
// 		pPet->setDie();
// 		return;
// 	}
// 
// 	if (pOwner->getMapID() != pPet->getMapID())
// 	{
// 		if (NULL == pOwner->getScene())
// 		{
// 			gxError("Owner scene is null!%s,%s", pOwner->toString(), pPet->toString());
// 			gxAssert(false);
// 			return;
// 		}
// 
// 		pPet->changeMap(pOwner->getScene(), pOwner->getAxisPos());
// 		return;
// 	}
// 
// 	double fDistSqr = calcDistSqrOfToOwner();
// 	if (fDistSqr > MAX_PET_FAR_AWAY_FROM_TELETE*MAX_PET_FAR_AWAY_FROM_TELETE)
// 	{// 距离大于15m则瞬移
// 		if (pPet->canMove())
// 		{// 非强控制下才能瞬移:如定身, 眩晕...
// 			TAxisPos pos = pOwner->getAxisPos();
// 			pPet->getScene()->getMapData()->findRandEmptyPos(pos, 3);       // @todo
// 			pPet->resetPos(pos, RESET_POS_TYPE_WINK, true, false);
// 			pPet->setMoveMode(MOVE_MODE_WALK);
// 			pPet->clearAllApproachMon();
// 			return;
// 		}
// 	}
// 	else if (fDistSqr > (MAX_PET_FAR_AWAY_FROM_SPRINT)*(MAX_PET_FAR_AWAY_FROM_SPRINT))
// 	{// 距离大于8m则快速跑
// 		pPet->setMoveMode(MOVE_MODE_SPRINT);
// 	}
// 	else if (fDistSqr > (MAX_PET_FAR_AWAY_FROM_RUN)*(MAX_PET_FAR_AWAY_FROM_RUN))
// 	{// 距离大于5m则小跑
// 		if (pPet->getMoveMode() != MOVE_MODE_SPRINT)
// 		{
// 			pPet->setMoveMode(MOVE_MODE_RUN);
// 		}
// 	}
// 	else
// 	{// 距离在5m以内,正常跟随
// 		if (pPet->getMoveMode() != MOVE_MODE_WALK)
// 		{
// 			pPet->setMoveMode(MOVE_MODE_HOBBLE);
// 		}
// 	}
// 
// 	if (!getCharacter()->isMoving() && fDistSqr > (MAX_PET_FAR_AWAY_FROM_TELETE / 5)*(MAX_PET_FAR_AWAY_FROM_TELETE / 5))
// 	{
// 		TAxisPos tarPos = pPet->getAxisPos();
// 		if (NULL != pOwner->getScene())
// 		{
// 			tarPos = pOwner->getAxisPos();
// 			tarPos = pOwner->getPetFllowPos();
// 		}
// 
// 		petToGo(&tarPos);
// 	}
// 
// 	FUNC_END(DRET_NULL);
// }
// 
// double CPetAI::calcDistSqrOfToOwner(void)
// {
// 	CObjPet* pPet = getCharacter();
// 	if (pPet)
// 	{
// 		CRole* pOwner = getCharacter()->getRoleOwner();
// 		if (pOwner)
// 		{
// 			TAxisPos_t fDeltaX = pOwner->getAxisPos().x - pPet->getAxisPos().x;
// 			TAxisPos_t fDeltaZ = pOwner->getAxisPos().y - pPet->getAxisPos().y;
// 
// 			return (fDeltaX*fDeltaX + fDeltaZ*fDeltaZ);
// 		}
// 	}
// 
// 	return 1000;
// }
// 
// void CPetAI::eventOnDie(CCharacterObject *pKiller/* = NULL*/)
// {
// 	// 收回宠物
// }
// 
// void CPetAI::petToGo(const TAxisPos *paTargetPos)
// {
// 	if (!paTargetPos)
// 	{
// 		gxAssert(NULL && "AI_Pet::Baby_Go...paTargetPos=NULL...");
// 		return;
// 	}
// 	if (!getCharacter())
// 	{
// 		return;
// 	}
// 
// 	CRole* pOwner = getCharacter()->getRoleOwner();
// 	if (!pOwner)
// 	{
// 		return;
// 	}
// 
// 	// 确保位置的合法性
// 	objMove(paTargetPos, true);
// }
// 
// void CPetAI::petToAttack(void)
// {
// 	toAttack();
// }
// 
// void CPetAI::relive(CCharacterObject* pCharacter)
// {
// 	CObjPet* pPet = getCharacter();
// 	if (!pPet)
// 	{
// 		gxAssert(NULL && "AI_Pet::Relive...pPet=NULL...");
// 		return;
// 	}
// 
// 	if (pPet->getHp() > 0)
// 	{
// 		pPet->setActionBan(ACTION_BAN_LIVE);
// 		return;
// 	}
// 
// 	THp_t nHP;
// 	if (pPet->getReliveInfo().hp.isRate())
// 	{
// 		nHP = (pPet->getReliveInfo().hp.valueType * pPet->getMaxHp()) / MAX_BASE_RATE;
// 		pPet->hpChange(nHP, pCharacter);
// 	}
// 	else
// 	{
// 		if (pPet->getReliveInfo().hp.attrValue > 0)
// 		{
// 			nHP = pPet->getReliveInfo().hp.attrValue;
// 			pPet->hpChange(nHP, pCharacter);
// 		}
// 	}
// 	// 保证一定会复活
// 	if (pPet->getHp() <= 0)
// 	{
// 		pPet->hpChange(1, pCharacter);
// 	}
// 
// 	// @todo 检测角色是否有敌人
// 	changeState(AI_STATE_IDLE);
// }
// 
// void CPetAI::doRandMove()
// {
// 	CObjPet* pObjPet = getCharacter();
// 	if (NULL == pObjPet)
// 	{
// 		return;
// 	}
// 
// 	CMapScene* pScene = pObjPet->getScene();
// 	if (NULL == pScene)
// 	{
// 		return;
// 	}
// 
// 	CRole* pRole = pObjPet->getRoleOwner();
// 	if (NULL == pRole)
// 	{
// 		return;
// 	}
// 
// 	TAxisPos tar = pRole->getAxisPos();
// 	if (!pScene->getMapData()->findRandEmptyPos(tar, PET_MOVE_RANGE))
// 	{
// 		return;
// 	}
// 
// 	if (!objMove(&tar, false))
// 	{
// 		return;
// 	}
// }
// 
// bool CPetAI::isCombatBeOver()
// {
// 	DGetPetScene(true);
// 
// 	CRole* pCreator = pObjPet->getRoleOwner();
// 	if (!pCreator)
// 	{
// 		return true;
// 	}
// 	if (INVALID_OBJ_UID != pObjPet->getTarObjUID())
// 	{
// 		CCharacterObject* pObj = pScene->getCharacterByUID(pObjPet->getTarObjUID());
// 		if (pObj && !pObj->isDie())
// 		{
// 			if (!pObj->isCanViewMe(pCreator))
// 			{// 如果宠物的看不到目标则战斗结束
// 				return true;
// 			}
// 
// 			if (!pObjPet->isInValidRadius(pObj, MAX_SAME_SCREEN_RANGE + 5))
// 			{// 距离大于15B则自动结束战斗
// 				return true;
// 			}
// 
// 			if (isGoToOwner())
// 			{
// 				return true;
// 			}
// 
// 			return false;
// 		}
// 		else
// 		{
// 			return true;
// 		}
// 	}
// 
// 	return true;
// }
// 
// CObjPet* CPetAI::getCharacter()
// {
// 	return dynamic_cast<CObjPet*>(TBaseType::getCharacter());
// }
// 
// void CPetAI::clearCombat()
// {
// 	getCharacter()->setTarObjUID(INVALID_OBJ_UID);
// }
// 
// void CPetAI::toIdle()
// {
// 	clearCombat();
// 	changeState(AI_STATE_IDLE);
// 	_idleTimer.init(1000);
// 	_idleTimer.update(700);
// }
// 
// void CPetAI::toAttack()
// {
// 	getCharacter()->clearMovePos();
// 	changeState(AI_STATE_COMBAT);
// 	_idleTimer.init(1000);
// 	_idleTimer.update(500);
// }
// 
// void CPetAI::toApproach()
// {
// 	DGetPetScene(DRET_NULL);
// 
// 	//     if(isCombatBeOver())
// 	//     {
// 	//         toIdle();
// 	//         return;
// 	//     }
// 
// 	CCharacterObject* pCurEnemy = pScene->getCharacterByUID(pObjPet->getTarObjUID());
// 	if (NULL == pCurEnemy)
// 	{
// 		pObjPet->setTarObjUID(INVALID_OBJ_UID);
// 		return;
// 	}
// 
// 	TAxisPos tarPos;
// 	if (!getMaxRangePos(tarPos))
// 	{
// 		return;
// 	}
// 	EGameRetCode oResult = objMove(&tarPos, true);
// 	if (!IsSuccess(oResult))
// 	{
// 		getCharacter()->directMoveTo(pCurEnemy->getAxisPos());
// 	}
// 
// 	changeState(AI_STATE_APPROACH);
// 	_idleTimer.init(1000);
// }
// 
// bool CPetAI::getMaxRangePos(TAxisPos& pos)
// {
// 	DGetPetScene(false);
// 
// 	CCharacterObject* pCurEnemy = pScene->getCharacterByUID(pObjPet->getTarObjUID());
// 	if (!pCurEnemy)
// 	{
// 		pObjPet->setTarObjUID(INVALID_OBJ_UID);
// 		return false;
// 	}
// 
// 	if (!pObjPet->canMove())
// 	{
// 		return false;
// 	}
// 
// 	pos = pCurEnemy->getAxisPos();
// 
// 	return true;
// }
// 
// bool CPetAI::doAttack()
// {
// 	//    DGetPetScene(false);
// 
// 	return doBossSkill();
// }
// 
// bool CPetAI::doBossSkill()
// {
// 	DGetPetScene(false);
// 
// 	if (!pObjPet->isCommonSkillCdDown())
// 	{
// 		return true;
// 	}
// 
// 	if (_bossSkills.empty())
// 	{
// 		return false;
// 	}
// 
// 	if (pObjPet->getTarObjUID() == INVALID_OBJ_UID)
// 	{
// 		return false;
// 	}
// 
// 	// 目标
// 	CCharacterObject* pEnemy = pScene->getCharacterByUID(pObjPet->getTarObjUID());
// 	if (NULL == pEnemy)
// 	{
// 		pObjPet->setTarObjUID(INVALID_OBJ_UID);
// 		return true;
// 	}
// 	if (!pEnemy->isActive() || pEnemy->isDie())
// 	{
// 		pObjPet->setTarObjUID(INVALID_OBJ_UID);
// 		return false;
// 	}
// 
// 	TAxisPos tarPos = pEnemy->getAxisPos();
// 
// 	GXMISC::TAppTime_t curTime = DTimeManager.nowAppTime();
// 	// 执行技能
// 	for (TExtUseSkillList::iterator iter = _bossSkills.begin(); iter != _bossSkills.end();)
// 	{
// 		CSkillConfigTbl* pSkillConfig = DSkillTblMgr.find(iter->skill.skillID);
// 		if (NULL == pSkillConfig)
// 		{
// 			++iter;
// 			continue;
// 		}
// 
// 		if ((curTime - iter->startTime) < iter->cdTime)
// 		{
// 			++iter;
// 			continue;
// 		}
// 
// 		setUseSkill(iter->skill.skillID, iter->skill.level);
// 		EGameRetCode retCode = useSkill(pObjPet->getTarObjUID(), iter->skill.skillID, tarPos);
// 		cleanSkill();
// 		if (IsSuccess(retCode))
// 		{
// 			gxDebug("Do use skill!SkillID=%u", iter->skill.skillID);
// 			iter->startTime = curTime;
// 			iter->cdTime = pSkillConfig->cd;
// 			if (_bossSkills.size() > 1)
// 			{
// 				_bossSkills.push_back(*iter);
// 				iter = _bossSkills.erase(iter);
// 			}
// 			return true;
// 		}
// 
// 		gxDebug("Do use skill!SkillID=%u,ErrorCode=%u", iter->skill.skillID, retCode);
// 		++iter;
// 	}
// 
// 	return false;
// }
// 
// bool CPetAI::doApproach()
// {
// 	DGetPetScene(false);
// 
// 	// 尝试攻击
// 	if (doAttack())
// 	{
// 		toAttack();
// 		return true;
// 	}
// 
// 	// 靠近
// 	TAxisPos tarPos;
// 	if (!getMaxRangePos(tarPos))
// 	{
// 		return false;
// 	}
// 	EGameRetCode oResult = objMove(&tarPos, true);
// 	if (!IsSuccess(oResult))
// 	{
// 		pObjPet->directMoveTo(tarPos);
// 	}
// 
// 	return true;
// }
// 
// bool CPetAI::isGoToOwner()
// {
// 	double fDistSqr = calcDistSqrOfToOwner();
// 	if (fDistSqr > MAX_PET_FAR_AWAY_FROM_OWNER*MAX_PET_FAR_AWAY_FROM_OWNER)
// 	{
// 		return true;
// 	}
// 
// 	return false;
// }
// 
// TSkillLevel_t CPetAI::getSkillLevel(TSkillTypeID_t skillID)
// {
// 	if (skillID == _skill.skillID)
// 	{
// 		return _skill.level;
// 	}
// 
// 	for (TExtUseSkillList::iterator iter = _bossSkills.begin(); iter != _bossSkills.end(); ++iter)
// 	{
// 		if (skillID == iter->skill.skillID)
// 		{
// 			return iter->skill.level;
// 		}
// 	}
// 
// 	return INVALID_SKILL_LEVEL;
// }
// 
// void CPetAI::cleanSkill()
// {
// 	_skill.cleanUp();
// }
// 
// void CPetAI::setUseSkill(TSkillTypeID_t skillID, TSkillLevel_t skillLvl)
// {
// 	_skill.skillID = skillID;
// 	_skill.level = skillLvl;
// }
// 
// void CPetAI::loadSkill()
// {
// 	//	DGetPetScene(DRET_NULL);
// 
// 	CObjPet* pObjPet = getCharacter();
// 	if (NULL == pObjPet)
// 	{
// 		return;
// 	}
// 
// 	TOwnSkillVec skills;
// 	pObjPet->getSkillList(skills);
// 
// 	// 重新加载技能
// 	GXMISC::TAppTime_t curTime = DTimeManager.nowAppTime();
// 	TExtUseSkillList skillList;
// 	if (!skills.empty())
// 	{
// 		for (TOwnSkillVec::iterator iter = skills.begin(); iter != skills.end(); ++iter)
// 		{
// 			CSkillConfigTbl* pSkillConfig = DSkillTblMgr.find(iter->skillID);
// 			if (NULL == pSkillConfig || pSkillConfig->isPassiveSkill())
// 			{
// 				continue;
// 			}
// 
// 			TExtUseSkill skill;
// 			skill.skill = *iter;
// 			skill.startTime = curTime;
// 			skill.cdTime = 0;
// 			if (!_bossSkills.empty())
// 			{
// 				TExtUseSkillList::iterator findIter = std::find(_bossSkills.begin(), _bossSkills.end(), iter->skillID);
// 				if (findIter != _bossSkills.end())
// 				{
// 					skill.startTime = findIter->startTime;
// 					skill.cdTime = findIter->cdTime;
// 				}
// 			}
// 
// 			skillList.push_back(skill);
// 		}
// 	}
// 
// 	_bossSkills.clear();
// 	_bossSkills = skillList;
// 
// 	// 普通技能
// 	if (pObjPet->getCommSkillID() != INVALID_SKILL_TYPE_ID)
// 	{
// 		TExtUseSkill skill;
// 		skill.skill.skillID = pObjPet->getCommSkillID();
// 		skill.skill.level = 1;
// 		skill.startTime = curTime;
// 		skill.cdTime = 0;
// 		_bossSkills.push_back(skill);
// 	}
// }