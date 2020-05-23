// @BEGNODOC
#ifndef _PACKET_CM_BAG_H_
#define _PACKET_CM_BAG_H_

#include "core/types_def.h"

#include "item_struct.h"
#include "packet_include_header.h"

#pragma pack(push, 1)
// @ENDDOC

/** @defgroup PackBagModule 背包模块
* @{
*/
/** @defgroup PackBagOperator 背包操作
* @{
*/
class MCAddItems : public CServerPacket, public GXMISC::IStreamableStaticAll<MCAddItems>
{
	// @member
public:
	uint8 bagType;							///< 背包类型 @ref EPackType
	CArray1<struct PackItem> items;			///< 添加的道具列表

public:
	DPACKET_BASE_DEF(MCAddItems, PACKET_MC_ADD_ITEM, CServerPacket);
	DPACKET_IMPL1(items);

	typedef uint32 _TPackToStringT;
	std::string toString()
	{
		std::string str = "";
		for (uint32 i = 0; i < items.size(); ++i)
		{
			str += items[i].toString();
			str += "\n";
		}

		return str;
	}
};
class MCDelItems : public CServerPacket, public GXMISC::IStreamableStaticAll<MCDelItems>
{
	// @member
public:
	uint8 bagType;						///< 背包类型 @ref EPackType
	CArray1<TObjUID_t> items;			///< 删除的道具列表

public:
	DPACKET_BASE_DEF(MCDelItems, PACKET_MC_DELETE_ITEM, CServerPacket);
	DPACKET_IMPL1(items);
};
class MCUpdateItems : public CServerPacket, public GXMISC::IStreamableStaticAll<MCUpdateItems>
{
	// @member
public:
	uint8 bagType;							///< 背包类型 @ref EPackType
	CArray1<struct UpdateItem> items;		///< 更新道具列表

public:
	DPACKET_BASE_DEF(MCUpdateItems, PACKET_MC_UPDATE_ITEM, CServerPacket);
	DPACKET_IMPL1(items);
};
class MCMoveItems : public CServerPacket, public GXMISC::IStreamableStaticAll<MCMoveItems>
{
	// @member
public:
	CArray1<struct MoveItem> items;				///< 道具列表

public:
	DPACKET_BASE_DEF(MCMoveItems, PACKET_MC_MOVE_ITEM, CServerPacket);
	DPACKET_IMPL1(items);
};
class MCExchangeItem : public CServerPacket
{
	// @member
public:
	uint8 srcBagType;						///< 源背包类型
	TObjUID_t srcItemUID;					///< 源道具UID
	uint8 destBagType;						///< 目标背包类型
	TObjUID_t destItemUID;					///< 目标道具UID

public:
	DSvrPacketImpl(MCExchangeItem, PACKET_MC_EXCHANGE_ITEM);
};
class CMBagOperate : public CRequestPacket
{
	// @member
public:
	uint8 opType;							///< 操作类型 @ref EBagOperateType
	TContainerIndex_t index;				///< 背包位置

public:
	DReqPacketImpl(CMBagOperate, PACKET_CM_BAG_OPERATOR);
};
class MCBagOperateRet : public CResponsePacket
{
public:
	DResPacketImpl(MCBagOperateRet, PACKET_MC_BAG_OPERATOR_RET);
};
class CMBagExtend : public CRequestPacket
{
	// @member
public:
	TItemContainerSize_t size;			///< 背包增加的格子数

public:
	DReqPacketImpl(CMBagExtend, PACKET_CM_BAG_BUY_GRID);
};
class MCBagExtendRet : public CResponsePacket
{
public:
	DResPacketImpl(MCBagExtendRet, PACKET_MC_BAG_BUY_GRID_RET);
};
class MCBagExtend :public CServerPacket
{
	// @member
public:
	TItemContainerSize_t size;						///< 背包增加的格子数

public:
	DSvrPacketImpl(MCBagExtend, PACKET_MC_BAG_ADD_GRID);
};
/*
class CMUseItem : public CRequestPacket
{
public:
	uint8		type;
	TObjUID_t	itemObjUID;
	TObjUID_t	srcObjUID;
	TObjUID_t	destObjUID;

	DReqPacketImpl(CMUseItem, PACKET_CM_USE_ITEM);
};
class MCUseItemRet : public CResponsePacket
{
public:
	TObjUID_t		objUID;
	TItemTypeID_t	typeID;

	DResPacketImpl(MCUseItemRet, PACKET_MC_USE_ITEM_RET);
};
*/

/** @}*/

/** @defgroup packetExchangeGift 兑换奖励
* @{
*/
class CMExchangeGiftReq : public CRequestPacket
{
	// @member
public:
	TExchangeGiftID_t    id;            ///< 兑换码

public:
	DReqPacketImpl(CMExchangeGiftReq, PACKET_CM_EXCHANGE_GIFT_REQ);
};
class MCExchangeGiftRet : public CResponsePacket
{
	// @member
public:
	TExchangeItemID_t itemId;			///< 兑换对应的礼包ID

public:
	DResPacketImpl(MCExchangeGiftRet, PACKET_MC_EXCHANGE_GIFT_RET);
};
/** @}*/

/** @}*/		// 背包模块

// @BEGNODOC
#pragma pack(pop)

#endif	// _PACKET_CM_BAG_H_
// @ENDDOC