#include "game_config.h"
#include "packet_cw_login.h"

void CGameConfig::setBlockSize(uint32 val)
{
	blockSize = val;
}

void CGameConfig::setBroadcastRange(uint32 val)
{
	broadcastRange = val;
}

uint8 CGameConfig::getSameScreenRadius()
{
	return blockSize*broadcastRange;
}
