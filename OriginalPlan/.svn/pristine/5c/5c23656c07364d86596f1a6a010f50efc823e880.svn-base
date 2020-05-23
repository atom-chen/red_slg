#include "game_module.h"
#include "obj_character.h"
#include "role.h"

bool CGameMoudle::init( CCharacterObject* chart )
{
	_owner = chart;
	return true;
}

CRole* CGameMoudle::getRole()
{
	return (CRole*)_owner->toRoleBase();
}

// CMonster* CGameMoudle::getMonster()
// {
// 	return _owner->toMonster();
// }

bool CGameRoleModule::init( CRole* role )
{
	_role = role;
	return true;
}

// bool CGameMonsterModule::init( CMonster* monster )
// {
// 	_monster = monster;
// 	return true;
// }