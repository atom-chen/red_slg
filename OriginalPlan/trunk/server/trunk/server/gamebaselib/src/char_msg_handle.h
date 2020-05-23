#ifndef _CHAR_MSG_HANDLE_H_
#define _CHAR_MSG_HANDLE_H_

#include "game_define.h"
#include "game_util.h"
#include "game_pos.h"

class CCharacterObject;
class CCharMsgHandle
{
	friend class CCharacterObject;
public:
	virtual void onResetPos(TObjUID_t objUID, TAxisPos_t x, TAxisPos_t y, EResetPosType type, bool broadFlag);
	virtual void onActionBanChange(EActionBan ban);
	virtual void onMoveUpdate(TPackMovePosList* posList, TObjUID_t objUID);

protected:
	CCharacterObject* _character;
};

#endif	// _CHAR_MSG_HANDLE_H_