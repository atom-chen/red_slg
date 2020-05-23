// @BEGNODOC
#ifndef _PACKET_CM_BASE_H_
#define _PACKET_CM_BASE_H_

#include "packet_include_header.h"

#include "game_pos.h"
#include "object_struct.h"

#pragma pack(push, 1)
// @ENDDOC
/** @defgroup PackBaseModule 基础模块
* @{
*/

/** @defgroup PackViewManage 视野进入离开
* @{
*/
class MCEnterView : public CServerPacket, public GXMISC::IStreamableStaticAll<MCEnterView>
{
	// @member
public:
	CArray1<RoleDetail> roleList;			///< 玩家列表

public:
	DPACKET_BASE_DEF(MCEnterView, PACKET_MC_ENTER_VIEW, CServerPacket);
	DPACKET_IMPL1(roleList);

public:
	inline sint32 size()
	{
		return roleList.size();
	}
// public:
// 	MCEnterView() : CServerPacket(PACKET_MC_ENTER_VIEW)
// 	{
// 		DCleanPacketStruct(CServerPacket);
// 	}
// 
// 	// @member
// public:
// 	enum
// 	{
// 		MAX_OBJ_NUM = 1000,
// 		MAX_DATA_LEN = MAX_COMPRESS_LEN-5000,
// 	};
// 	uint16 num;						///< 对象个数
// 	/**
// 	 * @brief 参考下面的说明
// 	 * 
// 	 * - 对象数据, 根据对应的对象外观结构解析
// 	 * - 每个结构为:
// 	 *		-# 对像类型+外观结构
// 	 *          \li uint8 type;
// 	 *			\li _PackRoleShape shape;
// 	 *		-# 类型定义
// 	 *			\li 对像类型: @ref EObjType
// 	 *			\li 玩家外观: @ref PackRoleShape
// 	 */
// 	char data[MAX_DATA_LEN];
// 
// public:
// 	uint16 dataLen;					// 数据长度	@NODOC
// 
// public:
// 	TPackLen_t getPackLen()
// 	{
// 		totalLen = sizeof(CServerPacket)+sizeof(num)+dataLen;
// 		return totalLen;
// 	}
// 
// 	bool isMax(TObjType_t objType)
// 	{
// 		return (uint32)num >= (uint32)MAX_OBJ_NUM || (uint32)(MAX_DATA_LEN-dataLen)<(uint32)(getShapePackLen(objType)+sizeof(objType));
// 	}
// 
// 	char* curData()
// 	{
// 		return data+dataLen;
// 	}
// 
// 	void pushObjType(TObjType_t objType)
// 	{
// 		*((TObjType_t*)curData()) = objType;
// 		dataLen += sizeof(objType);
// 		num++;
// 	}
// 
// 	void addLen(uint16 len)
// 	{
// 		dataLen += len;
// 	}
// 
// 	void cleanUp()
// 	{
// 		num = 0;
// 		dataLen = 0;
// 	}
// 
// 	uint16 getShapePackLen(TObjType_t objType)
// 	{
// 		switch(objType)
// 		{
// 		case OBJ_TYPE_ROLE:
// 			{
// 				return sizeof(TPackRoleShape);
// 			}break;
// 		default:
// 			{
// 				gxAssert(false);
// 				gxWarning("Can't get packet len! ObjType = {0}", (uint32)objType);
// 			}
// 		}
// 
// 		return 0;
// 	}
};

/// @ref PACKET_MC_LEAVE_VIEW
class MCLeaveView : public CServerPacket, public GXMISC::IStreamableStaticAll<MCLeaveView>
{
	// @member
public:
	CArray1<TObjUID_t> objAry;		///< 对象列表

public:
	DPACKET_BASE_DEF(MCLeaveView, PACKET_MC_LEAVE_VIEW, CServerPacket);
	DPACKET_IMPL1(objAry);

// public:
// 	TPackLen_t getPackLen()
// 	{
// 		totalLen = (TPackLen_t)(sizeof(CServerPacket)+objAry.sizeInBytes());
// 		return totalLen;
// 	}
public:
	void push(TObjUID_t objUID, TObjType_t objType)
	{
		objAry.resize(objAry.size()+1);
		objAry[objAry.size()-1]=objUID;
	}
};
/** @}*/

