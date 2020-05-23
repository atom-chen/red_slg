#include "monster.h"
#include "packet_struct.h"
#include "game_struct.h"
#include "map_scene.h"
#include "server_define.h"
#include "time_manager.h"
#include "scene_manager.h"
#include "game_rand.h"
#include "map_server.util.h"
#include "object_pet.h"
#include "scan_teammate.h"
#include "tbl_monster_distribute.h"
#include "tbl_monster.h"
#include "tbl_server_param.h"
#include "game_config.h"
#include "map_data.h"
#include "map_data_manager.h"
#include "game_exception.h"

CMonster::CMonster()
{
	cleanUp();
}

CMonster::~CMonster()
{
}

uint16 CMonster::getShapeData(char* data, uint32 maxSize)
{
	TPackMonsterShape* shape = (TPackMonsterShape*)data;
	shape->objUID = getObjUID();
	shape->typeID = _monsterTypeID;
	shape->curHp = getHp();
	shape->curMp = getEnergy();
	shape->dir = getDir();
	shape->actionBan = *_banAction.getState();
	shape->xPos = getAxisPos()->x;
	shape->yPos = getAxisPos()->y;
	shape->moveSpeed = getMoveSpeed();
	return shape->getShapeLen();
}

bool CMonster::onLoadFromTbl(CMonsterDistributeConfigTbl* distribute, TBlockID_t blockID, CMapScene* pScene)
{
	CMonsterConfigTbl* monsterTblRow = DMonsterTblMgr.find(distribute->monsterID);
	if (NULL == monsterTblRow)
	{
		gxWarning("Can't find monster config row!{0}", distribute->toString());
		return NULL;
	}
	_distributeTbl = distribute;
	_configTbl = monsterTblRow;
	_bornRectIndex = blockID;

	TAxisPos pos;
	CMap* mapData = DMapDataMgr.findMap(distribute->mapID);
	if (NULL == mapData)
	{
		gxError("Can't find monster map! MapID={0}, MonsterID={1}", distribute->mapID, monsterTblRow->id);
		return false;
	}

	TAxisPos top = distribute->axisRects[blockID].top;
	TAxisPos bottom = distribute->axisRects[blockID].bottom;
	mapData->findRandEmptyPos(&top, &bottom, &pos);
	top = distribute->top;
	bottom = distribute->bottom;
	mapData->verifyPos(&top, &bottom, &pos);
	if (!mapData->isCanWalk(&pos))
	{
		if (false == mapData->findRandEmptyPos(&top, &bottom, &pos))
		{
			gxError("Cant' find empty pos! MapID={0}, MonsterID={1}", distribute->mapID, monsterTblRow->id);
			return false;
		}
	}

	return onLoadFromTbl(monsterTblRow->id, distribute->mapID, pos, _configTbl->isRefresh == 1, pScene, false);
}

bool CMonster::onLoadFromTbl(TMonsterTypeID_t monsterTypeID, TMapID_t mapID, const TAxisPos& pos, bool needRefresh, CMapScene* pScene, bool randPosFlag)
{
	FUNC_BEGIN(MONSTER_MOD);

	CMonsterConfigTbl* monsterTblRow = DMonsterTblMgr.find(monsterTypeID);
	if (NULL == monsterTblRow)
	{
		gxWarning("Can't find monster config row!MonsterTypeID=%u,MapID=%u", monsterTypeID, mapID);
		return NULL;
	}
	_configTbl = monsterTblRow;
	_needRefresh = needRefresh;

	_monsterTypeID = monsterTblRow->id;
	_stepRandRange = monsterTblRow->moveDis;

	TAxisPos randPos = pos;
	if (randPosFlag)
	{
		TAxisPos top = pos;
		TAxisPos bottom = pos;
		top -= (uint16)2;
		bottom += (uint16)2;
		if (!pScene->findRandEmptyPos(&top, &bottom, &randPos))
		{
			randPos = pos;
		}
		_bornRect.set(top, bottom);
	}

	setBornPos(randPos);

	_ownerUID = getObjUID();

	loadBaseAttr();

	TCharacterInit inits;
	inits.axisPos = randPos;
	inits.dir = CGameMisc::RandDir();
	inits.die = false;
	inits.exp = 0;
	inits.hp = _configTbl->maxHp;
	inits.mp = _configTbl->maxMp;
	inits.job = JOB_TYPE_MONSTER;
	inits.mapID = mapID;
	inits.level = _configTbl->level;
	inits.moveSpeed = _configTbl->mSpeed;
	inits.type = OBJ_TYPE_MONSTER;
	inits.objUID = getObjUID();
	inits.ai = &_ai;
	inits.commSkillID = _configTbl->skillId;
	inits.commSkillLevel = _configTbl->skillLevel;

	if (false == init(inits))
	{
		return false;
	}

	_shapeUpdateTimer.init(MAX_SYNC_SHAPE_TIME);
	_attrBackup.setObjUID(getObjUID());
	refreshShape(false);

	return true;

	FUNC_END(false);
}

