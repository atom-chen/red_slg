#ifndef _PACKET_MW_BASE_H_
#define _PACKET_MW_BASE_H_

#include "core/string_common.h"

#include "game_struct.h"
#include "game_util.h"
#include "base_packet_def.h"
#include "packet_id_def.h"
#include "user_struct.h"
#include "streamable_util.h"
#include "game_socket_packet_handler.h"
#include "server_struct.h"

#pragma pack(push, 1)

// 地图服务器向世界服务器注册
class MWRegiste : public CRequestPacket
{
public:
	TMapServerUpdate serverData;
	EServerType serverType;
	GXMISC::TIPString_t clientListenIP;
	GXMISC::TPort_t clientListenPort;

	std::string toString()
	{
		return GXMISC::gxToString("MapServerID=%u, ClientListenIP=%s, ClientListenPort=%u", 
			serverData.serverID, clientListenIP.toString().c_str(), clientListenPort);
	}

public:
	DReqPacketImpl(MWRegiste, PACKET_MW_REGISTE);
};
class WMRegisteRet : public CResponsePacket
{
public:
	TWorldServerID_t worldServerID;

	DResPacketImpl(WMRegisteRet, PACKET_WM_REGISTE_RET);
};

// 广播消息
typedef GXMISC::CArray<char, MAX_TRANS_SIZE> TRransPackAry;
class MWBroadPacket : public CRequestPacket
{
public:
	bool sendToMe;					// 是否发给自身
	TObjUID_t srcObjUID;			// 发起人ObjUID
	TRransPackAry msg;				// 转发的消息

public:
// 	MWBroadPacket() : CRequestPacket(PACKET_MW_BROAD)
// 	{
// 		DCleanPacketStruct(CRequestPacket);
// 	}

	DPACKET_BASE_DEF(MWBroadPacket, PACKET_MW_BROAD, CRequestPacket);

	TPackLen_t getPackLen()
	{
		totalLen = (TPackLen_t)(sizeof(CRequestPacket)
			+ sizeof(sendToMe)
			+ sizeof(srcObjUID)
			+ msg.sizeInBytes());
		flag = totalLen & 0xff;
		return totalLen;
	}
};

// 通过World转发消息到其他MapServer
class MWTransPacket : public CRequestPacket
{
public:
	TObjUID_t srcObjUID;			// 发起人ObjUID
	TObjUID_t destObjUID;			// 接收人ObjUID
	bool	  failedNeedRes;		// 转发失败是否需要返回给发送人
	TRransPackAry msg;				// 转发的消息

public:
// 	MWTransPacket() : CRequestPacket(PACKET_MW_TRANS)
// 	{
// 		DCleanPacketStruct(CRequestPacket);
// 	}

	DPACKET_BASE_DEF(MWTransPacket, PACKET_MW_TRANS, CRequestPacket);

	TPackLen_t getPackLen()
	{
		totalLen = (TPackLen_t)(sizeof(CRequestPacket)
			+ sizeof(srcObjUID)
			+ sizeof(destObjUID)
			+ sizeof(failedNeedRes)
			+ msg.sizeInBytes());
		flag = totalLen & 0xff;
		return totalLen;
	}
};

// 转发消息到世界服务器
class MWTrans2WorldPacket : public CRequestPacket
{
public:
	TObjUID_t destObjUID;			// 接收人ObjUID
	TRransPackAry msg;				// 转发的消息

public:
// 	MWTrans2WorldPacket() : CRequestPacket(PACKET_MW_TRANS_TO_WORLD)
// 	{
// 		DCleanPacketStruct(CRequestPacket);
// 	}

	DPACKET_BASE_DEF(MWTrans2WorldPacket, PACKET_MW_TRANS_TO_WORLD, CRequestPacket);

	TPackLen_t getPackLen()
	{
		totalLen = (TPackLen_t)(sizeof(CRequestPacket)
			+ sizeof(destObjUID)
			+ msg.sizeInBytes());
		flag = totalLen & 0xff;
		return totalLen;
	}
};

// 转发消息出错
class WMTransPacketError : public CResponsePacket
{
public:
	TObjUID_t srcObjUID;			// 发起人ObjUID
	TObjUID_t destObjUID;			// 接收人ObjUID
	TRransPackAry msg;				// 转发的消息

// 	WMTransPacketError() : CResponsePacket(PACKET_WM_TRANS_ERROR)
// 	{
// 		DCleanPacketStruct(CResponsePacket);
// 	}