/** @defgroup PackSceneData 场景数据
* @{
*/
class MCSceneData : public CServerPacket,  public GXMISC::IStreamableStaticAll<MCSceneData>
{
	// @member
public:
	CArray1<TNPCTypeID_t> npcs;							///< NPC列表
	CArray1<TTransportTypeID_t> trans;					///< 传送点列表
// 	TMapID_t mapID;										///< 玩家在当前场景地图ID
// 	_AxisPos pos;										///< 玩家在当前场景坐标

public:
	DPACKET_BASE_DEF(MCSceneData, PACKET_MC_SCENE_DATA, CServerPacket);
	DPACKET_IMPL2(npcs, trans);
};
/** @}*/

/** @defgroup PackMovePos 移动坐标
* @{
*/
class CMMove : public CRequestPacket, public GXMISC::IStreamableStaticAll<CMMove>
{
	// @member
public:
	uint8 moveType;									///< 移动类型 @ref ERoleMoveType
	CArray1<struct AxisPos> posList;				///< 坐标列表

public:
	DPACKET_BASE_DEF(CMMove, PACKET_CM_MOVE, CRequestPacket);
	DPACKET_IMPL1(posList);
};
class MCMoveRet : public CResponsePacket
{
	DResPacketImpl(MCMoveRet, PACKET_MC_MOVE_RET);
};
class MCMoveBroad : public CServerPacket, public GXMISC::IStreamableStaticAll<CMMove>
{
	// @member
public:
	TObjUID_t objUID;						///< 对象UID
	uint8 moveType;							///< 移动类型 @ref ERoleMoveType
	CArray1<struct AxisPos> posList;		///< 位置列表

public:
	DPACKET_BASE_DEF(MCMoveBroad, PACKET_MC_MOVE_BROAD, CServerPacket);
	DPACKET_IMPL1(posList);

	DPacketToStringAlias(MCMoveBroad, TObjUID_t, ObjUID, objUID);
};
/** @}*/
/** @defgroup PackJump 跳跃
* @{
*/
class CMJump : public CRequestPacket
{
	// @member
public:
	TMoveSpeed_t x;		///< X速度
	TMoveSpeed_t y;		///< Y速度

	DReqPacketImpl(CMJump, PACKET_CM_JUMP);
};
class MCJumpRet : public CResponsePacket
{
	// @member
public:
	TObjUID_t objUID;	///< 对象UID
	TMoveSpeed_t x;		///< X速度
	TMoveSpeed_t y;		///< Y速度

	DResPacketImpl(MCJumpRet, PACKET_MC_JUMP_RET);
};
class CMDrop : public CRequestPacket
{
	// @member
public:
	TMoveSpeed_t x;		///< X速度
	TMoveSpeed_t y;		///< Y速度

	DReqPacketImpl(CMDrop, PACKET_CM_DROP);
};
class MCDropRet : public CResponsePacket
{
	// @member
public:
	TObjUID_t objUID;	///< 对象UID
	TMoveSpeed_t x;		///< X速度
	TMoveSpeed_t y;		///< Y速度

	DResPacketImpl(MCDropRet, PACKET_MC_DROP_RET);
};
class CMLand : public CRequestPacket
{
	// @member
public:
	TObjUID_t objUID;		///< 停靠的对象UID(地表则为0)
	TAxisPos_t x;			///< 着陆位置X
	TAxisPos_t y;			///< 着陆位置Y

	DReqPacketImpl(CMLand, PACKET_CM_LAND);
};
class MCLandRet : public CResponsePacket
{
	// @member
public:
	TObjUID_t srcObjUID;	///< 对象UID
	TObjUID_t objUID;		///< 停靠的对象UID(地表则为0)
	TAxisPos_t x;			///< 着陆位置X
	TAxisPos_t y;			///< 着陆位置Y

