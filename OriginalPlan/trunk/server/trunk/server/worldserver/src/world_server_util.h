#ifndef _WORLD_SERVER_UTIL_H_
#define _WORLD_SERVER_UTIL_H_

#include "database_conn_mgr.h"
#include "core/socket_event_loop_wrap_mgr.h"

class CWorldServer;

extern CWorldServer* g_WorldServer;
extern GXMISC::CDatabaseConnMgr* g_WorldDbMgr;
extern GXMISC::CNetModule* g_WorldNetMgr;

#define DWorldServer g_WorldServer
#define DWorldNetMgr g_WorldNetMgr
#define DWorldDbMgr g_WorldDbMgr

#endif