void CMonster::loadBaseAttr()
{
	_baseAttr.reset();

	_baseAttr.setMaxHp(_configTbl->maxHp);
	_baseAttr.setMaxEnergy(_configTbl->maxMp);
	_baseAttr.setPhysicAttck(_configTbl->physicAttack);
	_baseAttr.setDodge(_configTbl->dodge);
	_baseAttr.setPhysicDefense(_configTbl->physicDefense);
	_baseAttr.setCrit(_configTbl->crit);
	_baseAttr.setMoveSpeed(_configTbl->mSpeed);
	_initHateVal = 1;

	markAllAttrDirty();
}

void CMonster::onEnterScene(CMapScene* pScene)
{
	TBaseType::onEnterScene(pScene);
	_nextRandPosTime = DTimeManager.nowSysTime() + DRandGen.randUInt() % g_GameConfig.monRandMoveTime + 1;
	_lastFreshTime = GXMISC::MAX_GAME_TIME;
	_bornSceneID = pScene->getSceneID();
	_ai.toIdle();
}

void CMonster::onLeaveScene(CMapScene* pScene)
{
	TBaseType::onLeaveScene(pScene);

	_nextRandPosTime = GXMISC::MAX_GAME_TIME;
	_lastFreshTime = GXMISC::MAX_GAME_TIME;
}

bool CMonster::init(const TCharacterInit* inits)
{
	if (!TBaseType::init(inits))
	{
		return false;
	}

	_ai.init(this);
	_damageList.init(this);
	_lastDamageCheckTime = DTimeManager.nowSysTime();

	return true;
}

bool CMonster::update(uint32 diff)
{
	TBaseType::update(diff);

	if ((DTimeManager.nowSysTime() - _lastDamageCheckTime) >= g_GameConfig.monDamageCheckTime)
	{
		// 伤害检测的间隔时间
		_damageList.check();
		_lastDamageCheckTime = DTimeManager.nowSysTime();
	}

	_shapeUpdateTimer.update(diff);
	refreshShape(true);

	return true;
}

void CMonster::cleanUp()
{
	TBaseType::cleanUp();

	_lastFreshTime = GXMISC::MAX_GAME_TIME;
	_ownerUID = INVALID_OBJ_UID;
	_damageList.cleanUp();
	_resetPosFlag = false;
	_initHateVal = INVALID_HATE_VALUE;
	_nextRandPosTime = 0;
	_distributeTbl = NULL;
	_configTbl = NULL;
	_needRefresh = false;
	_resetPosFlag = false;
	_bornPos.cleanUp();
	_bornRectIndex = 0;
	_monsterTypeID = INVALID_MONSTER_TYPE_ID;
	_stepRandRange = 0;
	_nextRandPosTime = GXMISC::MAX_GAME_TIME;
	_lastFreshTime = GXMISC::MAX_GAME_TIME;
	_bornSceneID = INVALID_SCENE_ID;
	_dropRoles.clear();
	_lastDamageCheckTime = GXMISC::MAX_GAME_TIME;
	_attrBackup.cleanUp();
	_shapeUpdateTimer.init(1000);
	_summonor.clear();
}