	DResPacketImpl(MCLandRet, PACKET_MC_LAND_RET);
};
/** @}*/

/** @defgroup PackResetPos 瞬移
* @{
*/
class MCResetPos : public CServerPacket
{
	// @member
public:
	TObjUID_t objUID;		///< 对象UID
	TAxisPos_t x;			///< X位置
	TAxisPos_t y;			///< Y位置
	uint8 type;				///< 类型(@ref EResetPosType)

	DSvrPacketImpl(MCResetPos, PACKET_MC_RESET_POS);
};
/** @}*/

/** @defgroup PackEnterScene 场景协议
* @{
*/
class MCEnterScene : public CServerPacket
{
	// @member
public:
	uint8 mapType;				///< 地图类型
public:
	DSvrPacketImpl(MCEnterScene, PACKET_MC_ENTER_SCENE)
};
class CMEnterScene : public CRequestPacket
{
public:
	DReqPacketImpl(CMEnterScene, PACKET_CM_ENTER_SCENE)
};
class MCEnterSceneRet : public CResponsePacket,  public GXMISC::IStreamableStaticAll<MCEnterSceneRet>
{
	// @member
public:
	TMapID_t mapID;										///< 地图ID
	AxisPos pos;										///< 当前坐标
	CArray1<TNPCTypeID_t> npcs;							///< NPC列表
	CArray1<TTransportTypeID_t> trans;					///< 传送点列表

public:
	DPACKET_BASE_DEF(MCEnterSceneRet, PACKET_MC_ENTER_SCENE_RET, CResponsePacket);
	DPACKET_IMPL2(npcs, trans);
};
class CMChangeMap : public CRequestPacket
{
	// @member
public:
	TMapID_t mapID;				///< 地图ID
public:
	DReqPacketImpl(CMChangeMap, PACKET_CM_CHANGE_MAP);
};
class MCChangeMapRet : public CResponsePacket
{
	// @member
public:
	TMapID_t mapID;				///< 地图ID

public:
	DResPacketImpl(MCChangeMapRet, PACKET_MC_CHANGE_MAP_RET);
};
class CMDynamicMapList : public CRequestPacket
{
	// @member
public:
	uint8 mapType;				///< 地图类型

public:
	DReqPacketImpl(CMDynamicMapList, PACKET_CM_DYNAMIC_MAP_LIST);
};
class MCDynamicMapListRet : public CResponsePacket, public GXMISC::IStreamableStaticAll<MCDynamicMapListRet>
{
	// @member
public:
	CArray1<TSceneID_t> scenes;		///< 场景列表

public:
	DPACKET_BASE_DEF(MCDynamicMapListRet, PACKET_MC_DYNAMIC_MAP_LIST_RET, CResponsePacket);
	DPACKET_IMPL1(scenes);
};
/** @}*/
/** @defgroup PackChat 聊天
* @{
*/
class CMChat : public CRequestPacket, public GXMISC::IStreamableStaticAll<CMChat>
{
	// @member
public:
	uint8 channelType;				///< 聊天频道（0非法，1世界，2军团，3私聊，4公告, 5GM)
	TObjUID_t objUid;               ///< 角色uid（目标者）
	TRoleName_t roleName;           ///< 角色名字
	TCharArray2 msg;				///< 消息内容
	TCharArray2 perMsg;             ///< 特殊的消息内容（供客户端额外使用）

public:
	DPACKET_BASE_DEF(CMChat, PACKET_CM_CHAT, CRequestPacket);
	DPACKET_IMPL3(roleName, msg, perMsg);
};
class MCChatBroad : public CResponsePacket, public GXMISC::IStreamableStaticAll<MCChatBroad>
{
	// @member
public:
	uint8   channelType;			///< 聊天频道
	TObjUID_t objUid;               ///< 角色uid（发送者）
	TRoleName_t roleName;           ///< 角色名字
	TCharArray2 msg;				///< 消息内容
	TCharArray2 perMsg;             ///< 特殊的消息内容（供客户端额外使用）

public:
	DPACKET_BASE_DEF(MCChatBroad, PACKET_MC_CHAT_BROAD, CResponsePacket);
	DPACKET_IMPL3(roleName, msg, perMsg);
};
class MCAnnouncement : public CServerPacket, public GXMISC::IStreamableStaticAll<MCAnnouncement>
{
	// @member
public:
	sint16 id;						///< 公告ID 如果公告ID为0则msg表示公告内容,直接显示
	TCharArray2 key;				///< 公告Key
	TCharArray2 msg;				///< 公告信息 格式: type1|id|xxx,type2|id|xxx @ref EAnnouncement

public:
	DPACKET_BASE_DEF(MCAnnouncement, PACKET_MC_ANNOUNCEMENT, CServerPacket);
	DPACKET_IMPL2(key, msg);
};
/** @}*/
/** @defgroup PackTransmite 传送点传送
* @{
*/
class CMTransmite : public CRequestPacket
{
	// @member
public:
	TTransportTypeID_t transportTypeID;			///< 传送点类型ID

public:
	DReqPacketImpl(CMTransmite, PACKET_CM_TRANSMITE);
};
class MCTransmiteRet : public CResponsePacket
{
public:
	DResPacketImpl(MCTransmiteRet, PACKET_MC_TRANSMITE_RET);
};
/** @}*/