	DPACKET_BASE_DEF(WMTransPacketError, PACKET_WM_TRANS_ERROR, CResponsePacket);

	TPackLen_t getPackLen()
	{
		totalLen = (TPackLen_t)(sizeof(CResponsePacket)
			+ sizeof(srcObjUID)
			+ sizeof(destObjUID)
			+ msg.sizeInBytes());
		flag = totalLen & 0xff;
		return totalLen;
	}

	TPackLen_t serialLen()
	{
		return getPackLen();
	}
};

// 更新其他地图服务器信息
class WMUpdateServer : public CServerPacket, public GXMISC::IStreamableStaticAll<WMUpdateServer>
{
public:
	TMapServerAry servers;
public:
	DPACKET_BASE_DEF(WMUpdateServer, PACKET_WM_UPDATE_SERVER, CServerPacket);
	DPACKET_IMPL1(servers);
};
class MWUpdateServer : public CServerPacket
{
public:
	TMapServerUpdate server;
public:
	DSvrPacketImpl(MWUpdateServer, PACKET_MW_UPDATE_SERVER);
};

// 开启场景
class MWOpenScene : public CServerPacket
{
public:
	TSceneData sceneData;

	DSvrPacketImpl(MWOpenScene, PACKET_MW_OPEN_SCENE);
	DFastPacketToString2(MWOpenScene, sceneData.sceneID, sceneData.mapServerID);
};
// 关闭场景
class MWCloseScene : public CServerPacket
{
public:
	TSceneID_t sceneID;
	TServerID_t mapServerID;

public:
	DSvrPacketImpl(MWCloseScene, PACKET_MW_CLOSE_SCENE);
	DFastPacketToString2(MWCloseScene, sceneID, mapServerID);
};
/// 通知角色进入场景
class MMChangeScene : public CServerPacket
{
public:
	TRoleUID_t roleUID;					///< 发出请求的角色UID
	TSceneID_t sceneID;					///< 场景UID
	TAxisPos pos;						///< 进入位置
	TServerID_t serverID;				///< 服务器ID
public:
	DSvrPacketImpl(MMChangeScene, PACKET_MM_CHANGE_SCENE);
};
// 换线请求
class MWChangeLine : public CRequestPacket
{
public:
	TObjUID_t objUID;
	TSceneID_t sceneID;
	TAxisPos pos;
	TServerID_t mapServerID;
	TSceneID_t lastSceneID;
	TAxisPos lastPos;
	TServerID_t lastMapServerID;
	TChangeLineTempData changeLineTempData;     // 切线的临时数据

public:
	DReqPacketImpl(MWChangeLine, PACKET_MW_CHANGE_LINE);
};
// 切线
class WMChangeLine : public CServerPacket
{
public:
	TObjUID_t		objUID;
	TMapID_t		mapID;
	TSceneID_t		sceneID;
	TServerID_t	mapServerID;
	TAxisPos		pos;

	DSvrPacketImpl(WMChangeLine, PACKET_WM_CHANGE_LINE);
	DFastPacketToString4(WMChangeLine, objUID, mapID, sceneID, mapServerID);
};
class WMChangeLineRet : public CResponsePacket
{
public:
	TObjUID_t objUID;
	TMapID_t mapID;
	GXMISC::TIPString_t clientListenIP;
	GXMISC::TPort_t clientListenPort;

