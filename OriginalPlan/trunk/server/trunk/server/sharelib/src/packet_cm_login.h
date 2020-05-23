// @BEGNODOC
#ifndef _PACKET_CM_LOGIN_H_
#define _PACKET_CM_LOGIN_H_

#include "core/types_def.h"

#include "game_util.h"
#include "packet_id_def.h"
#include "game_struct.h"
#include "streamable_util.h"
#include "object_struct.h"
#include "user_struct.h"
#include "game_server_socket_packet_handler.h"
#include "protocolStruct.h"

#pragma pack(push,1)

// @ENDDOC
/** @addtogroup PackLoginModule 登陆模块
* @{
*/

/** @defgroup PackLoginGame 登陆游戏
* @{
*/
class CMLoginServer : public CRequestPacket, public GXMISC::IStreamableStaticAll<CMLoginServer>
{
	// @member
public:
	sint32 platformId;
	TCharArray2 keyId;
	TCharArray2 accountPass;
	sint8 isGuest;
	sint8 OS;

public:
	DPACKET_BASE_DEF(CMLoginServer, PACKET_CM_LOGIN_SERVER, CRequestPacket);
	DPACKET_IMPL2(keyId, accountPass);
};
// class MCLoginServerRet : public CResponsePacket
// {
// 	// @member
// public:
// 	sint16 result;
// };

class CMLocalLoginGame : public CRequestPacket
{
	// @member
public:
	TRoleUID_t roleUID;				///< 角色UID

public:
	DReqPacketImpl(CMLocalLoginGame, PACKET_CM_LOCAL_LOGIN);
};
class MCLocalLoginGameRet : public CResponsePacket
{
	// @member
public:
	TRoleUID_t  roleUID;			///< 角色UID

public:
	DResPacketImpl(MCLocalLoginGameRet, PACKET_MC_LOCAL_LOGIN_RET);
};
class CMLocalLoginGameAccount : public CRequestPacket, public GXMISC::IStreamableStaticAll<CMLocalLoginGameAccount>
{
	// @member
public:
	uint8 accountFlag;
	TAccountName_t  accountName;		///< 账号名
	uint8 passwordFlag;	
	TCharArray2 password;
	uint8 sPhoneModelFlag;
	TCharArray2 sPhoneModel;
	uint8 sChannelFlag;
	TCharArray2 sChannel;
	uint8 sChildChannelFlag;
	TCharArray2 sChildChannel;
	uint32 iUserType;

public:
	DPACKET_BASE_DEF(CMLocalLoginGameAccount, PACKET_CM_LOCAL_LOGIN_ACCOUNT, CRequestPacket);
	DPACKET_IMPL5(accountName, password, sPhoneModel, sChannel, sChildChannel);
};
class MCLocalLoginGameAccountRet : public CResponsePacket
{
	// @member
public:
	uint8 playerDataFlag;
	PlayerInfoBeanReader playerData;
	TCharArray2 realName;
	TCharArray2 address;
	uint8 passtokenFlag;
	TCharArray2 passtoken;
	uint32 serverTime;
	uint8 loginAwardGot;
	uint32 loginAwardTime;
	uint32 selfIconAwardTime;
	uint8 dayFirstLogin;
	uint8 selfIconAwardGot;
	uint8 catAwardGot;
	uint32 catAwardValue;
	uint32 reachTargetGolds;
	uint32 reachTargetAwards;
	uint8 hasCharged;
	uint32 restGetFreeGoldsTime;
	uint8 dayLuckyItem;
	TCharArray2 dayLuckyAnim;
	CArray1<CannonBeanReader> cannons;
	uint32 catVipAddition;
	uint32 recommendShopId;
	uint8 enterRoom;
	sint32 friendActionMsgNum;
	sint32 chatHistoryNum;
	uint8 mailsFlag;
	CArray2<MailBeanReader> mails;
	uint8 startedActivitysFlag;
	CArray2<sint32> startedActivitys;
	uint8 sortActivityIdsFlag;
	CArray2<sint32> sortActivityIds;
	CArray1<uint8> loginAdds;
	CArray1<uint8> catAdds;
	CArray1<uint8> onlineAdds;
	CArray1<uint8> shopAdds;
	CArray1<uint8> tradeAdds;
	CArray1<uint8> charmAdds;

public:
	void initData()
	{
		playerDataFlag = 1;
		passtokenFlag = 1;
		mailsFlag = 1;
		startedActivitysFlag = 1;
		sortActivityIdsFlag = 1;
	}

public:
	DResPacketImpl(MCLocalLoginGameAccountRet, PACKET_MC_LOCAL_LOGIN_ACCOUNT_RET);
};
/*
class CMGameRegister : public CRequestPacket, public GXMISC::IStreamableStaticAll<CMGameRegister>
{
	// @member
public:
	TAccountName_t accountName;			///< 账号名
	TAccountPassword_t password;		///< 密码

public:
	DPACKET_BASE_DEF(CMGameRegister, PACKET_CM_REGISTER, CRequestPacket);
	DPACKET_IMPL2(accountName, password);
};
class MCGameRegisterRet : public CResponsePacket, public GXMISC::IStreamableStaticAll<MCGameRegisterRet>
{
	// @member
public:
	TAccountName_t  accountName;		///< 账号名

public:
	DPACKET_BASE_DEF(MCGameRegisterRet, PACKET_MC_REGISTER_RET, CResponsePacket);
	DPACKET_IMPL1(accountName);
};
*/
/** @}*/

/** @defgroup PackEnterGame 请求进入游戏
* @{
*/
class CMEnterGame : public CRequestPacket
{
	// @member
public:
	TRoleUID_t  roleUID;			///< 角色UID

public:
	DReqPacketImpl(CMEnterGame, PACKET_CM_ENTER_GAME);
};
class MCEnterGameRet : public CResponsePacket, public GXMISC::IStreamableStaticAll<MCEnterGameRet>
{
	// @member
public:
	struct RoleDetail detailData;					///< 玩家详细数据

public:
	DPACKET_BASE_DEF(MCEnterGameRet, PACKET_MC_ENTER_GAME_RET, CResponsePacket);
	DPACKET_IMPL1(detailData);
};
/** @}*/

/** @defgroup PackPlayerHeart 玩家心跳
* @{
*/
class MCPlayerHeart : public CResponsePacket
{
public:
	DResPacketImpl(MCPlayerHeart, PACKET_MC_PLAYER_HEART);
};
class CMPlayerHeartRet : public CRequestPacket
{
public:
	DReqPacketImpl(CMPlayerHeartRet, PACKET_CM_PLAYER_HEART_RET);
};
/** @}*/

/** @}*/					// 登陆模块
// @BEGNODOC
#pragma pack(pop)

#endif	// _PACKET_CM_LOGIN_H_
// @ENDDOC
