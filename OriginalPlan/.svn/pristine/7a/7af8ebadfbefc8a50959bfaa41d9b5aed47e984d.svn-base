#ifndef _WORLD_MAP_SERVER_HANDLER_H_
#define _WORLD_MAP_SERVER_HANDLER_H_

#include "world_map_server_handler_base.h"

class CWorldMapServerHandler : public CWorldMapServerHandlerBase
{
public:
	static void Setup();
	static void Unsetup();

protected:
	virtual void onMapServerRegiste(TServerID_t mapServer);

	// 其他小功能模块
protected:
	//兑换礼包
	GXMISC::EHandleRet handleExchangeGiftReq( const MWExchangeGiftReq* packet );
	//转发限制信息
	GXMISC::EHandleRet handleLimitInfoReq( const CMWLimitInfoReq* packet );
};

#endif	// _WORLD_MAP_SERVER_HANDLER_H_