#include "msg_base.h"
#include "role.h"
#include "packet_cm_base.h"

CMsgBase::CMsgBase()
{
	_pRole = NULL;
}

CMsgBase::~CMsgBase()
{
	_pRole = NULL;
}

void CMsgBase::setRole( CRole* pRole )
{
	_pRole = pRole;
}

CRole* CMsgBase::getRole()
{
	return _pRole;
}

void CMsgBase::handleCallBack( EGameRetCode retcode, CRole* prole )
{
	MCCallBackRetCode packet;
	packet.setRetCode(retcode);
	prole->sendPacket(packet);
}
