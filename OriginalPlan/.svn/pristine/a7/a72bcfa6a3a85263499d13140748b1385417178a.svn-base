#include "skill_util.h"
#include "obj_character.h"
#include "game_exception.h"
#include "module_def.h"

void CAttackorList::cleanUp()
{
	impacts.clear();
	characterList.clear();
}

void CAttackorList::push( CCharacterObject* pObj )
{
	TAttackorImpact impact;
	impact.objUID = pObj->getObjUID();

	if(!characterList.isMax())
	{
		characterList.pushBack(pObj);
	}
}

void CAttackorList::push( TAttackorImpact* impact )
{
	if(!impacts.isMax())
	{
		impacts.pushBack(*impact);
	}
}

uint32 CAttackorList::getAttackObjSize()
{
	return characterList.size();
}

uint32 CAttackorList::getImpactSize()
{
	return impacts.size();
}

void CAttackorList::logImpact()
{
	FUNC_BEGIN(SKILL_MOD);

	std::string logStr = "========================Show Skill Impact========================\n";
	for(uint32 i = 0; i < getImpactSize(); ++i)
	{
		logStr += impacts[i].toString() + "\n";
	}
	gxDebug("{0}", logStr.c_str());

	FUNC_END(DRET_NULL);
}

void CAttackorList::getAttactorList(TImpactObjUIDList* objs)
{
	for(sint32 i = 0; i < characterList.size(); ++i)
	{
		objs->pushBack(characterList[i]->getObjUID());
	}
}

double CAttackTarget::getTotalAddHp( bool calcMe, TObjUID_t objUID )
{
	double descHp = 0;
	for(uint32 i = 0; i < attackorList.getImpactSize(); ++i)
	{
		if(!calcMe && attackorList.impacts[i].objUID == objUID)
		{
			continue;
		}

		if(attackorList.impacts[i].hp > 0)
		{
			descHp += attackorList.impacts[i].hp;
		}
	}

	return descHp;
}

double CAttackTarget::getTotalDescHp( bool calcMe, TObjUID_t objUID )
{
	double descHp = 0;
	for(uint32 i = 0; i < attackorList.getImpactSize(); ++i)
	{
		if(!calcMe && attackorList.impacts[i].objUID == objUID)
		{
			continue;
		}

		if(attackorList.impacts[i].hp < 0)
		{
			descHp += attackorList.impacts[i].hp;
		}
	}

	return descHp;
}

void CAttackTarget::cleanUp()
{
	destObj = NULL;
	attackorList.cleanUp();
}

bool CAttackTarget::single()
{
	// 单体技能, destObj不为NULL且攻击列表大小不会超过2(自身和敌人);群攻技能, destObj必须为NULL且攻击列表不能为NULL
	gxAssert((destObj == NULL && !attackorList.characterList.empty()) || (destObj != NULL && attackorList.getImpactSize()<=2));
	return destObj != NULL;
}