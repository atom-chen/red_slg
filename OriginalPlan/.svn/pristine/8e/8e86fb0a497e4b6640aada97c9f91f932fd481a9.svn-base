#ifndef _MAP_SERVER_UTIL_H_
#define _MAP_SERVER_UTIL_H_

#include "core/database_conn_mgr.h"
#include "core/socket_event_loop_wrap_mgr.h"

#include "map_server_base.h"

extern GXMISC::CDatabaseConnMgr *	g_MapDbMgr;
extern GXMISC::CNetModule *	g_MapNetMgr;
extern CMapServerBase*				g_MapServerBase;

#define DMapServerBase				g_MapServerBase
#define DMapNetMgr					g_MapNetMgr
#define DMapDbMgr					g_MapDbMgr

enum ESocketTag
{
	SOCKET_TAG_MWC,		// 世界服务器连接
	SOCKET_TAG_MCL,		// 客户端监听连接
	SOCKET_TAG_MGML,	// GM端监听
	SOCKET_TAG_MHL,		// HTTP监听

	// 以下服务器可相互连接
	SOCKET_TAG_MRCL,	// 日志服务器
	SOCKET_TAG_MMCL,	// 管理器服务器
	SOCKET_TAG_MRSCL,	// 资源服务器
};

#endif	// _MAP_SERVER_UTIL_H_