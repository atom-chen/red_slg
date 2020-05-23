/*
// @BEGNODOC
#ifndef _GAME_BAGSTRUCT_H
#define _GAME_BAGSTRUCT_H

#include "core/base_util.h"

#include "game_util.h"
#include "game_struct.h"
#include "server_define.h"

#pragma pack(push, 1)
// @ENDDOC

/// 道具结构
typedef struct ItemInfo
{
	TItemTypeID_t				itemTypeID;			///< 道具编号
	TItemNum_t					itemNum;			///< 物品数量

public:
	ItemInfo()
	{
		clean();
	}
	ItemInfo(TItemTypeID_t itemTypeID, TItemNum_t num)
	{
		clean();
		this->itemTypeID = itemTypeID;
		this->itemNum = num;
	}

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}
}TItemInfo;
typedef std::vector<struct ItemInfo> TItemInfoVec;			///< 公用道具结构列表(添加)
typedef std::vector<TItemIndexID_t> TItemIndexIDVec;		///< 公用道具ID列表(删除)
typedef CArray1<struct ItemInfo> TItemShowInfoAry;			///< 下发所有的道具列表

/// 背包道具结构(接受) @TODO 修改名字
// typedef struct RecItemInfo
// {
// public:
// 	TItemUID_t					itemGUID;			///< ID(唯一)
// 	TItemIndexID_t				itemIndex;			///< 物品索引
// 	TItemInfo					itemComInfo;		///< 公用道具结构
// 
// public:
// 	RecItemInfo()
// 	{
// 		clean();
// 	}
// 
// 	void clean()
// 	{
// 		::memset(this, 0 ,sizeof(this));
// 	}
// }TRecItemInfo;

/// 背包道具结构(下发) @TODO 修改名字
typedef struct SendItemInfo : public GXMISC::IStreamableAll
{
	// @member
public:
	TItemUID_t					itemGUID;			///< ID(唯一)
	TItemIndexID_t				itemIndex;			///< 物品索引
	TAddAttrAry					itemAry;			///< 附加属性
	struct ItemInfo				itemInfo;			///< 公用道具结构

public:
	DSTREAMABLE_IMPL1(itemAry);

	SendItemInfo()
	{
		clean();
	}

	void clean()
	{
		::memset(this, 0 ,sizeof(this));
	}
}TSendItemInfo;
typedef CArray1<struct SendItemInfo> TItemInfoAry;						///< 背包道具列表

/// 整理背包(更新属性位置)
typedef struct NeatenUpdateItemAttr : public GXMISC::IArrayEnableSimple<struct NeatenUpdateItemAttr>
{
public:
	TItemUID_t					itemGUID;			///< 唯一ID
	TItemNum_t					itemNum;			///< 道具数量
	TItemIndexID_t				itemIndex;			///< 道具索引

public:
	NeatenUpdateItemAttr()
	{
		clean();
		DArrayKey(itemGUID);
	}

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}
}TNeatenUpdataItemAttr;

/// 整理背包删除道具 @TODO 以后删除不用 
typedef struct NeatenDeleteItem
{
public:
	TItemUID_t					itemGUID;			///< ID(唯一)

public:
	NeatenDeleteItem()
	{
		clean();
	}

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}
}TNeatenDeleteItem;
typedef CArray1<struct NeatenUpdateItemAttr> TUpdateItemInfoAry;						///< 更新属性列表
typedef CArray1<struct NeatenDeleteItem> TDeleteItemInfoAry;							///< 删除道具列表

/// 更新道具结果
typedef struct UpdateItem
{
	TItemUID_t					itemGUID;			///< ID(唯一)
	TItemNum_t					itemNum;			///< 道具数量
	TItemIndexID_t				itemIndex;			///< 道具下标

public:
	UpdateItem()
	{
		clean();
	}
	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}
}TUpdateItem;
typedef CArray1<struct UpdateItem> TActUpdateItemAry;	///< 主动更新道具列表

/// 主动删除道具结果
typedef struct DeleteItem
{
	// @member
public:
	TItemUID_t					itemGUID;			///< ID(唯一)

public:
	DeleteItem()
	{
		clean();
	}

	void clean()
	{
		::memset(this, 0, sizeof(*this));
	}
}TDeleteItem;
typedef CArray1<struct DeleteItem> TDeleteItemAry;			///< 主动删除道具列表

/// 单个背包物品结构（配置表）
typedef struct BagItem
{
	// @member
public:
	TItemTypeID_t			itemTypeID;			///< 道具编号
	TItemType_t				itemType;			///< 道具类型
	TItemType_t				itemSubType;		///< 道具子类类型
	TLevel_t				itemUseLvL;			///< 道具使用等级
	TItemQuality_t			itemQuality;		///< 道具品质
	TExtentAttrVec			attrvExtentVec;		///< 道具属性列表
	TBufferTypeID_t			buffID;				///< buffID
	sint32					itemFuncID;			///< 道具功能ID
	sint32					itemTouckKey;		///< 触发文本ID
	sint32					itemTouchEffID;		///< 触发效果ID
	sint32					itemTouchEffVar;	///< 触发效果值
	sint32					itemTouchEffCon;	///< 触发效果内容
	uint8					sale;				///< 是否可以出售
	TGold_t					gold;				///< 金钱
	TItemNum_t				itemPileLimit;		///< 堆叠上限
	GXMISC::CGameTime		timeLimitTime;		///< 生效时限
	uint8					priority;			///< 优先级别

public:
	BagItem()
	{
		::memset(this, 0, sizeof(*this));
		itemPileLimit = 1;		// 防止策划没有配置堆叠上限
	}
}TBagItem;

/// 使用道具结构消息(@TODO 删除掉此结构)
// typedef struct OnUseItem
// {
// 	uint8				bagType;			///< 背包类型
// 	TItemIndexID_t		itemIndex;			///< 道具下标
// 	TItemTypeID_t		itemTypeID;			///< 道具编号
// 	TItemNum_t			itemNum;			///< 道具数量
// 	TObjUID_t			onUseTarget;		///< 使用目标
// 
// public:
// 	OnUseItem()
// 	{
// 		clean();
// 	}
// 
// 	void clean()
// 	{
// 		::memset(this, 0 ,sizeof(*this));
// 	}
// }TOnUseItem;

/// 道具逻辑结构体
// typedef struct ItemLogic
// {
// 	// @member
// public:
// 	TExtentAttrVec			attrvExtentVec;		///< 道具属性列表
// 	TBufferTypeID_t			buffID;				///< buffID
// 	sint32					itemFuncID;			///< 道具功能ID
// 	sint32					itemTouckKey;		///< 触发文本ID
// 	sint32					itemTouchEffID;		///< 触发效果ID
// 	sint32					itemTouchEffCon;	///< 触发效果内容
// 	sint32					itemTouchEffVar;	///< 触发效果值
// 
// public:
// 	ItemLogic()
// 	{
// 		attrvExtentVec.clear();
// 		buffID			= 0;
// 		itemFuncID		= 0;
// 		itemTouckKey	= 0;
// 		itemTouchEffID	= 0;
// 		itemTouchEffVar	= 0;
// 		itemTouchEffCon	= 0;
// 	}
// }TItemLogic;
typedef CArray1<TItemTypeID_t> TItemTypeIDAry;	///< 道具列表

/// 奖励道具结构
typedef struct ItemReward
{
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
typedef CArray1<ItemReward> TItemRewardAry;						///< 奖励表列
typedef std::vector<struct ItemReward> TItemRewardVec;			///< 公用道具结构列表

// 技能道具
// typedef struct SkillItem
// {
// 	TSkillID_t		skillid;		///< 技能ID
// 	TItemTypeID_t	itemTypeID;		///< 道具ID
// 
// public:
// 	SkillItem()
// 	{
// 		clean();
// 	}
// 
// 	void clean()
// 	{
// 		::memset(this, 0, sizeof(*this));
// 	}
// }TSkillItem;
// typedef std::vector<TSkillItem> TSkillItemVec;				///< 检查技能开启与道具对应数据列表

// @BEGNODOC
#pragma pack(pop)

#endif //_GAME_BAGSTRUCT_H
// @ENDDOC
*/