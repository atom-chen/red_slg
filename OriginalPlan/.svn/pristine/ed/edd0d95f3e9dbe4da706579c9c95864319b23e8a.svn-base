#ifndef _PACKET_LW_BASE_H_
#define _PACKET_LW_BASE_H_

#include "core/string_common.h"
#include "core/types_def.h"
#include "core/stream_impl.h"

#include "base_packet_def.h"
#include "packet_id_def.h"
#include "game_util.h"
#include "packet_struct.h"
#include "game_struct.h"
#include "game_socket_packet_handler.h"
#include "server_struct.h"

#pragma pack(push, 1)

/// 世界服注册
class CWLRegiste : public CRequestPacket
{
public:
	TWorldServerID_t serverID;
	GXMISC::TIPString_t ip;
	GXMISC::TPort_t port;
	sint32 num;
	GXMISC::TIPString_t dbIP;
	GXMISC::TPort_t dbPort;
	CCharArray1<50> dbUser;
	CCharArray1<50> dbPasswd;

public:
	DReqPacketImpl(CWLRegiste, PACKET_WL_REGIST);
};
class CLWRegisteRet : public CResponsePacket
{
public:
	TLoginServerData serverData;

public:
	DResPacketImpl(CLWRegisteRet, PACKET_LW_REGIST_RET);
};

/// 角色登陆
class CWLRoleLogin : public CRequestPacket
{
public:
	TLoginKey_t loginKey;			///< 登陆Key
	TAccountID_t accountID;			///< 账号ID
	TRoleUID_t roleUID;				///< 角色UID
	TRoleName_t roleName;			///< 角色名字
	TWorldServerID_t worldServerID;	///< 服务器ID
	GXMISC::TIPString_t clientIP;	///< 客户端IP

public:
	DReqPacketImpl(CWLRoleLogin, PACKET_WL_ROLE_LOGIN);
};
class CLWRoleLoginRet : public CResponsePacket
{
public:
	TLoginKey_t loginKey;			///< 登陆Key
	TAccountID_t accountID;			///< 账号ID
	TRoleUID_t roleUID;				///< 角色UID

public:
	DResPacketImpl(CLWRoleLoginRet, PACKET_LW_ROLE_LOGIN_RET);
};
/// 角色创建
class CWLRoleCreate : public CRequestPacket
{
public:
	TLoginKey_t loginKey;			///< 登陆Key
	TAccountID_t accountID;			///< 账号ID
	TRoleUID_t roleUID;				///< 角色UID

public:
	DReqPacketImpl(CWLRoleCreate, PACKET_WL_ROLE_CREATE);
};
class CLWRoleCreateRet : public CResponsePacket
{
public:
	TLoginKey_t loginKey;			///< 登陆Key
	TAccountID_t accountID;			///< 账号ID
	TRoleUID_t roleUID;				///< 角色UID

public:
	DResPacketImpl(CLWRoleCreateRet, PACKET_LW_ROLE_LOGIN_RET);
};
/// 数据更新
class CWLDataUpdate : public CRequestPacket
{
public:
	sint32 roleNum;		///< 角色数目

public:
	DReqPacketImpl(CWLDataUpdate, PACKET_WL_DATA_UPDATE);
};
/// 限号信息
class CLWLimitInfoUpdate : public CServerPacket
{
	// @member
public:
	CArray1<TAccountID_t>	accountID;			///< 账号列表
	TLimitKeyStr_t			limitKey;			///< 限制字符串
	ERoleLimitType			limitType;			///< 限制类型
	uint8					limitVal;			///< 限制值
	GXMISC::TGameTime_t		limitTime;			///< 限制结束时间

public:
	DSvrPacketImpl(CLWLimitInfoUpdate, PACKET_LW_LIMIT_INFO_UPDATE);
};
/// 限号新信息
class CLWLimitAccountInfo : public CServerPacket
{
	// @member
public:
	TAccountID_t		limitAccountID;			///< 限制账号
	TRoleUID_t			limitRoleID;			///< 限制角色
	GXMISC::CGameTime	begintime;				///< 开始时间
	GXMISC::CGameTime	endtime;				///< 结束时间
public:
	DSvrPacketImpl(CLWLimitAccountInfo, PACKET_LW_LIMIT_ACCOUNT_INFO);
};
/// 禁言新信息
class CLWLimitChatInfo : public CServerPacket
{
	// @member
public:
	TAccountID_t		limitAccountID;			///< 限制账号
	TRoleUID_t			limitRoleID;			///< 限制角色
	GXMISC::CGameTime	begintime;				///< 开始时间
	GXMISC::CGameTime	endtime;				///< 结束时间
	TServerOperatorId_t uniqueId;               ///< 唯一id
public:
	DSvrPacketImpl(CLWLimitChatInfo, PACKET_LW_LIMIT_CHAT_INFO);
};
/// 充值
class WLChargeRmb : public CServerPacket
{
public:
	TCharArray2 billID;		///< 充值账单ID

};
/// 限信息请求
class CWLLimitInfoReq : public CServerPacket
{
	// @member
public:
	TAccountID_t		limitAccountID;			///< 限制账号
	TRoleUID_t			limitRoleID;			///< 限制角色
	TWorldServerID_t    serverID;               ///< 服务器id
	
public:
	DSvrPacketImpl(CWLLimitInfoReq, PACKET_WL_LIMIT_INFO_REQ);
};

#pragma pack(pop)

#endif	// _PACKET_LW_BASE_H_