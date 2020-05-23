// @BEGNODOC
#ifndef _PACKET_CW_LOGIN_H_
#define _PACKET_CW_LOGIN_H_

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
// @ENDDOC


/** @defgroup PackLoginModule 登陆模块
* @{
*/
/** @defgroup PackVerifyConnect 角色服务器验证
* @{
*/
/// @ref PACKET_CW_VERIFY_CONNECT
class CWVerifyConnect : public CRequestPacket, public GXMISC::IStreamableStaticAll<CWVerifyConnect>
{
	// @member
public:
	uint64 loginKey;					///< 登陆密钥
	TCharArray2 prevMsg;				///< 内部私有数据

public:
	DPACKET_BASE_DEF(CWVerifyConnect, PACKET_CW_VERIFY_CONNECT, CRequestPacket);
	DPACKET_IMPL1(prevMsg);

//public:
//	DReqPacketImpl(CWVerifyConnect, PACKET_CW_VERIFY_CONNECT);
};
/// @ref PACKET_WC_VERIFY_CONNECT_RET
class WCVerifyConnectRet : public CResponsePacket
{
	// @member
public:
	TRoleUID_t roleUID;					///< 角色UID 0表示无角色

public:
	DResPacketImpl(WCVerifyConnectRet, PACKET_WC_VERIFY_CONNECT_RET);
};
/** @}*/
/** @defgroup PackRandRoleName 随机生成角色名字
* @{
*/
/// @ref PACKET_CW_RAND_ROLE_NAME
class CWRandGenName : public CRequestPacket
{
	// @member
public:
	uint8  sex;				///< 性别

public:
	DReqPacketImpl(CWRandGenName, PACKET_CW_RAND_ROLE_NAME);
};
/// @ref PACKET_WC_RAND_ROLE_NAME_RET
class WCRandGenNameRet : public CResponsePacket
{
	// @member
public:
	TRoleName_t name;		///< 名字

public:
	DResPacketImpl(WCRandGenNameRet, PACKET_WC_RAND_ROLE_NAME_RET);
};
/** @}*/
/** @defgroup PackCreateRole 创建角色
 * @{
 */
/// @ref PACKET_CW_CREATE_ROLE
class CWCreateRole : public CRequestPacket, public GXMISC::IStreamableStaticAll<CWCreateRole>
{
	// @member
public:
	uint8 rolePrototypeID;			///< 角色原型ID
	TRoleName_t roleName;			///< 角色名字

public:
	bool isValid()
	{
		roleName.refix();
		if(roleName.empty())
		{
			return false;
		}

		return true;
	}
public:
	DPACKET_BASE_DEF(CWCreateRole, PACKET_CW_CREATE_ROLE, CRequestPacket);
	DPACKET_IMPL1(roleName);
};
/// @ref PACKET_WC_CREATE_ROLE_RET
class WCCreateRoleRet : public CResponsePacket
{
	// @member
public:
	TRoleUID_t roleUID;				///< 角色UID

public:
	DResPacketImpl(WCCreateRoleRet, PACKET_WC_CREATE_ROLE_RET);
};
/** @}*/
/** @defgroup PackLgoinGame 请求登陆游戏
* @{
*/
/// @ref PACKET_CW_LOGIN_GAME
class CWLoginGame : public CRequestPacket
{
public:
	DReqPacketImpl(CWLoginGame, PACKET_CW_LOGIN_GAME);
};
/// @ref PACKET_WC_LOGIN_GAME_RET
class WCLoginGameRet : public CResponsePacket, public GXMISC::IStreamableStaticAll<WCLoginGameRet>
{
	// @member
public:
	TRoleUID_t roleUID;						///< 角色UID
	TCharArray2 serverIP;					///< 游戏服务器IP
	uint32 serverPort;						///< 游戏服务器端口

public:
	std::string toString()
	{
		return GXMISC::gxToString("CWLoginGame: RoleUID=%" I64_FMT "u,ServerIP=%s,Port=%u", roleUID, serverIP.toString().c_str(), serverPort);
	}

public:
	DPACKET_BASE_DEF(WCLoginGameRet, PACKET_WC_LOGIN_GAME_RET, CResponsePacket);
	DPACKET_IMPL1(serverIP);
};
/** @}*/
/** @defgroup PackLgoinQuit 请求退出登陆
* @{
*/
/// @ref PACKET_CW_LOGIN_QUIT
class CWLoginQuit : public CRequestPacket
{
	DReqPacketImpl(CWLoginQuit, PACKET_CW_LOGIN_QUIT);
};
/// @ref PACKET_WC_LOGIN_QUIT_RET
class WCLoginQuitRet : public CResponsePacket
{
	DResPacketImpl(WCLoginQuitRet, PACKET_WC_LOGIN_QUIT_RET);
};
/** @}*/

/** @}*/

// @BEGNODOC
#pragma pack(pop)

#endif	// _PACKET_CW_LOGIN_H_
// @ENDDOC