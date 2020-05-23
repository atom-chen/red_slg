#include "monster_manager.h"
#include "map_scene.h"
#include "tbl_monster_distribute.h"
//#include "chat_system.h"
#include "monster.h"
#include "tbl_monster.h"

TObjUID_t CMonsterManager::genObjUID()
{
	if (_genObjUID >= INVALID_TEMP_MONSTER_UID)
	{
		return INVALID_OBJ_UID;
	}

	return _genObjUID++;
}

CMonster* CMonsterManager::addMonster(CMonsterDistributeConfigTbl* distribute, TBlockID_t blockID)
{
	CMonster* monster = _objPool.newObj();
	if (NULL == monster)
	{
		gxError("Can't new monster!MonsterTypeID={0}", distribute->monsterID);
		return NULL;
	}

	monster->setObjUID(genObjUID());
	if (NULL == monster->getObjUID())
	{
		gxError("Can't gen monster obj uid!");
		_objPool.deleteObj(monster);
		return NULL;
	}

	if (false == monster->onLoadFromTbl(distribute, blockID, _scene))
	{
		_objPool.deleteObj(monster);
		return false;
	}

	if (false == add(monster))
	{
		gxError("Can't add monster to manager! MonsterTypeID={0}", distribute->monsterID);
		_objPool.deleteObj(monster);
		return NULL;
	}

	//    gxInfo("Add monster: MonsterTypeID=%u, ObjUID=%u", distribute->monsterID, monster->getObjUID());

	return monster;
}

CMonster* CMonsterManager::addMonster(TMonsterTypeID_t monsterTypeID, TMapID_t mapID, const TAxisPos& pos, bool needRefresh)
{
	FUNC_BEGIN(MONSTER_MOD);

	CMonster* monster = _objPool.newObj();
	if (NULL == monster)
	{
		gxError("Can't new monster!MonsterTypeID={0}", monsterTypeID);
		return NULL;
	}

	monster->setObjUID(genObjUID());
	if (monster->getObjUID() == INVALID_OBJ_UID)
	{
		gxError("Can't gen monster obj uid!");
		_objPool.deleteObj(monster);
		return NULL;
	}

	if (!monster->onLoadFromTbl(monsterTypeID, mapID, pos, needRefresh, _scene))
	{
		_objPool.deleteObj(monster);
		return false;
	}

	if (false == add(monster))
	{
		gxError("Can't add monster to manager! MonsterTypeID={0}", monsterTypeID);
		_objPool.deleteObj(monster);
		return NULL;
	}

	gxInfo("Add monster: MonsterTypeID={0}, ObjUID={1}", monsterTypeID, monster->getObjUID());

	return monster;

	FUNC_END(NULL);
}

void CMonsterManager::delMonster(TObjUID_t objUID)
{
	if (!isExist(objUID))
	{
		gxError("Can't find monster! ObjUID=%u", objUID);
		gxAssert(false);
		return;
	}
	if (_guardMonster.findObj(objUID))
	{
		_guardMonster.delObj(objUID);
	}
	CMonster* monster = remove(objUID);

	if (_guardMonster.findObj(objUID))
	{
		_guardMonster.delObj(objUID);
	}

	if (NULL == monster)
	{
		gxAssert(false);
		gxError("Can't find monster! ObjUID=%u", objUID);
		return;
	}
	monster->cleanUp();

	_objPool.deleteObj(monster);
}

CMonster* CMonsterManager::findMonster(TObjUID_t objUID)
{
	return find(objUID);
}

uint32 CMonsterManager::size()
{
	return TBaseType::size();
}

bool CMonsterManager::init(uint32 num)
{
	return _objPool.init(num);
}

void CMonsterManager::setScene(CMapScene* pScene)
{
	_scene = pScene;
}

CMapScene* CMonsterManager::getScene()
{
	return _scene;
}

