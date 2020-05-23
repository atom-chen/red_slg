#ifndef _PACKET_WB_BASE_H_
#define _PACKET_WB_BASE_H_

#include "core/types_def.h"
#include "core/stream_impl.h"

#include "game_util.h"
#include "packet_id_def.h"
#include "base_packet_def.h"
#include "game_socket_packet_handler.h"
#include "streamable_util.h"

#pragma pack(push, 1)

// 注册
class CWBRegiste : public CRequestPacket
{
public:
	TServerID_t serverID;

public:
	DReqPacketImpl(CWBRegiste, PACKET_WB_REGISTE);
};

class CBWRegisteRet : public CResponsePacket
{
public:
	DResPacketImpl(CBWRegisteRet, PACKET_BW_REGISTE_RET);
};

// 充值
class BWRecharge : public CRequestPacket
{
public:
	TSerialStr_t serialNo;
	TAccountID_t accountID;
	TRmb_t rmb;

public:
	std::string toString()
	{
		return GXMISC::gxToString("SerialNo=%s,AccountID=%" I64_FMT "u,Rmb=%u", serialNo.c_str(), accountID, rmb);
	}
public:
	DReqPacketImpl(BWRecharge, PACKET_BW_RECHARGE);
};
class WBRechargeRet : public CResponsePacket
{
public:
	TSerialStr_t serialNo;			// 序列号
	TAccountID_t accountID;			// 账号ID
	TRmb_t rmb;						// 元宝
	TRmb_t bindRmb;					// 绑定元宝
	TRetCode_t retCode;				// 错误码
	sint8 onlineFlag;				// 是否在线充值

public:
	DResPacketImpl(WBRechargeRet, PACKET_WB_RECHARGE_RET);
};

#pragma pack(pop)

#endif	// _PACKET_WB_BASE_H_