#ifndef _MAP_WORLD_HANDLER_H_
#define _MAP_WORLD_HANDLER_H_

#include "map_world_handler_base.h"
#include "packet_mw_base.h"
#include "packet_lw_base.h"

class CMapWorldServerHandler : public CMapWorldServerHandlerBase
{
public:
	typedef CMapWorldServerHandlerBase TBaseType;

public:
	CMapWorldServerHandler(){}
	~CMapWorldServerHandler(){}

public:
	static void Setup();
	static void Unsetup();

public:
	void    sendUnloadDataRet(EUnloadRoleType retType, TAccountID_t accountID, TRoleUID_t roleUID, GXMISC::TSocketIndex_t worldSockIndex);
	void	sendRoleQuit(TAccountID_t accountID, TObjUID_t objUID, TRoleUID_t roleUID, GXMISC::TSocketIndex_t worldSockIndex);

public:
	// 其他服务器广播
	ETransCode doBroadCast(CBasePacket* packet, TObjUID_t srcObjUID);
	// 转发
	ETransCode doTrans(CBasePacket* packet, TObjUID_t srcObjUID, TObjUID_t destObjUID);

	// 登陆
public:
	GXMISC::EHandleRet handleLoadRoleData(WMLoadRoleData* packet);
	GXMISC::EHandleRet handleUnloadRoleData(WMUnloadRoleData* packet);
	GXMISC::EHandleRet handleLimitInfo( CLWLimitInfoUpdate* packet );
	GXMISC::EHandleRet handleUpdateUserata( WMUpdateUserData* packet );

	// 充值
public:
	GXMISC::EHandleRet handleRecharge(WMRecharge* packet);

	// 其他模块
public:
	// 处理兑换礼包返回
//	GXMISC::EHandleRet handleExchangeGiftRet( WMExchangeGiftRet* packet );
	// 处理封号信息
	GXMISC::EHandleRet handleLimitAccountInfo( CWMLimitAccountInfo* packet );
	// 处理禁言信息
	GXMISC::EHandleRet handleLimitChatInfo( CWMLimitChatInfo* packet );
};

#define DMapWorldPlayer ((CMapWorldServerHandler*)(CMapWorldServerHandlerBase::WorldServerHandler))

#endif	// _MAP_WORLD_HANDLER_H_