	DResPacketImpl(WMChangeLineRet, PACKET_WM_CHANGE_LINE_RET);
	DPacketToString2Alias(WMChangeLineRet, TObjUID_t, ObjUID, objUID, TMapID_t, MapID, mapID);
};
// 
// // 请求开启动态地图
// class MWOpenDynamicMap : public CRequestPacket
// {
// public:
// 	TObjUID_t objUID;           // 对象UID
// 	TMapID_t mapID;             // 地图ID
// 	ESceneType sceneType;       // 场景类型
// 
// 	DReqPacketImpl(MWOpenDynamicMap, PACKET_MW_OPEN_DYNAMIC_MAP);
// 	DFastPacketToString2(MWOpenDynamicMap, objUID, mapID);
// };
// class WMOpenDynamicMapRet : public CResponsePacket
// {
// public:
// 	TObjUID_t		objUID;         // 对象UID
// 	TMapID_t		mapID;          // 地图ID
// 	ESceneType      sceneType;      // 场景类型
// 	TSceneID_t		sceneID;        // 场景ID
// 	TMapServerID_t	mapServerID;    // 服务器ID
// 
// 	DResPacketImpl(WMOpenDynamicMapRet, PACKET_WM_OPEN_DYNAMIC_MAP_RET);
// 	DFastPacketToString3(WMOpenDynamicMapRet, objUID, sceneID, mapServerID);
// };
// class WMOpenDynamicMap : public CRequestPacket
// {
// public:
// 	TObjUID_t objUID;           // 对象UID
// 	TMapID_t mapID;             // 地图ID
// 	ESceneType sceneType;       // 场景类型
// 
// 	DReqPacketImpl(WMOpenDynamicMap, PACKET_WM_OPEN_DYNAMIC_MAP);
// 	DFastPacketToString2(WMOpenDynamicMap, objUID, mapID);
// };
// class MWOpenDynamicMapRet : public CResponsePacket
// {
// public:
// 	TMapID_t	mapID;          // 地图ID
// 	ESceneType sceneType;       // 场景类型
// 	TObjUID_t	objUID;         // 对象UID
// 	TSceneData	sceneData;      // 场景数据
// 
// public:
// 	DResPacketImpl(MWOpenDynamicMapRet, PACKET_MW_OPEN_DYNAMIC_MAP_RET);
// 	DFastPacketToString3(MWOpenDynamicMapRet, objUID, sceneData.mapServerID, sceneData.sceneID);
// };
// // 关闭动态场景
// class WMCloseDynamicMap : public CServerPacket
// {
// public:
// 	TSceneID_t sceneID;
// 
// 	DSvrPacketImpl(WMCloseDynamicMap, PACKET_WM_CLOSE_SCENE);
// 	DFastPacketToString(MWOpenDynamicMapRet, sceneID);
// };
// 
// // 通知场景有所有者了
// class MWSceneOwner : public CServerPacket
// {
// public:
// 	TSceneID_t	sceneID;
// 	TObjUID_t	objUID;
// 	DSvrPacketImpl(MWSceneOwner, PACKET_MW_SCENE_OWNER);
// 	DFastPacketToString(MWSceneOwner, sceneID);
// };
// 加载角色数据
class WMLoadRoleData : public CRequestPacket
{
public:
	TLoadRoleData loadData;
	GXMISC::TSocketIndex_t socketIndex;
	TChangeLineTempData changeLineTempData;

	DFastPacketToString8(WMLoadRoleData,loadData.roleUID,loadData.accountID,loadData.objUID,loadData.loadType,loadData.sceneID,loadData.pos.x,loadData.pos.y,socketIndex);
	DReqPacketImpl(WMLoadRoleData, PACKET_WM_LOAD_ROLE_DATA);
};
class MWLoadRoleDataRet : public CResponsePacket
{
public:
	TLoadRoleData loadData;
	CWorldUserData userData;
	GXMISC::TSocketIndex_t socketIndex;

	DFastPacketToString6(MWLoadRoleDataRet, loadData.roleUID, loadData.accountID, loadData.objUID, loadData.loadType, loadData.sceneID,socketIndex);
	DResPacketImpl(MWLoadRoleDataRet, PACKET_MW_LOAD_ROLE_DATA_RET);
};
// 释放角色数据
class WMUnloadRoleData : public CRequestPacket
{
public:
	bool needRet;					// 是否需要返回消息
	EUnloadRoleType unloadType;		// 释放角色数据类型
	GXMISC::TSocketIndex_t socketIndex;     // Socket唯一标识
	DPacketToString3Def(WMUnloadRoleData, TRoleUID_t, roleUID, TAccountID_t, accountID, TObjUID_t, objUID);
	DReqPacketImpl(WMUnloadRoleData, PACKET_WM_UNLOAD_ROLE_DATA);
};
class MWUnloadRoleDataRet : public CResponsePacket
{
public:
	EUnloadRoleType unloadType;		// 释放角色数据类型
	GXMISC::TSocketIndex_t socketIndex;     // Socket唯一标识

	DPacketToString2Def(MWUnloadRoleDataRet, TRoleUID_t, roleUID, TAccountID_t, accountID);
	DResPacketImpl(MWUnloadRoleDataRet, PACKET_MW_UNLOAD_ROLE_DATA_RET);
};

