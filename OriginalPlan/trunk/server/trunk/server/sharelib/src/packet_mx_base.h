#ifndef _PACKET_MX_BASE_H_
#define _PACKET_MX_BASE_H_

#include "base_packet_def.h"
#include "packet_def.h"
#include "packet_struct.h"
#include "packet_id_def.h"
#include "game_util.h"
#include "server_define.h"

#pragma pack(push,1)

class XMServerRegiste : public CRequestPacket
{
public:
	TCharArray2 msg; ///< JSON格式 {id:xxx, type:xxx, recvtype={}, msg={xxx}} recvtype:表示是否接受其他类型服务器注册信息

public:
	DReqPacketImpl(XMServerRegiste, PACKET_XM_REGISTE);
};

class MXServerRegisteRet : public CResponsePacket
{
public:
	TCharArray2 msg; ///< JSON格式 {{id:xxx, type:xxx, recvtype={}, msg={xxx}}} recvtype:表示是否接受其他类型服务器注册信息

public:
	DResPacketImpl(MXServerRegisteRet, PACKET_MX_REGISTE_RET);
};

#pragma pack(pop)

#endif	// _PACKET_MX_BASE_H_