void CMonster::doRandMove(GXMISC::TGameTime_t curTime)
{
	if (!canMove())
	{
		return;
	}

	if (isDie())
	{
		return;
	}

	if (!isTimeRandMove(curTime))
	{
		return;
	}

	_nextRandPosTime = DTimeManager.nowSysTime() + DRandGen.randUInt() % g_GameConfig.monRandMoveTime + 10;
	if (!posListEmpty())
	{
		return;
	}

	TAxisPos pos = _bornPos;
	if (CGameMisc::IsInValidRadius(getAxisPos()->x, getAxisPos()->y, _bornPos.x, _bornPos.y, g_GameConfig.maxMonRandMoveRange))
	{
		if (!getScene()->findRandEmptyPos(&pos, g_GameConfig.maxMonRandMoveRange))
		{
			return;
		}
	}

	TBaseType::move(&pos, false);
}

void CMonster::setBornPos(TAxisPos& bornPos)
{
	_bornPos = bornPos;
	setAxisPos(&bornPos);
}

TAxisPos CMonster::getBornPos()
{
	return _bornPos;
}

bool CMonster::isTimeFresh(GXMISC::TGameTime_t curTime)
{
	return ((curTime - _lastFreshTime) > _configTbl->refreshTime && isDie()) || !isActive();
}

bool CMonster::isTimeRandMove(GXMISC::TGameTime_t curTime)
{
	if (curTime > _nextRandPosTime && (curTime - _nextRandPosTime) > 2)
	{
		if (DRandGen.randUInt() % 20 == 0)
		{
			return true;
		}

		_nextRandPosTime = DTimeManager.nowSysTime() + DRandGen.randUInt() % g_GameConfig.monRandMoveTime + 10;
	}

	if (curTime > _nextRandPosTime)
	{
		return true;
	}

	return false;
}

TSceneID_t CMonster::getBornSceneID()
{
	return _bornSceneID;
}

TAreaRect& CMonster::getBornRect()
{
	return _bornRect;
}

bool CMonster::isNeedFresh()
{
	return _needRefresh;
}

bool CMonster::isNeedToAttack(CCharacterObject* pObj)
{
	return pObj->isRole() || pObj->isPet();
}

const CMonsterAI* CMonster::getMonsterAI()const
{
	return (CMonsterAI*)getCharacterAI();
}

bool CMonster::canBeAttack()
{
	if (_ai.isGuardState())
	{
		return false;
	}

	return TBaseType::canBeAttack();
}

EGameRetCode CMonster::canAttackMe(CCharacterObject* pCharacter)
{
	EGameRetCode retCode = TBaseType::canAttackMe(pCharacter);
	if (!IsSuccess(retCode))
	{
		return retCode;
	}
	if (pCharacter->isRole())
	{
		if (_monsterTypeID == DTreasureTblMgr.getTreasureMonsterTypeID() && pCharacter->getLevel() < DServerParamTblMgr.getMaxNewPlayerLevel())
		{
			return RC_SKILL_NO_BE_ATTACK;
		}
	}
	return RC_SUCCESS;
}

