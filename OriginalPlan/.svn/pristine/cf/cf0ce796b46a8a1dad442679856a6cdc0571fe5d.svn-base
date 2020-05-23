#include "skill_impact_manager.h"
#include "map_scene_base.h"
#include "game_config.h"

typedef struct _TempImpact
{
	uint32 SN;
	TObjUID_t objUID;
}TTempImpact;

void CAttackImpactPacketManager::addImpact( TAttackImpactDelay& delay )
{
	_attackImpactPacketList.insert(TAttackImpactPacketList::value_type(delay.SN, delay));
}

void CAttackImpactPacketManager::update( GXMISC::TDiffTime_t diff )
{
	std::list<_TempImpact> SNList;
	for(TAttackImpactPacketList::iterator iter = _attackImpactPacketList.begin(); iter != _attackImpactPacketList.end(); ++iter)
	{
		TAttackImpactDelay& delay = iter->second;
		delay.diff = delay.diff > diff ? delay.diff-diff : 0;
		if(delay.diff <= 0)
		{
			TTempImpact impact;
			impact.SN = delay.SN;
			impact.objUID = delay.objUID;
			SNList.push_back(impact);
		}
	}

	for(std::list<TTempImpact>::iterator iter = SNList.begin(); iter != SNList.end(); ++iter)
	{
		doImpact(iter->SN, iter->objUID);
		_attackImpactPacketList.erase(iter->SN);
	}
}

void CAttackImpactPacketManager::doImpact( uint32 SN, TObjUID_t objUID )
{
	TAttackImpactPacketList::iterator iter = _attackImpactPacketList.find(SN);
	if(iter == _attackImpactPacketList.end())
	{
		return;
	}
	
	TAttackImpactDelay& delay = iter->second;
	CCharacterObject* pChart = _scene->getCharacterByUID(delay.objUID);
	if(NULL == pChart)
	{
		_attackImpactPacketList.erase(SN);
		return;
	}

	if(delay.objUID != objUID)
	{
		return;
	}

//	_scene->broadCast(delay.impacts, pChart, true);
	
	// 将Impact分类, 减血效果和加血效果
	MCAttackImpact addAttrImpact;
	addAttrImpact.skillID = delay.impacts.skillID;
	MCAttackImpact descAttrImpact;
	descAttrImpact.skillID = delay.impacts.skillID;
	for(uint32 i = 0; i < delay.impacts.attackors.size(); ++i)
	{
		if(delay.impacts.attackors[i].hp > 0)
		{
			addAttrImpact.attackors.pushBack(delay.impacts.attackors[i]);
		}
		else
		{
			descAttrImpact.attackors.pushBack(delay.impacts.attackors[i]);
		}
	}
	
	// 加血效果直接广播
	if(!addAttrImpact.attackors.empty())
	{
		_scene->broadCast(addAttrImpact, pChart, true, g_GameConfig.broadcastRange);
	}

	// 减血效果分别通知攻击者和被攻击者
	if(!descAttrImpact.attackors.empty())
	{
		// 通知攻击者
		if(NULL != pChart->getRoleBaseOwner())
		{
			pChart->getRoleBaseOwner()->sendPacket(descAttrImpact);
		}

		// 通知受击者
		for(uint32 i = 0; i < descAttrImpact.attackors.size(); ++i)
		{
			CCharacterObject* pAttackor = _scene->getCharacterByUID(descAttrImpact.attackors[i].objUID);
			if(NULL == pAttackor)
			{
				continue;
			}

			if(pAttackor->isMonster() && pAttackor->isDie())
			{
				if(delay.attackBackFlag)
				{
					// 被技能击退
					TDir_t dir = CGameMisc::GetDir(*pChart->getAxisPos(), *pAttackor->getAxisPos());
					pAttackor->attackBack(dir, g_GameConfig.skillAttackBackRange);
				}
			}

			if(pAttackor->getRoleBaseOwner() == NULL)
			{
				continue;
			}

			MCAttackImpact descPack;
			descPack.skillID = delay.impacts.skillID;
			descPack.attackors.pushBack(descAttrImpact.attackors[i]);
			pAttackor->getRoleBaseOwner()->sendPacket(descPack);
		}
	}

	_attackImpactPacketList.erase(SN);
}

uint32 CAttackImpactPacketManager::genSN()
{
	return _randSN++;
}

void CAttackImpactPacketManager::initMe(CMapSceneBase* pScene)
{
	_scene = pScene;
}