// 角色退出游戏
class MWRoleQuit : public CRequestPacket
{
	DPacketToString4Def(MWRoleQuit, TRoleUID_t, roleUID, TObjUID_t, objUID, TAccountID_t, accountID, GXMISC::TSocketIndex_t, socketIndex);
	DReqPacketImpl(MWRoleQuit, PACKET_MW_ROLE_QUIT);
};
// 角色登陆
class MWUserLogin : public CServerPacket
{
public:
	bool firstLogin;            // 第一次登陆
	TObjUID_t objUID;           // 对象UID
	DSvrPacketImpl(MWUserLogin, PACKET_MW_USER_LOGIN);
};
// 角色心跳
class MWRoleHeart : public CRequestPacket
{
public:
	/*
	TRoleUID_t roleUID;         // 角色UID
	TAccountID_t accountID;     // 账号UID
	*/
	GXMISC::CArray<TRoleHeart, 3000> roles;

//public:
// 	MWRoleHeart() : CRequestPacket(PACKET_MW_ROLE_HEART)
// 	{
// 		DCleanPacketStruct(CRequestPacket);
// 	}

public:
	DPACKET_BASE_DEF(MWRoleHeart, PACKET_MW_ROLE_HEART, CRequestPacket);

	TPackLen_t getPackLen()
	{
		totalLen = (TPackLen_t)(sizeof(CRequestPacket)
			+ roles.sizeInBytes());
		return totalLen;
	}
};
/// 心跳返回
class WMRoleHeartRet : public CResponsePacket, public GXMISC::IStreamableStaticAll<WMRoleHeartRet>
{
public:
	GXMISC::CArray<TRoleHeart, 3000> roles;

public:
	DPACKET_BASE_DEF(WMRoleHeartRet, PACKET_WM_ROLE_HEART_RET, CResponsePacket);
	DPACKET_IMPL1(roles);
};
// 角色被踢掉
class MWRoleKick : public CServerPacket
{
public:
	TRoleUID_t roleUID;         // 角色UID
	TAccountID_t accountID;     // 账号ID
	GXMISC::TSocketIndex_t socketIndex; // socket唯一索引

	DSvrPacketImpl(MWRoleKick, PACKET_MW_ROLE_KICK);
};

// 服务器之间同步role和user数据
class WMUpdateUserData : public CServerPacket
{
public:
	TObjUID_t objUID;
	TW2MUserDataUpdate userData;

	DSvrPacketImpl(WMUpdateUserData, PACKET_WM_USER_UPDATE);
};
class MWUpdateRoleData : public CServerPacket
{
public:
	TObjUID_t objUID;
	TM2WRoleDataUpdate roleData;

	DSvrPacketImpl(MWUpdateRoleData, PACKET_MW_ROLE_UPDATE);
};

// 随机名字
class MWRandRoleName : public CRequestPacket
{
public:
	TRoleUID_t roleUID;
	TSex_t sex;

public:
	DReqPacketImpl(MWRandRoleName, PACKET_MW_RAND_ROLE_NAME);
};
class WMRandRoleNameRet : public CResponsePacket
{
public:
	TRoleUID_t roleUID;				///< 角色UID
	TCharArray2 roleName;			///< 角色名字

public:
	DResPacketImpl(WMRandRoleNameRet, PACKET_WM_RAND_ROLE_NAME_RET);
};
// 重命名角色名字
class MWRenameRoleName : public CRequestPacket
{
public:
	TRoleUID_t roleUID;
	TCharArray2 roleName;

public:
	DReqPacketImpl(MWRenameRoleName, PACKET_MW_RENAME_ROLE_NAME);
};
class WMRenameRoleNameRet : public CResponsePacket
{
public:
	TRoleUID_t roleUID;
	TCharArray2 roleName;

public:
	DResPacketImpl(WMRenameRoleNameRet, PACKET_WM_RENAME_ROLE_NAME_RET);
};
// 得到名字随机列表
class MWGetRandNameList : public CRequestPacket
{
public:
	DReqPacketImpl(MWGetRandNameList, PACKET_MW_GET_RAND_NAME_LIST);
};
class WMGetRandNameListRet : public CResponsePacket
{
public:
	CArray1<TRoleName_t> roleNameList;

public:
	DResPacketImpl(WMGetRandNameListRet, PACKET_WM_GET_RAND_NAME_LIST_RET);
};
// 充值
class WMRecharge : public CRequestPacket
{
public:
	TSerialStr_t serialNo;
	TRoleUID_t roleUID;
	TAccountID_t accountID;
	TRmb_t rmb;
	TRmb_t bindRmb;