void CMonster::onDie()
{
	calcDropOwner();

	TBaseType::onDie();
	_lastFreshTime = DTimeManager.nowSysTime();

	if (!_dropRoles.empty())
	{
		// 随机任务道具
		TItemIDVec items;
		getScene()->getItemBoxManger().getTaskItem(this, items);

		if (_configTbl->bossTag == BOSS_TAG_BOSS || _configTbl->bossTag == BOSS_TAG_WORLD)
		{
			// 掉落物品
			for (uint32 i = 0; i < _dropRoles.size(); ++i)
			{
				if (_dropRoles[i].dropItemFlag)
				{
					getScene()->addItemBox(this, _dropRoles[i].roleUID, items, false);
				}
			}

			// 世界Boss奖励
			if (_configTbl->bossTag == BOSS_TAG_WORLD)
			{
				std::vector<TRoleUID_t> roleVec;
				for (TDropRoleVec::iterator itr = _dropRoles.begin(); itr != _dropRoles.end(); ++itr)
				{
					roleVec.push_back((*itr).roleUID);
				}
				DWorldBossMgr.killMonster(getMonsterTypeID(), roleVec);
			}
		}
		else if (_configTbl->bossTag == BOSS_TAG_TREASURE)
		{
			DTreasureMgr.killMonster(_dropRoles[0].roleUID);
		}
		else
		{
			// 随机选一个玩家掉落道具
			uint32 randIndex = DRandGen.getRand<uint32>(0, _dropRoles.size() - 1);
			if (_dropRoles[randIndex].dropItemFlag)
			{
				getScene()->addItemBox(this, _dropRoles[randIndex].roleUID, items, false);
			}

			// 任务道具共享
			for (uint32 i = 0; i < _dropRoles.size() && !items.empty(); ++i)
			{
				if (i == randIndex)
				{
					continue;
				}

				CRole* pRole = DRoleManager.findByRoleUID(_dropRoles[i].roleUID);
				if (NULL == pRole)
				{
					continue;
				}

				if (pRole->getMission().isCollectItem())
				{
					getScene()->addItemBox(this, _dropRoles[i].roleUID, items, true);
				}
			}
		}

		// 打怪共享
		for (TDropRoleVec::iterator itr = _dropRoles.begin(); itr != _dropRoles.end(); ++itr)
		{
			CRole* pRole = DRoleManager.findByRoleUID(itr->roleUID);
			if (NULL == pRole || pRole->getObjUID() == _lastHurtMeObjUID)
			{
				continue;
			}

			pRole->onKillObject(this);
		}
	}

	// 经验分配, 按伤害来算
	if (_dropRoles.size() > 1)
	{
		// 计算总等级
		uint32 totalLevl = 0;
		for (uint32 i = 0; i < _dropRoles.size(); ++i)
		{
			CRole* pTempRole = DRoleManager.findByRoleUID(_dropRoles[i].roleUID);
			if (NULL == pTempRole || pTempRole->getMapID() != getMapID())
			{
				continue;
			}
			totalLevl += pTempRole->getLevel();
		}

		// 组队
		for (uint32 i = 0; i < _dropRoles.size(); ++i)
		{
			CRole* pTempRole = DRoleManager.findByRoleUID(_dropRoles[i].roleUID);
			if (NULL == pTempRole || pTempRole->getMapID() != getMapID())
			{
				continue;
			}

			double exps = _configTbl->exp;
			double teamRate = (1 + (double)(_dropRoles.size() - 1)*0.1);
			if (!pTempRole->getScene()->isRiskScene())
			{
				// 野外场景的经验组队分成
				double rate = ((double)1 / ((double)abs(pTempRole->getLevel() - getLevel()) / (double)20 + (double)1));
				double levelRate = ((double)pTempRole->getLevel() / (double)(pTempRole->getLevel() + totalLevl));
				exps = (exps*1.8*rate*levelRate);
			}
			exps *= teamRate;

			gxDebug("Get exp!Exp=%lf,%s", exps, pTempRole->toString());
			CObjPet* pObjPet = pTempRole->getCurPet();
			if (NULL != pObjPet)
			{
				gxDebug("Pet get exp!Exp=%lf,%s", exps, pTempRole->toString());
				pObjPet->addExp(GXMISC::gxDouble2Int<TExp_t>(exps*pTempRole->getAgainstIndulgeRate()));
			}
			if (pTempRole->isVIP())
			{
				exps *= (1 + pTempRole->getRoleVip().getVipExtraNum(VIP_HIT_MONSTER) / (double)MAX_BASE_RATE);
			}
			if (pTempRole->getBufferMgr().getExpRate() > 0)
			{
				exps *= (1 + pTempRole->getBufferMgr().getExpRate() / (double)MAX_BASE_RATE);
			}
			if (!pTempRole->getScene()->isPetIslandScene())
			{
				//宠物岛人物不加经验
				pTempRole->addExp(GXMISC::gxDouble2Int<TExp_t>(exps*pTempRole->getAgainstIndulgeRate()));
			}
		}
	}
	else if (_dropRoles.size() > 0)
	{
		// 单人
		CRole* pTempRole = DRoleManager.findByRoleUID(_dropRoles[0].roleUID);
		if (NULL != pTempRole)
		{
			double exps = _configTbl->exp*(1 / ((double)abs(getLevel() - pTempRole->getLevel()) / (double)50 + 1));
			gxDebug("Role get exp!Exp=%lf,%s", exps, pTempRole->toString());
			CObjPet* pObjPet = pTempRole->getCurPet();
			if (NULL != pObjPet)
			{
				pObjPet->addExp(GXMISC::gxDouble2Int<TExp_t>(exps*pTempRole->getAgainstIndulgeRate()));
				gxDebug("Pet get exp!Exp=%lf,%s", exps, pTempRole->toString());
			}

			if (pTempRole->isVIP())
			{
				exps *= (1 + pTempRole->getRoleVip().getVipExtraNum(VIP_HIT_MONSTER) / (double)MAX_BASE_RATE);
			}
			if (pTempRole->getBufferMgr().getExpRate() > 0)
			{
				exps *= (1 + pTempRole->getBufferMgr().getExpRate() / (double)MAX_BASE_RATE);
			}
			if (!pTempRole->getScene()->isPetIslandScene())
			{
				pTempRole->addExp(GXMISC::gxDouble2Int<TExp_t>(exps*pTempRole->getAgainstIndulgeRate()));
			}
		}
	}

	clearSummonMon();
}

