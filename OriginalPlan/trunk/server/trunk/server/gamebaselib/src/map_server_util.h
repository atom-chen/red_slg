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
	SOCKET_TAG_MWC,		// �������������
	SOCKET_TAG_MCL,		// �ͻ��˼�������
	SOCKET_TAG_MGML,	// GM�˼���
	SOCKET_TAG_MHL,		// HTTP����

	// ���·��������໥����
	SOCKET_TAG_MRCL,	// ��־������
	SOCKET_TAG_MMCL,	// ������������
	SOCKET_TAG_MRSCL,	// ��Դ������
};

#endif	// _MAP_SERVER_UTIL_H_