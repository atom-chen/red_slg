#ifndef _BAGITEM_TBL_H_
#define _BAGITEM_TBL_H_

#include "game_util.h"
#include "bag_struct.h"
#include "tbl_config.h"
#include "tbl_loader.h"

class CItemConfigTbl : public CConfigTbl
{
public:
	TItemTypeID_t id;					///< 物品ID
	uint8 type;							///< 类型
	uint8 subType;						///< 类型子项
	uint8 sexLimit;						///< 性别限制
	uint8 levelLimit;					///< 等级限制
	uint32 selfCD;						///< 自身冷却时间
	uint32 commCD;						///< 公共冷却时间
	uint8 jobLimit;						///< 职业限制
	uint8 quality;						///< 品质
	uint8 bindType;						///< 绑定类型
	uint8 isNeedRecorde;				///< 是否需要记录到数据库
	uint8 isNeedLog;					///< 是否需要记录到日志
	TItemNum_t maxCount;				///< 最大叠加数
	uint8 dropType;						///< 是否可以摧毁
	uint8 sellType;						///< 是否可以出售
	uint32 buyPrice;					///< 购买价格
	uint32 sellPrice;					///< 出售价格
	TItemNum_t useConsume;				///< 使用消耗个数
	GXMISC::TDiffTime_t lastTime;		///< 持续时间
	uint8 priority;                     ///< 显示优先级

public:
	std::string itemName;				///< 道具名字

public:
	CItemConfigTbl(){
		DCleanSubStruct(CConfigTbl);
	}
public:
	virtual bool onAfterLoad(void * arg /* = NULL */)
	{
		return true;
	}

public:
	bool isSexUnlimit()
	{
		return sexLimit == SEX_LIMIT_NORMAL;
	}

	bool isJobUnlimit()
	{
		return jobLimit == JOB_LIMIT_NORMAL;
	}

	bool isTimeUnlimit()
	{
		return lastTime == 0;
	}

	bool canSell()
	{
		return sellType == 1;
	}

	bool canDrop()
	{
		return dropType == 1;
	}

	bool isBind()
	{
		return bindType == BIND_TYPE_BIND;
	}

	bool isTask()
	{
		return type == ITEM_TYPE_CONSUME && subType == CONSUME_SUB_CLASS_TASK;
	}

	bool getIsNeedRecorde()
	{
		return isNeedRecorde == 1;
	}

	TGold_t getSellPrice(TItemStre_t itemStre)
	{
		return sellPrice * (itemStre + 1) * (itemStre + 1) * (itemStre + 1);
	}

	TGold_t getBuyBackPrice(TItemStre_t itemStre)
	{
		return getSellPrice(itemStre);
	}
public:
	DMultiIndexImpl1(TItemTypeID_t, id, INVALID_ITEM_TYPE_ID);
	DObjToString(CItemConfigTbl, TItemTypeID_t, id);
};

typedef uint32 TItemClass_t;
class CItemTblLoader : 
	public CConfigLoader<CItemTblLoader, CItemConfigTbl>
{
public:
	DSingletonImpl();
	DConfigFind();

public:
	virtual bool readRow(ConfigRow* row, sint32 count, CItemConfigTbl* destRow)
	{
		DReadConfigInt(id, id, destRow);
		DReadConfigInt(type, type, destRow);
		DReadConfigInt(subType, subtype, destRow);
		DReadConfigInt(quality, quality, destRow);
		DReadConfigInt(maxCount, limit, destRow);

		DAddToLoader(destRow);

		return true;
	}

	CItemConfigTbl* getConfig(EItemType type, uint8 subType)
	{
		TItemClass_t classItem = type;
		classItem <<= sizeof(subType)* 8;
		classItem += subType;
		CHashMap<TItemClass_t, TItemTypeID_t>::iterator iter = _classHash.find(classItem);
		if (iter == _classHash.end())
		{
			return NULL;
		}

		return find(iter->second);
	}

	CItemConfigTbl* getConfigByQuality(EItemType type, uint8 subType, uint8 quality)
	{
		TItemClass_t classItem = type;
		classItem <<= sizeof(subType)* 8;
		classItem += subType;
		classItem <<= sizeof(quality)* 8;
		classItem += quality;
		CHashMap<TItemClass_t, TItemTypeID_t>::iterator iter = _qualityClassHash.find(classItem);
		if (iter == _qualityClassHash.end())
		{
			return NULL;
		}
		return find(iter->second);
	}

private:
	CHashMap<TItemClass_t, TItemTypeID_t> _classHash;
	CHashMap<TItemClass_t, TItemTypeID_t> _qualityClassHash;
};

#define DItemTblMgr CItemTblLoader::GetInstance()

#endif //_BAGITEM_TBL_H_