void CMonster::onBeKill(CCharacterObject* pDestObj)
{
	TBaseType::onBeKill(pDestObj);
}

void CMonster::changeGuard(TMissionPos& missionPos, TObjUID_t objUID)
{
	FUNC_BEGIN(MISSION_MOD);
	_ai.changeGuard();
	_ai.addTeammate(objUID);
	_missionPos = missionPos;
	FUNC_END(DRET_NULL);
}

bool CMonster::isGuardState()
{
	return _ai.isGuardState();
}

void CMonster::cleanGuard()
{
	_ai.cleanGuard();
}

TScriptID_t CMonster::getAIScriptID()
{
	return _configTbl->ai;
}

sint32 CMonster::getInitHateValue()
{
	return _initHateVal;
}

void CMonster::updateDamageList(CCharacterObject* pCharacter, THp_t nDamage)
{
	FUNC_BEGIN(MONSTER_MOD);

	if (nDamage >= 1 && pCharacter)
	{
		CRole *pRole = NULL;

		EObjType nType = pCharacter->getObjType();
		switch (nType)
		{
		case OBJ_TYPE_ROLE:
			pRole = (CRole*)(pCharacter);
			break;
		case OBJ_TYPE_PET:
		{
							 pRole = pCharacter->getRoleOwner();
		}
			break;
		default:
			break;
		}

		if (pRole != NULL)
		{
			_damageList.update(pRole->getObjUID(), pRole->getTeamID(), nDamage);
		}
	}

	FUNC_END(DRET_NULL);
}

