// @BEGNODOC
#ifndef _ITEM_STRUCT_
#define _ITEM_STRUCT_

#include "core/parse_misc.h"

#include "game_misc.h"
#include "db_struct_base.h"
#include "db_util.h"
#include "game_binary_string.h"
#include "fix_array.h"
#include "time_manager.h"
#include "item_define.h"
#include "attributes.h"
#include "core/carray.h"
#include "base_packet_def.h"
#include "streamable_util.h"

#pragma pack(push, 1)

// @ENDDOC

typedef std::vector<TItemTypeID_t>									TItemIDVec;					///< 道具ID列表
typedef GXMISC::CFixArray<struct ExtendAttr, ITEM_APPEDN_ATTR_NUM>		TAppendAttrFixAry;		///< 附加属性固定列表
typedef GXMISC::CArray<struct ExtendAttr, ITEM_APPEDN_ATTR_NUM>			TAppendAttrAry;			///< 附加属性列表
typedef GXMISC::CArray<TItemTypeID_t, ITEM_MAX_HOLE_TOTAL_NUM>		TGemAry;					///< 宝石ID固定列表
typedef GXMISC::CArray<TAttr, ITEM_MAX_EXTRA_ATTR_NUM>				TAttrAry;					///< 属性列表
typedef GXMISC::CArray<TAttr, ITEM_BASE_ATTR_NUM>					TBaseAttrAry;				///< 基础属性列表
typedef GXMISC::CArray<TExtendAttr, ITEM_APPEDN_ATTR_NUM>			TExtendAttrAry;				///< 扩展属性列表

///< 道具位置
typedef struct ItemPosition
{
	// @member
public:
	uint8				type;			///< 背包类型 @ref EPackType
	TContainerIndex_t	index;			///< 位置索引

public:
	ItemPosition()
	{
		cleanUp();
	}

	ItemPosition(uint8 packType, TContainerIndex_t packIndex)
	{
		type = packType;
		index = packIndex;
	}

	bool operator == (const ItemPosition& rhs)
	{
		return memcmp(this, &rhs, sizeof(ItemPosition)) == 0;
	}

public:
	void cleanUp()
	{
		type = PACK_TYPE_INVALID;
		index = INVALID_CONTAINER_INDEX;
	}

	bool isValid() const
	{
		gxAssert(
			(type == PACK_TYPE_INVALID && index == INVALID_CONTAINER_INDEX)
			||
			(type != PACK_TYPE_INVALID && index != INVALID_CONTAINER_INDEX)
			);

		return !(type == PACK_TYPE_INVALID && index == INVALID_CONTAINER_INDEX);
	}
}TItemPosition;
static const TItemPosition INVALID_ITEM_POSITION;

/// 武器孔结构
typedef struct HoleGemInfo
{
	// @member
public:
	uint8 pos;				///< 位置
	TItemTypeID_t id;		///< 道具ID

public:
	HoleGemInfo()
	{
		memset(this, 0, sizeof(*this));
	}

	HoleGemInfo(uint8 pos, TItemTypeID_t id)
	{
		this->pos = pos;
		this->id = id;
	}

	void cleanUp(uint8 pos, TItemTypeID_t id)
	{
		this->pos = pos;
		this->id = id;
	}

	bool operator == (const HoleGemInfo& rhs)
	{
		return memcmp(this, &rhs, sizeof(*this)) == 0;
	}
}THoleGemInfo;
typedef GXMISC::CArray<struct HoleGemInfo, MAX_ITEM_CURR_HOLE_NUM>		THoleGemAry;				///< 镶嵌宝石列表

typedef struct _ItemType
{
	// @member
public:
	uint8	type;					///< 物品的大类(参考EItemType)
	uint8	subType;				///< 物品的子类
}TItemType;

// 移动物品结构
typedef struct MoveItem
{
	// @member
public:
	uint8				srcType;			///< 源背包类型 @ref EPackType
	TObjUID_t			objUID;				///< 对象UID
	uint8				destType;			///< 目标背包类型 @ref EPackType
	TContainerIndex_t	destIndex;			///< 目标位置索引

public:
	MoveItem(){}
}TMoveItem;

// 更新物品结构
typedef struct UpdateItem
{
	// @member
public:
	TObjUID_t objUID;					///< 对象UID
	TContainerIndex_t index;			///< 索引位置
	TItemNum_t itemNum;					///< 道具数目

public:
	UpdateItem(){}
}TUpdateItem;

typedef struct SimpleItem
{
	// @member
public:
	TItemTypeID_t id;				///< 类型ID
	TItemNum_t itemNum;				///< 数目

public:
	SimpleItem()
	{
		id = INVALID_ITEM_TYPE_ID;
		itemNum = 0;
	}
	SimpleItem(TItemTypeID_t itemTypeID, TItemNum_t num)
	{
		this->id = itemTypeID;
		this->itemNum = num;
	}
}TSimpleItem;
typedef std::vector<struct SimpleItem> TItemVec;

// 扩展的物品结构
typedef struct ExtItem
{
	// @member
public:
	struct SimpleItem item;	///< 物品
	uint8 bind;				///< 绑定规则
	uint8 streLevel;		///< 强化等级

public:
	ExtItem()
	{
		bind = BIND_TYPE_INVALID;
		streLevel = 0;
	}

	bool operator == (const ExtItem& rhs)
	{
		return item.id == rhs.item.id;
	}

	bool operator == (const TItemTypeID_t id)
	{
		return item.id == id;
	}

}TExtItem;
typedef std::vector<struct ExtItem>						TExtItemVec;				///< 扩展道具列表

/// 奖励道具结构
typedef struct ItemReward
{
	// @member
public:
	TItemTypeID_t		itemTypeID;			///< 道具类型ID
	uint32				itemNum;			///< 道具数目(有代币)

public:
	ItemReward()
	{
		clean();
	}

	ItemReward(TItemTypeID_t itemTypeID, uint32 num)
	{
		clean();

		itemTypeID = itemTypeID;
		itemNum = num;
	}

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}
}TItemReward;
typedef CArray1<struct ItemReward> TItemRewardAry;				///< 奖励表列
typedef std::vector<struct ItemReward> TItemRewardVec;			///< 公用道具结构列表

/// 物品
typedef struct PackItem : public GXMISC::IStreamableAll
{
	// @member
public:
	TObjUID_t			objUID;			///< 对象唯一ID
	TItemTypeID_t		itemTypeID;		///< 类型ID
	TContainerIndex_t	index;			///< 位置索引
	TItemNum_t			count;			///< 数目
	uint8				quality;		///< 品质
	uint8				bind;			///< 绑定
	uint32				remainTime;		///< 剩余时间
	uint8				stre;			///< 强化等级
	CArray1<struct ExtendAttr> appendAttrAry;	///< 附加属性
	CArray1<struct HoleGemInfo> holeGemAry; ///< 镶嵌的宝石信息

public:
	DSTREAMABLE_IMPL2(appendAttrAry, holeGemAry);
	DFastPacketToString3(PackItem, objUID, count, index);
}TPackItem;

// @BEGNODOC
#pragma pack(pop)

#endif	// _ITEM_STRUCT_
// @ENDDOC