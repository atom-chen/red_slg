#include "char_msg_handle.h"
#include "obj_character.h"
#include "role_base.h"
#include "map_scene_base.h"
#include "game_config.h"
#include "packet_cm_base.h"

void CCharMsgHandle::onResetPos(TObjUID_t objUID, TAxisPos_t x, TAxisPos_t y, EResetPosType type, bool broadFlag)
{
	MCResetPos setPos;
	setPos.objUID = objUID;
	setPos.x = x;
	setPos.y = y;
	setPos.type = (uint8)type;
	if (broadFlag)
	{
		_character->getScene()->broadCast(setPos, _character, true, g_GameConfig.broadcastRange);
	}
	else if (_character->isRole())
	{
		_character->toRoleBase()->sendPacket(setPos);
	}
	else
	{
		gxAssert(false);
	}
}

void CCharMsgHandle::onActionBanChange(EActionBan ban)
{
	// 		MCObjActionBan objState;
	// 		objState.objUID = getObjUID();
	// 		objState.state = getActionBan();
	// 
	// 		if(actionBan == ACTION_BAN_LIVE)
	// 		{
	// 			getScene()->broadCast(objState, this, true);
	// 		}
	// 		else if(isRole())
	// 		{
	// 			CRole* pRole = getRoleOwner();
	// 			if(NULL != pRole)
	// 			{
	// 				pRole->sendPacket(objState);
	// 			}
	// 		}
}

void CCharMsgHandle::onMoveUpdate(TPackMovePosList* posList, TObjUID_t objUID)
{
	MCMoveBroad moveBroad;
	moveBroad.posList = *posList;
	moveBroad.objUID = objUID;
	_character->getScene()->broadCast(moveBroad, _character, true, g_GameConfig.broadcastRange);
}