void CMonster::calcDropOwner()
{
	FUNC_BEGIN(MONSTER_MOD);

	CMapScene* pScene = getScene();
	_dropRoles.clear();
	TDamageRecord& damageRec = _damageList.getMaxDamageRec();
	CRole* pRole = getScene()->getRole(damageRec.killer);
	if (damageRec.type == DAMAGE_TYPE_TEAM)
	{
		if (NULL == pRole)
		{
			// 组队
			ScanTeammateInit scanInit;
			scanInit.blockID = getBlockID();
			scanInit.scanRange = MAX_DROP_ITEM_SCAN_TEAM;
			scanInit.scanRole = true;
			scanInit.scene = getScene();
			scanInit.teamID = damageRec.teamID;

			CScanActiveTeammates scans;
			scans.init(&scanInit);
			if (!getScene()->scan(&scans, true))
			{
				return;
			}
			if (NULL != scans.pRole)
			{
				pRole = scans.pRole;
			}
		}

		if (NULL == pRole)
		{
			return;
		}

		TeamMemberMap teamMems;
		pRole->getTeam().getTeamMember(teamMems);
		for (TeamMemberItr iter = teamMems.begin(); iter != teamMems.end(); ++iter)
		{
			CRole* pTempRole = pRole->getScene()->getRole(iter->first);
			if (NULL == pTempRole)
			{
				continue;
			}

			if (pTempRole->isInValidRadius(this, g_GameConfig.maxDropItemTeamMemRange))
			{
				TDropRole dropRole;
				dropRole.roleUID = pTempRole->getRoleUID();
				dropRole.dropItemFlag = true;
				if (_configTbl->bossTag == BOSS_TAG_BOSS && pScene->getSceneType() == SCENE_TYPE_SI_GUO_YA && !pTempRole->getMission().isSiGuoYaBoss(getMonsterTypeID()))
				{
					// 思过涯中没有接思过涯任务没有掉落
					dropRole.dropItemFlag = false;
				}

				_dropRoles.push_back(dropRole);
			}
		}
	}
	else
	{
		// 单人
		if (NULL != pRole)
		{
			TDropRole dropRole;
			dropRole.roleUID = pRole->getRoleUID();
			dropRole.dropItemFlag = true;
			if (_configTbl->bossTag == BOSS_TAG_BOSS && pScene->getSceneType() == SCENE_TYPE_SI_GUO_YA && !pRole->getMission().isSiGuoYaBoss(getMonsterTypeID()))
			{
				// 思过涯中没有接思过涯任务没有掉落
				dropRole.dropItemFlag = false;
			}

			_dropRoles.push_back(dropRole);
		}
	}

	FUNC_END(DRET_NULL);
}

bool CMonster::isSameCamp(CCharacterObject* obj)
{
	if (obj->getObjUID() == getObjUID())
	{
		return true;
	}

	if (getOwnerUID() == obj->getObjUID())
	{
		return true;
	}

	if (obj->isMonster())
	{
		return true;
	}

	return TBaseType::isSameCamp(obj);
}

void CMonster::setOwnerUID(TObjUID_t objUID)
{
	_ownerUID = objUID;
}

TObjUID_t CMonster::getOwnerUID()
{
	return _ownerUID;
}

TSkillLevel_t CMonster::getSkillLevel(TSkillTypeID_t skillID)
{
	if (skillID == getCommSkillID())
	{
		return _configTbl->skillLevel;
	}

	return _ai.getSkillLevel(skillID);
}

bool CMonster::canSummon()
{
	return _configTbl->aiParams[AI_TYPE_TOSUMMON].size() > 0;
}

bool CMonster::canApproach()
{
	return _configTbl->aiParams[AI_TYPE_APPROACH].size() > 0;
}

bool CMonster::canRandMove()
{
	return _configTbl->aiParams[AI_TYPE_RANDMOVE].size() > 0;
}

bool CMonster::canFlee()
{
	return _configTbl->aiParams[AI_TYPE_FLEE].size() > 0
		&& (getHpRate() <= (_configTbl->aiParams[AI_TYPE_FLEE][2] / (float)100))
		&& DRandGen.randOdds(MAX_BASE_RATE, _configTbl->aiParams[AI_TYPE_FLEE][4]);
}

float CMonster::getHpRate()
{
	return (getHp()*100.00f / getMaxHp());
}

void CMonster::refreshShape(bool sendFlag)
{
	if (!_shapeUpdateTimer.isPassed() && sendFlag)
	{
		return;
	}
	_shapeUpdateTimer.reset();

	_attrBackup.init(SYNC_DATA_MOD_SHAPE);
	if (_attrBackup.hp != getHp())
	{
		_attrBackup.setHp(getHp());
	}

	if (_attrBackup.moveSpeed != getMoveSpeed())
	{
		_attrBackup.setMoveSpeed(getMoveSpeed());
	}

	if (_attrBackup.isDirty() && sendFlag)
	{
		getScene()->broadCast(_attrBackup.getSyncData(), this, false);
	}

	_attrBackup.init(SYNC_DATA_MOD_SHAPE);
}