void CMonsterManager::update(GXMISC::TDiffTime_t diff)
{
	std::vector<CMonster*> delMonsters;

	TGameTime_t curTime = DTimeManager.nowSysTime();
	for (Iterator iter = begin(); iter != end(); ++iter)
	{
		CMonster* monster = iter->second;
		if (NULL != monster)
		{
			TBlockID_t blockID = monster->getBlockID();
			if (!getScene()->isBlockDirty(blockID) && !monster->isNeedUpdate())
			{
				continue;
			}
			monster->update(diff);

			if (monster->isTimeToLeaveScene(curTime))
			{
				_scene->leave(monster, true);
			}

			if (monster->isTimeFresh(curTime))
			{
				delMonsters.push_back(monster);
			}
		}
	}

	// Ë¢ÐÂ¹ÖÎï
	for (uint32 i = 0; i < delMonsters.size(); ++i)
	{
		freshMonster(delMonsters[i]);
	}

	// Ìí¼ÓÕÙ»½¹Ö
	for (uint32 i = 0; i < _addMonsters.size(); ++i)
	{
		CMonster* pOwnerMonster = getScene()->getMonster(_addMonsters[i].objUID);
		if (NULL == pOwnerMonster || pOwnerMonster->isDie())
		{
			continue;
		}

		for (uint32 j = 0; j < _addMonsters[i].num; ++j)
		{
			CMonster* pMonster = _scene->addMonster(_addMonsters[i].monsterTypeID, _addMonsters[i].pos, false);
			if (NULL == pMonster)
			{
				continue;
			}

			pMonster->setOwnerUID(_addMonsters[i].objUID);
			pOwnerMonster->addSummonor(pMonster->getObjUID());
		}
	}
	_addMonsters.clear();
}

void CMonsterManager::freshMonster(CMonster* monster)
{
	CMonsterDistributeConfigTbl* monsterRow = monster->getDistributeConfigTbl();
	bool freshFlag = monster->isNeedFresh();
	TBlockID_t blockID = monster->getBornRectIndex();
	TMonsterTypeID_t monsterTypeID = monster->getMonsterTypeID();
	TObjUID_t monserObjUID = monster->getObjUID();
	delMonster(monserObjUID);
	_scene->onMonsterDesc(size(), monsterTypeID, monserObjUID);
	if (freshFlag)
	{
		_scene->addMonster(monsterRow, blockID);
	}
}

void CMonsterManager::addGuardMonster(CMonster* pMonster, TMissionPos& pos, TObjUID_t objUID)
{
	_guardMonster.addObj(pMonster);
	pMonster->changeGuard(pos, objUID);
}

void CMonsterManager::updateGuardMonster(GXMISC::TDiffTime_t diff)
{
	std::vector<CMonster*> delMonsters;

	TGameTime_t curTime = DTimeManager.nowSysTime();
	for (CSceneObjectManager::Iterator iter = _guardMonster.begin(); iter != _guardMonster.end(); ++iter)
	{
		CMonster* monster = iter->second->toMonster();
		if (NULL != monster)
		{
			if (monster->isActive())
			{
				monster->update(diff);
			}
			else
			{
				_scene->leave(monster, true);
				delMonsters.push_back(monster);
			}
		}
	}

	// É¾³ý»¤ËÍ¹ÖÎï
	for (uint32 i = 0; i < delMonsters.size(); ++i)
	{
		_guardMonster.delObj(delMonsters[i]->getObjUID());
		delMonster(delMonsters[i]->getObjUID());
	}
}

void CMonsterManager::killAllMonster()
{
	for (Iterator iter = begin(); iter != end(); ++iter)
	{
		CMonster* monster = iter->second;
		if (monster != NULL)
		{
			monster->setDie();
		}
	}
}

void CMonsterManager::pushMonster(TMonsterTypeID_t monsterTypeID, uint8 num, const TAxisPos& pos, TObjUID_t ownerUID)
{
	TAddMonster addMonsters;
	addMonsters.monsterTypeID = monsterTypeID;
	addMonsters.num = num;
	addMonsters.pos = pos;
	addMonsters.objUID = ownerUID;
	_addMonsters.push_back(addMonsters);
}