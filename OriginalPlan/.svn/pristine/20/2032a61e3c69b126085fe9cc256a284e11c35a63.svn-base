#include "char_ai_core.h"
#include "obj_character.h"
#include "ai_character.h"
#include "map_scene_base.h"
#include "game_config.h"

CCharAICore::CCharAICore()
{
	cleanUp();
}

CCharAICore::~CCharAICore()
{
	cleanUp();
}

void CCharAICore::cleanUp()
{
	_characterAI = NULL;
	_character = NULL;
}

bool CCharAICore::init( const TCharacterInit* inits )
{
	return true;
}

bool CCharAICore::update( GXMISC::TDiffTime_t diff )
{
	return true;
}

bool CCharAICore::updateOutBlock( GXMISC::TDiffTime_t diff )
{
	return true;
}

void CCharAICore::setCharacterAI( CAICharacter* charAI )
{
	_characterAI = charAI;
}


CAICharacter* CCharAICore::getCharacterAI() const
{
	return _characterAI;
}

void CCharAICore::setCharacter( CCharacterObject* character )
{
	_character = character;
	if(NULL != _characterAI)
	{
		_characterAI->init(_character);
	}
}

bool CCharAICore::canBeApproach()
{
	return getApproachMonSize() < 5;
}

bool CCharAICore::needDropApproach()
{
	return getApproachMonSize() > 5;
}

void CCharAICore::delApproachByEnemy(TObjUID_t objUID)
{
	if(_character->isMonster())
	{
		_character->getCharacterAI()->onDelEnemy(objUID, true);
		assert(false);
	}
}

void CCharAICore::addApproachMon(TObjUID_t objUID, EAddApproachObjectType type)
{
	_approachList.addMon(objUID);
	onAddApproach(objUID);
}

void CCharAICore::delApproachMon(TObjUID_t objUID, EDelApproachObjectType type)
{
	_approachList.delMon(objUID);
	onDelApproach(objUID);
}

sint32 CCharAICore::getApproachMonSize()
{
	return _approachList.size();
}


void ApproachObjectList::addMon(TObjUID_t objUID)
{
	lastOptTime = DTimeManager.nowSysTime();
	if (lastObjUID == objUID)
	{
		return;
	}

	monsters.insert(objUID);
	lastObjUID = objUID;
}

void ApproachObjectList::cleanUp()
{
	lastOptTime = GXMISC::MAX_GAME_TIME - 1000;
	monsters.clear();
	lastObjUID = INVALID_OBJ_UID;
}

bool ApproachObjectList::needUpdate()
{
	return DTimeManager.nowSysTime() - lastOptTime > 2;
}

void ApproachObjectList::delMon(TObjUID_t objUID)
{
	monsters.erase(objUID);
	if (monsters.empty())
	{
		cleanUp();
	}
}

void ApproachObjectList::update()
{
	assert(false);
	if (needUpdate())
	{
		lastOptTime = DTimeManager.nowSysTime();
		for (std::set<TObjUID_t>::iterator iter = monsters.begin(); iter != monsters.end();)
		{
			CCharacterObject* pCharacter = pChart->getScene()->getCharacterByUID(*iter);
			if (NULL == pCharacter)
			{
				monsters.erase(iter++);
				continue;
			}

			if (!pCharacter->isInValidRadius(pChart, g_GameConfig.getSameScreenRadius()))
			{
				monsters.erase(iter++);
				continue;
			}

			iter++;
		}
	}
}

sint32 ApproachObjectList::size()
{
	return monsters.size();
}