void CMonster::addSummonor(TObjUID_t objUID)
{
	_summonor.push_back(objUID);
}

void CMonster::clearSummonMon()
{
	// 召唤怪物全部死亡
	for (uint32 i = 0; i < _summonor.size(); ++i)
	{
		CMonster* pMonster = getScene()->getMonster(_summonor[i]);
		if (NULL == pMonster)
		{
			continue;
		}

		pMonster->setActive(false);
	}
}

CDamageMemList& CMonster::getDamageMemList()
{
	return _damageList;
}

void CMonster::checkMem()
{
#ifdef SERVER_DEBUG
	_damageList.checkAll(true);
	_damageList.cleanUp();
#endif
}

void CMonster::setResetPosFlag(bool flag)
{
	_resetPosFlag = flag;
}

bool CMonster::canResetPos()
{
	return _resetPosFlag;
}

uint8 CMonster::getBornRectIndex()
{
	return _bornRectIndex;
}

const char* CMonster::toString() const
{
#ifdef SERVER_DEBUG
	static std::string name;
	name = GXMISC::gxToString("AIState=%u,%s", _ai.getAIState()->getStateID(), TBaseType::toString());
	return name.c_str();
#endif

	return TBaseType::toString();
}

TDamageRecord* CDamageMemList::update(TObjUID_t killerID, TTeamIndex_t killerTeam, THp_t damage)
{
	TDamageRecord* pDamageRec = findMember(killerID, killerTeam);
	if (NULL == pDamageRec)
	{
		pDamageRec = addMember(killerID, killerTeam, damage);
	}
	else
	{
		pDamageRec->damage += damage;
		pDamageRec->lastCheckTime = DTimeManager.nowSysTime();
	}

	if (NULL != pDamageRec)
	{
		if (pDamageRec->damage > _maxDamageRec.damage)
		{
			_maxDamageRec = *pDamageRec;
		}
	}

	return pDamageRec;
}

TDamageRecord* CDamageMemList::addMember(TObjUID_t killerID, TTeamIndex_t killerTeam, THp_t damage)
{
	if (killerTeam != INVALID_TEAM_INDEX)
	{
		TDamageRecord& record = _damageRec[killerTeam];
		record.type = DAMAGE_TYPE_TEAM;
		record.killer = killerID;
		record.teamID = killerTeam;
		record.damage = damage;
		record.lastCheckTime = DTimeManager.nowSysTime();
		return &record;
	}
	else if (killerID != INVALID_OBJ_UID)
	{
		TDamageRecord& record = _damageRec[killerID];
		record.type = DAMAGE_TYPE_OBJ;
		record.killer = killerID;
		record.teamID = INVALID_TEAM_INDEX;
		record.damage = damage;
		record.lastCheckTime = DTimeManager.nowSysTime();
		return &record;
	}

	return NULL;
}

TDamageRecord* CDamageMemList::findMember(TObjUID_t killerID, TTeamIndex_t killerTeam)
{
	if (killerTeam != INVALID_TEAM_INDEX)
	{
		TDamageMap::iterator iter = _damageRec.find(killerTeam);
		if (iter != _damageRec.end())
		{
			return &(iter->second);
		}
	}
	else if (killerID != INVALID_OBJ_UID)
	{
		TDamageMap::iterator iter = _damageRec.find(killerID);
		if (iter != _damageRec.end())
		{
			return &(iter->second);
		}
	}

	return NULL;
}

void CDamageMemList::delMember(TObjUID_t killerID, TTeamIndex_t killerTeam, bool reGetMaxFlag)
{
	TObjUID_t objUID = INVALID_OBJ_UID;
	if (killerTeam != INVALID_TEAM_INDEX)
	{
		objUID = killerTeam;
	}
	else if (killerID != INVALID_OBJ_UID)
	{
		objUID = killerID;
	}

	if (objUID != INVALID_OBJ_UID)
	{
		_damageRec.erase(objUID);
		if (_maxDamageRec.killer == objUID || _maxDamageRec.teamID == killerTeam)
		{
			_maxDamageRec.cleanUp();
			if (reGetMaxFlag)
			{
				checkAll(false);
			}
		}
	}
}

