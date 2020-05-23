#include "ai_character.h"
#include "obj_character.h"
#include "object.h"

CAICharacter::CAICharacter(void)
{
	_character = NULL;
}

CAICharacter::~CAICharacter(void)
{
	_character = NULL;
}

bool CAICharacter::init(CCharacterObject *pCharacter)
{
	_character = pCharacter;
	return true;
}

CCharacterObject * CAICharacter::getCharacter() const
{
	return _character;
}

void CAICharacter::onDie(CCharacterObject *pKiller /*= NULL*/)
{

}

void CAICharacter::onHurt(sint32 damage, CCharacterObject* pAttacker)
{

}

void CAICharacter::onBeSkill(CCharacterObject* pCharacter, sint32 goodEffect)
{

}

void CAICharacter::onKillObject(CCharacterObject* pCharacter)
{

}

void CAICharacter::onAddEnemy(TObjUID_t objUID, THateValue_t hateVal, EAddApproachObjectType addType /*= ADD_APPROACH_MON_TYPE_DAMAGE*/)
{

}

void CAICharacter::onDelEnemy(TObjUID_t objUID, bool byEnemyFlag /*= false*/)
{
}