	DReqPacketImpl(WMRecharge, PACKET_WM_RECHARGE);
};
class MWRechargeRet : public CResponsePacket
{
public:
	TSerialStr_t serialNo;				// 充值序号
	TRoleUID_t roleUID;					// 玩家UID
	TAccountID_t accountID;				// 账号UID
	bool isFirstCharge;					// 是否第一次充值
	TRmb_t rmb;							// 充值rmb
	TRmb_t bindRmb;						// 绑定rmb
public:
	DResPacketImpl(MWRechargeRet, PACKET_MW_RECHARGE_RET);
};
// 区服信息
class WMServerInfo : public CServerPacket
{
public:
	GXMISC::CGameTime openTime;				// 开服时间
	GXMISC::CGameTime firstStartTime;		// 第一次启动时间

	DSvrPacketImpl(WMServerInfo, PACKET_WM_SERVER_INFO);
};
// 奖励元宝
class WMAwardBindRmb : public CServerPacket
{
public:
	TRmb_t bindRmb;		///< 绑定元宝
	TGold_t gameMoney;	///< 金钱
	TRoleUID_t roleUID;	///< 玩家UID
public:
	DSvrPacketImpl(WMAwardBindRmb, PACKET_WM_AWARD_BIND_RMB);
};
// 发送公告
class MWAnnoucement : public CServerPacket, public GXMISC::IStreamableStaticAll<MWAnnoucement>
{
public:
	sint32 lastTime;
	sint32 interval;
	CCharArray2<1000> msg;

public:
	DPACKET_BASE_DEF(MWAnnoucement, PACKET_MW_ANNOUNCEMENT, CServerPacket);
	DPACKET_IMPL1(msg);
};

/// 限号新信息
class CWMLimitAccountInfo : public CServerPacket
{
	// @member
public:
	TAccountID_t		limitAccountID;			///< 限制账号
	TRoleUID_t			limitRoleID;			///< 限制角色
	GXMISC::CGameTime	begintime;				///< 开始时间
	GXMISC::CGameTime	endtime;				///< 结束时间
public:
	DSvrPacketImpl(CWMLimitAccountInfo, PACKET_WM_LIMIT_ACCOUNT_INFO);
};
/// 禁言新信息
class CWMLimitChatInfo : public CServerPacket
{
	// @member
public:
	TAccountID_t		limitAccountID;			///< 限制账号
	TRoleUID_t			limitRoleID;			///< 限制角色
	GXMISC::CGameTime	begintime;				///< 开始时间
	GXMISC::CGameTime	endtime;				///< 结束时间
	TServerOperatorId_t uniqueId;               ///< 唯一标示符
public:
	DSvrPacketImpl(CWMLimitChatInfo, PACKET_WM_LIMIT_CHAT_INFO);
};
/// 限制请求
class CMWLimitInfoReq : public CServerPacket
{
	// @member
public:
	TAccountID_t		limitAccountID;			///< 限制账号
	TRoleUID_t			limitRoleID;			///< 限制角色	
public:
	DSvrPacketImpl(CMWLimitInfoReq, PACKET_MW_LIMIT_INFO_REQ);
};
/// 兑换礼包
class MWExchangeGiftReq : public CRequestPacket
{
public:
	TRoleUID_t      roleUID;		///< 角色uid		
	TObjUID_t       objUid;			///< 对象uid
	TExchangeGiftID_t     id;             ///< 兑换码
public:
	DReqPacketImpl(MWExchangeGiftReq, PACKET_MW_EXCHANGE_GIFT_REQ);
};
class WMExchangeGiftRet : public CResponsePacket
{
public:
	TRoleUID_t      roleUID;		///< 角色uid		
	TObjUID_t       objUid;			///< 对象uid
	TExchangeItemID_t itemId;       ///< 兑换码兑换的物品id 
public:
	DResPacketImpl(WMExchangeGiftRet, PACKET_WM_EXCHANGE_GIFT_RET);
};
#pragma pack(pop)

#endif	// _PACKET_MW_BASE_H_