/** @defgroup PackSyncRoleData 同步角色数据
* @{
*/
class MCSyncRoleData : public CServerPacket
{
	// @member
public:
	TObjUID_t objUID;				///< 对象UID
	uint8 num;						///< 数目
	char datas[MAX_SYNC_DATA_LEN];	///< 混合结构列表(枚举[8位]:属性值[根据具体的类型获得实际位数]) @ref EAttributes @ref RoleAttrBackup
	uint16 dataLen;					///< 数据长度(此字段不发送) @NODOC

public:
	MCSyncRoleData() : CServerPacket(PACKET_MC_SYNC_ROLE_DATA)
	{
		DCleanPacketStruct(CServerPacket);
	}

	TPackLen_t getPackLen()
	{
		totalLen = sizeof(CServerPacket)
			+ sizeof(objUID)
			+ sizeof(num)
			+ dataLen;

		return totalLen;
	}

	template<typename T>
	void push(uint8 attrIndex, T& val)
	{
		memcpy(datas+dataLen, &attrIndex, sizeof(attrIndex));
		dataLen += sizeof(attrIndex);
		memcpy(datas+dataLen, &val, sizeof(val));
		num++;
		dataLen += sizeof(val);
	}

	void reset()
	{
		num = 0;
		dataLen = 0;
	}

	bool isDirty()
	{
		return num > 0;
	}
};
/** @}*/
/** @defgroup PackCallBackRetCode 返回错误码
* @{
*/
class MCCallBackRetCode : public CServerPacket
{
public:
	DSvrPacketImpl(MCCallBackRetCode, PACKET_MC_CALLLBACKRETCODE);

