#ifndef _PACKET_RX_RECORD_H_
#define _PACKET_RX_RECORD_H_

#include "base_packet_def.h"
#include "packet_def.h"
#include "packet_struct.h"
#include "packet_id_def.h"
#include "game_util.h"
#include "server_define.h"
#include "game_recorde_struct.h"

#pragma pack(push,1)

class CMRRecorde : public CServerPacket
{
public:
	CCharArray2<MAX_RECORDE_BUFF_SIZE>	recordeData;
// 	CMRRecorde() : CServerPacket(PACKET_MR_RECORDE)
// 	{
// 		DCleanPacketStruct(CServerPacket);
// 	}

public:
	DPACKET_BASE_DEF(CMRRecorde, PACKET_MR_RECORDE, CServerPacket);

	TPackLen_t getPackLen()
	{
		totalLen = (TPackLen_t)sizeof(CServerPacket)
		+ recordeData.sizeInBytes()
		;
		return totalLen;
	}
};

class CWRRecorde : public CServerPacket
{
public:
	CCharArray2<MAX_RECORDE_BUFF_SIZE>	recordeData;
// 	CWRRecorde() : CServerPacket(PACKET_WR_RECORDE)
// 	{
// 		DCleanPacketStruct(CServerPacket);
// 	}

public:
	DPACKET_BASE_DEF(CWRRecorde, PACKET_WR_RECORDE, CServerPacket);

	TPackLen_t getPackLen()
	{
		totalLen = (TPackLen_t)sizeof(CServerPacket)
			+ recordeData.sizeInBytes()
			;
		return totalLen;
	}
};

class CLRRecorde : public CServerPacket
{
public:
	CCharArray2<MAX_RECORDE_BUFF_SIZE>	recordeData;
// 	CLRRecorde() : CServerPacket(PACKET_WR_RECORDE)
// 	{
// 		DCleanPacketStruct(CServerPacket);
// 	}

public:
	DPACKET_BASE_DEF(CLRRecorde, PACKET_WR_RECORDE, CServerPacket);

	TPackLen_t getPackLen()
	{
		totalLen = (TPackLen_t)sizeof(CServerPacket)
			+ recordeData.sizeInBytes()
			;
		return totalLen;
	}
};

class CRRRecorde : public CServerPacket
{
public:
	CCharArray2<MAX_RECORDE_BUFF_SIZE>	recordeData;
// 	CRRRecorde() : CServerPacket(PACKET_RR_RECORDE)
// 	{
// 		DCleanPacketStruct(CServerPacket);
// 	}

public:
	DPACKET_BASE_DEF(CRRRecorde, PACKET_RR_RECORDE, CServerPacket);

	TPackLen_t getPackLen()
	{
		totalLen = (TPackLen_t)sizeof(CServerPacket)
			+ recordeData.sizeInBytes()
			;
		return totalLen;
	}
};

class CBRRecorde : public CServerPacket
{
public:
	CCharArray2<MAX_RECORDE_BUFF_SIZE>	recordeData;
// 	CBRRecorde() : CServerPacket(PACKET_BR_RECORDE)
// 	{
// 		DCleanPacketStruct(CServerPacket);
// 	}

public:
	DPACKET_BASE_DEF(CBRRecorde, PACKET_BR_RECORDE, CServerPacket);

	TPackLen_t getPackLen()
	{
		totalLen = (TPackLen_t)sizeof(CServerPacket)
			+ recordeData.sizeInBytes()
			;
		return totalLen;
	}
};

class CRWRequestServerInfo : public CRequestPacket
{
public:
	DReqPacketImpl(CRWRequestServerInfo, PACKET_RW_SERVER_INFO);
};

class CWRRequestServerInfoRet : public CResponsePacket
{
public:
	GXMISC::TIPString_t		serverIP;		// 世界服务器IP
	GXMISC::TPort_t			serverPort;		// 世界服务器端口
	GXMISC::TGameTime_t		startTime;		// 开服时间
	TPlatformID_t			platFormID;		// 平台ID
	TWorldServerID_t		serverID;		// 服务器ID
	TPlatformName_t			platFormName;	// 平台名字
	TAppendCDKeyString		md5KeyStr;		// 后缀的md5字符串


	DResPacketImpl(CWRRequestServerInfoRet, PACKET_WR_SERVER_INFO_RET);
};

#pragma pack(pop)

#endif	// _PACKET_RX_RECORD_H_