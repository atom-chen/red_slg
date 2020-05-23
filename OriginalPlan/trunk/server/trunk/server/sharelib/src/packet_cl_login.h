#ifndef _PACKET_CL_LOGIN_H_
#define _PACKET_CL_LOGIN_H_

#include "core/string_common.h"
#include "core/types_def.h"
#include "core/stream_impl.h"

#include "base_packet_def.h"
#include "packet_id_def.h"
#include "game_util.h"
#include "packet_struct.h"
#include "game_struct.h"
#include "game_socket_packet_handler.h"

#pragma pack(push, 1)

/** @defgroup PackVerifyModule 账号验证模块
* @{
*/
/**
 * @defgroup PackZoneList 区服列表
 * @{
 */
class CLGetZoneList : public CRequestPacket
{
public:
	DReqPacketImpl(CLGetZoneList, PACKET_CL_ZONE_LIST_REQ);
};

class LCGetZoneListRet : public CResponsePacket, public GXMISC::IStreamableStaticAll<LCGetZoneListRet>
{
	// @member
public:
	CArray1< ZoneServer> zones;		///< 区服列表

public:
	DPACKET_BASE_DEF(LCGetZoneListRet, PACKET_LC_ZONE_LIST_RET, CResponsePacket);
	DPACKET_IMPL1(zones);
};
/** @}*/
/**
 * @defgroup PackHasRoleZoneList 已有角色区服列表
 * @{
 */
class CLGetHasRoleZoneList : public CRequestPacket, public GXMISC::IStreamableStaticAll<CLGetHasRoleZoneList>
{
	// @member
public:
	TAccountName_t account;					///< 账号

public:
	DPACKET_BASE_DEF(CLGetHasRoleZoneList, PACKET_CL_HAS_ROLE_ZONE_LIST, CRequestPacket);
	DPACKET_IMPL1(account);
};
class LCGetHasRoleZoneListRet : public CResponsePacket, public GXMISC::IStreamableStaticAll<LCGetHasRoleZoneListRet>
{
	// @member
public:
	CArray1<struct ZoneServer> zones;		///< 区服列表

public:
	DPACKET_BASE_DEF(LCGetHasRoleZoneListRet, PACKET_LC_HAS_ROLE_ZONE_LIST_RET, CResponsePacket);
	DPACKET_IMPL1(zones);
};
/** @}*/
/** @defgroup PackVerifyAccount 账号验证
* @{
*/
class CLVerifyAccount : public CRequestPacket, public GXMISC::IStreamableStaticAll<CLVerifyAccount>
{
	// @member
public:
	TWorldServerID_t serverID;				///< 区服ID
	TCharArray2 accountName;				///< 玩家账号名
	TCharArray2 platUID;					///< 平台用户UID
	TCharArray2 password;					///< 动态密码
	TCharArray2 extData;					///< 扩展数据

public:
	DPACKET_BASE_DEF(CLVerifyAccount, PACKET_CL_VERIFY_ACCOUNT, CRequestPacket);
	DPACKET_IMPL4(accountName, platUID, password, extData);

public:
	std::string toString()
	{
		return GXMISC::gxToString("CWVerifyAccount: AccountName=%s", accountName.toString().c_str());
	}
};
class LCVerifyAccountRet : public CResponsePacket, public GXMISC::IStreamableStaticAll<LCVerifyAccountRet>
{
	// @member
public:
	TLoginKey_t loginKey;					///< 登陆密钥
	TCharArray2 serverIP;					///< 角色服务器IP
	uint32 port;							///< 角色服务器端口
	TCharArray2 prvMsg;						///< 内部数据

public:
	DPACKET_BASE_DEF(LCVerifyAccountRet, PACKET_LC_VERIFY_ACCOUNT_RET, CResponsePacket);
	DPACKET_IMPL2(serverIP, prvMsg);
};
/** @}*/

/** @}*/

#pragma pack(pop)

#endif	// _PACKET_CL_LOGIN_H_