	// @member
public:
	TRetCode_t retCode;	///< 返回码
};
/** @}*/
/** @defgroup PackRenameRoleName 修改角色名字
* @{
*/
class CMRenameRoleName : public CRequestPacket, GXMISC::IStreamableStaticAll<CMRenameRoleName>
{
	// @member
public:
	TCharArray2 roleName;	///< 角色名字

public:
	DPACKET_BASE_DEF(CMRenameRoleName, PACKET_CM_RENAME_ROLE_NAME, CRequestPacket);
	DPACKET_IMPL1(roleName);
};
class MCRenameRoleNameRet : public CResponsePacket, GXMISC::IStreamableStaticAll<MCRenameRoleNameRet>
{
	// @member
public:
	TCharArray2 roleName;	///< 角色名字

public:
	DPACKET_BASE_DEF(MCRenameRoleNameRet, PACKET_MC_RENAME_ROLE_NAME_RET, CResponsePacket);
	DPACKET_IMPL1(roleName);
};
/** @}*/
/** @defgroup PackCMRandRoleName 随机角色名字
* @{
*/
class CMRandRoleName : public CRequestPacket
{
public:
	DReqPacketImpl(CMRandRoleName, PACKET_CM_RAND_ROLE_NAME);
};
class MCRandRoleNameRet : public CResponsePacket, GXMISC::IStreamableStaticAll<MCRandRoleNameRet>
{
	// @member
public:
	TCharArray2 roleName;	///< 角色名字

public:
	DPACKET_BASE_DEF(MCRandRoleNameRet, PACKET_MC_RAND_ROLE_NAME_RET, CResponsePacket);
	DPACKET_IMPL1(roleName);
};
/** @}*/
/** @defgroup PackKickRole 踢掉玩家
* @{
*/
class MCKickRole : public CServerPacket
{
	// @member
public:
	sint8 type;			///< 踢掉玩家类型 @ref EKickType

public:
	DSvrPacketImpl(MCKickRole, PACKET_CM_KICK_ROLE);
};
/** @}*/
/** @defgroup PackOpenDynamicMap 开启副本
* @{
*/
class CMOpenDynamicMap : public CRequestPacket
{
	// @member
public:
	TMapID_t mapID;				///< 地图ID

public:
	DReqPacketImpl(CMOpenDynamicMap, PACKET_CM_OPEN_DYNAMIC_MAP);
};
class MCOpenDynamicMapRet : public CResponsePacket
{
	// @member
public:
	TMapID_t mapID;				///< 地图ID

public:
	DResPacketImpl(MCOpenDynamicMapRet, PACKET_MC_OPEN_DYNAMIC_MAP_RET);
};
/** @}*/

class CMWorldChatMsg : public CRequestPacket
{
public:
	TCharArray2 msg;

public:
	DReqPacketImpl(CMWorldChatMsg, PACKET_CM_WORLDMSG);
};
class MCWorldChatMsg : public CServerPacket, GXMISC::IStreamableStaticAll<MCWorldChatMsg>
{
public:
	TCharArray2 fromPlayer; 
	TCharArray2 fromPlayerTitle; 
	TCharArray2 msg; 
	sint16 fromPlayerVipLv;

public:
	DPACKET_BASE_DEF(MCWorldChatMsg, PACKET_MC_WORLDCHATMSG_RET, CServerPacket);
	DPACKET_IMPL3(fromPlayer, fromPlayerTitle, msg);
};
class CMRoomChatMsg : public CRequestPacket
{
public:
	TCharArray2 msg;

public:
	DReqPacketImpl(CMRoomChatMsg, PACKET_CM_ROOMMSG);
};
class MCRoomChatMsg : public CServerPacket, GXMISC::IStreamableStaticAll<MCRoomChatMsg>
{
public:
	TCharArray2 fromPlayer; 
	TCharArray2 fromPlayerTitle; 
	TCharArray2 msg; 
	sint16 fromPlayerVipLv;

public:
	DPACKET_BASE_DEF(MCRoomChatMsg, PACKET_MC_ROOMCHATMSG_RET, CServerPacket);
	DPACKET_IMPL3(fromPlayer, fromPlayerTitle, msg);
};

class MCScreenAnnounce : public CServerPacket, GXMISC::IStreamableStaticAll<MCScreenAnnounce>
{
public:
	TCharArray2 name;
	uint8 type;
	sint32 count;

public:
	DPACKET_BASE_DEF(MCScreenAnnounce, PACKET_MC_SCREENANNOUNCE_RET, CServerPacket);
	DPACKET_IMPL1(name);
};

/** @}*/
// @BEGNODOC
#pragma pack(pop)

#endif	// _PACKET_CM_BASE_H_
// @ENDDOC