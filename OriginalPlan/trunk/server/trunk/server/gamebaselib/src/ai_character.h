#ifndef _AI_CHARACTER_H_
#define _AI_CHARACTER_H_

class CCharacterObject;

#include "game_util.h"

class CAICharacter
{
public:
	CAICharacter(void);
	virtual ~CAICharacter(void);

public:
	virtual bool init(CCharacterObject *character);

public:
	virtual void relive(CCharacterObject* pCharacter){}

	// ÊÂ¼þ
public:
	virtual void onDie(CCharacterObject *pKiller = NULL);
	virtual void onHurt(sint32 damage, CCharacterObject* pAttacker);
	virtual void onBeSkill(CCharacterObject* pCharacter, sint32 goodEffect);
	virtual void onKillObject(CCharacterObject* pCharacter);
	virtual void onAddEnemy(TObjUID_t objUID, THateValue_t hateVal, EAddApproachObjectType addType = ADD_APPROACH_MON_TYPE_DAMAGE);
	virtual void onDelEnemy(TObjUID_t objUID, bool byEnemyFlag = false);

public:
	CCharacterObject *getCharacter()const;

protected:
	CCharacterObject *_character;
};

#endif