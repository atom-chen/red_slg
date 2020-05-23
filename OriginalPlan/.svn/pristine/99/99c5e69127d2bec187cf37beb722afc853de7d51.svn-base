#ifndef _GAME_DB_STRUCT_H_
#define _GAME_DB_STRUCT_H_

#include "carray.h"
#include "item_define.h"
#include "game_struct.h"

#include "core/db_struct_base.h"
#include "item_struct.h"

#pragma pack(push, 1)

typedef struct _DBAppendAttr : public GXMISC::TDBStructBase
{
	TAppendAttrAry data;
	_DBAppendAttr()
	{
		dbVersion = 1;
	}
}TDBAppendAttr;

typedef struct _DBGemFix : public GXMISC::TDBStructBase
{
	TGemAry data;
}TDBGemFix;

typedef struct _DbBaseItem : public GXMISC::TDBStructBase
{
public:
	// 基本属性
	TItemTypeID_t		itemTypeID;		///< 类型ID
	TItemPosition		pos;			///< 位置
	TItemNum_t			count;			///< 数目
	TItemQuality_t		quality;		///< 品质
	TItemBind_t			bind;			///< 绑定
	GXMISC::TGameTime_t   createTime;     ///< 创建的时间
	GXMISC::TGameTime_t	remainTime;		///< 剩余时间

	// 附加属性
	TItemStre_t		stre;				///< 强化等级
	TDBAppendAttr	appendAttr;			///< 附加属性
	TDBGemFix		holeItems;			///< 孔镶嵌的物品

	_DbBaseItem()
	{
		cleanUp();
		dbVersion = 1;
	}

public:
	GXMISC::TGameTime_t getRemainTime() const
	{
		if (remainTime == GXMISC::MAX_GAME_TIME)
		{
			return GXMISC::MAX_GAME_TIME;
		}

		GXMISC::TGameTime_t curTime = DTimeManager.nowSysTime();
		if ((curTime - createTime) > remainTime)
		{
			return 0;
		}
		return remainTime + createTime - curTime;
	}

public:
	std::string toString()
	{
		std::string str;
		GXMISC::CTimeManager::FormatSystemTime(createTime, str);
		return GXMISC::gxToString("DbVersion=%u,ItemTypeID=%u,Pos=%u:%u,Count=%u,Quality=%u,Bind=%u,"
			"CreateTime=%s,RemainTime=%u,Stre=%u,AppendAttrSize=%u",
			dbVersion, itemTypeID, pos.type, pos.index, count, quality, bind, str.c_str(), remainTime, stre, appendAttr.data.size());
	}

	void cleanUp()
	{
		itemTypeID = INVALID_ITEM_TYPE_ID;
		pos.cleanUp();
		count = 0;
		quality = 0;
		bind = BIND_TYPE_INVALID;
		remainTime = GXMISC::MAX_GAME_TIME;
		stre = 0;
		appendAttr.data.clear();
		holeItems.data.assign(INVALID_ITEM_TYPE_ID);
		createTime = DTimeManager.nowSysTime();
	}

	_DbBaseItem& operator = (const _DbBaseItem& ls)
	{
		memcpy(this, &ls, sizeof(ls));
		return *this;
	}
}TDbBaseItem;

typedef struct _DbItem : public TDbBaseItem
{
	TBaseAttrAry	baseAttr;		                    // 基础属性(不写入数据库)

public:
	_DbItem()
	{
		cleanUp();
	}

	_DbItem(const TDbBaseItem* item)
	{
		memcpy(this, item, sizeof(TDbBaseItem));
	}

	_DbItem& operator = (const TDbBaseItem& item)
	{
		memcpy(this, &item, sizeof(TDbBaseItem));
		return *this;
	}

public:
	void cleanUp()
	{
		baseAttr.clear();
		TDbBaseItem::cleanUp();
	}

	bool isNull() const
	{
		return itemTypeID == INVALID_ITEM_TYPE_ID || !pos.isValid();
	}
	bool operator == (const _DbItem& lhs)
	{
		if (itemTypeID != lhs.itemTypeID || pos.type != lhs.pos.type
			|| pos.index != lhs.pos.index || count != lhs.count || quality != lhs.quality || bind != lhs.bind
			|| remainTime != lhs.remainTime || stre != lhs.stre || appendAttr.data.size() != lhs.appendAttr.data.size())
		{
			return false;
		}

		for (sint32 i = 0; i < appendAttr.data.size(); ++i)
		{
			if (appendAttr.data[i].attrType != lhs.appendAttr.data[i].attrType
				|| appendAttr.data[i].attrValue != lhs.appendAttr.data[i].attrValue
				|| appendAttr.data[i].valueType != lhs.appendAttr.data[i].valueType)
			{
				return false;
			}
		}

		for (sint32 i = 0; i < ITEM_APPEDN_ATTR_NUM; ++i)
		{
			if (holeItems.data[i] == INVALID_ITEM_TYPE_ID && lhs.holeItems.data[i] == INVALID_ITEM_TYPE_ID)
			{
				return true;
			}
			if (holeItems.data[i] != lhs.holeItems.data[i])
			{
				return false;
			}
		}
		return true;
	}

}TDbItem;

#pragma pack(pop)

#endif