TDamageRecord& CDamageMemList::getMaxDamageRec()
{
	return _maxDamageRec;
}

void CDamageMemList::check()
{
	if (_damageRec.size() > 10)
	{
		// 伤害列表太多不宜使用循环检测, 只要检测最高的就行了
		if (!checkMaxRec())
		{
			if (!_maxDamageRec.isInvalid())
			{
				delMember(_maxDamageRec.killer, _maxDamageRec.teamID, true);
			}
		}
	}
	else
	{
		checkAll(true);
	}
}

void CDamageMemList::checkAll(bool delFlag)
{
	TGameTime_t curTime = DTimeManager.nowSysTime();
	TDamageRecord* maxRecord = NULL;
	for (TDamageMap::iterator iter = _damageRec.begin(); iter != _damageRec.end();)
	{
		TDamageRecord& record = iter->second;
		CRole* pRole = _pMonster->getScene()->getRole(record.killer);
		if (NULL != pRole && _pMonster->isInValidRadius(pRole, g_GameConfig.maxDropItemTeamMemRange))
		{
			record.lastCheckTime = curTime;
		}

		if (record.lastCheckTime != curTime && record.type == DAMAGE_TYPE_TEAM)
		{
			// 组队检测
			ScanTeammateInit scanInit;
			scanInit.blockID = _pMonster->getBlockID();
			scanInit.scanRange = MAX_DROP_ITEM_SCAN_TEAM;
			scanInit.scanRole = true;
			scanInit.scene = _pMonster->getScene();
			scanInit.teamID = record.teamID;

			CScanActiveTeammates scans;
			scans.init(&scanInit);
			if (!_pMonster->getScene()->scan(&scans, true))
			{
				_damageRec.erase(iter++);
				continue;
			}

			if (NULL != scans.pRole)
			{
				record.lastCheckTime = curTime;
			}
		}

		if ((curTime - record.lastCheckTime) > MAX_MON_HATE_DIS_SECS && delFlag)
		{
			_damageRec.erase(iter++);
		}
		else
		{
			// 检测对方是否在视野范围内
			record.lastCheckTime = curTime;
			if (maxRecord == NULL)
			{
				maxRecord = &record;
			}
			else if (record.damage > maxRecord->damage)
			{
				maxRecord = &record;
			}
			++iter;
		}
	}

	if (maxRecord == NULL)
	{
		cleanUp();
	}
	else
	{
		_maxDamageRec = *maxRecord;
	}
}

bool CDamageMemList::checkMaxRec()
{
	TGameTime_t curTime = DTimeManager.nowSysTime();

	CRole* pRole = _pMonster->getScene()->getRole(_maxDamageRec.killer);
	if (NULL != pRole && _pMonster->isInValidRadius(pRole, g_GameConfig.maxDropItemTeamMemRange))
	{
		// 上次攻击的玩家还在视野范围内
		_maxDamageRec.lastCheckTime = curTime;
		return true;
	}

	if (_maxDamageRec.lastCheckTime != curTime && _maxDamageRec.type == DAMAGE_TYPE_TEAM)
	{
		// 攻击玩家不在视野范围内
		ScanTeammateInit scanInit;
		scanInit.blockID = _pMonster->getBlockID();
		scanInit.scanRange = MAX_DROP_ITEM_SCAN_TEAM;
		scanInit.scanRole = true;
		scanInit.scene = _pMonster->getScene();
		scanInit.teamID = _maxDamageRec.teamID;

		CScanActiveTeammates scans;
		scans.init(&scanInit);
		if (!_pMonster->getScene()->scan(&scans, true))
		{
			return false;
		}
		if (NULL != scans.pRole)
		{
			_maxDamageRec.lastCheckTime = curTime;
		}
	}

	if (curTime - _maxDamageRec.lastCheckTime > MAX_MON_HATE_DIS_SECS)
	{
		return false;
	}

	return true;
}

sint32 CDamageMemList::size()
{
	return _damageRec.size();
}