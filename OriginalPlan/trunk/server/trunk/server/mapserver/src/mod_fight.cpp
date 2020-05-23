#include "mod_fight.h"
#include "fight_struct.h"

CModFight::CModFight()
{
	_fightRecord.cleanUp();
}

CModFight::~CModFight()
{

}

bool CModFight::onLoad()
{
	return true;
}

void CModFight::onSendData()
{

}

void CModFight::onSave(bool offLineFlag)
{

}

TFightRecord* CModFight::getFightRecrod()
{
	return &_fightRecord;
}
