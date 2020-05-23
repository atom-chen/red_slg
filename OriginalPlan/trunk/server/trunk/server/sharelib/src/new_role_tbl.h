#ifndef _NEW_ROLE_TBL_H_
#define _NEW_ROLE_TBL_H_

#include "core/parse_misc.h"

#include "game_util.h"
#include "game_struct.h"
#include "tbl_config.h"
#include "tbl_loader.h"
#include "bag_struct.h"
#include "item_struct.h"

class CNewRoleTbl : public CConfigTbl
{
public:
	uint32 id;							///< 角色编号
	uint32 commanderID;					///< 武将编号
	sint32 strength;					///< 初始体力
	sint32 strengthFactor;				///< 体力系数
	TGold_t gameMoney;					///< 携带金钱
	TRmb_t bindRmb;						///< 初始元宝
	TLevel_t level;						///< 初始等级
	TSex_t sex;							///< 性别
	TExp_t exp;							///< 初始经验
	TItemRewardVec items;				///< 初始的物品
	TMapID_t mapID;						///< 初始地图
	TAxisPos pos;						///< 初始坐标
	TSkillID_t skillTypeID;				///< 技能ID
	TMissionTypeID_t initMissionID;		///< 初始任务ID

public:
	TItemTypeID_t itemID1;
	TItemNum_t itemNum1;
	TItemTypeID_t itemID2;
	TItemNum_t itemNum2;
	TItemTypeID_t itemID3;
	TItemNum_t itemNum3;
	TItemTypeID_t itemID4;
	TItemNum_t itemNum4;

public:
	DMultiIndexImpl1(uint32, id, 0);
	DObjToString(CNewRoleTbl, uint32, id);

public:
	virtual bool onAfterLoad(void * arg = NULL)
	{ 
		if(itemID1 != INVALID_ITEM_TYPE_ID && itemNum1 != 0)
		{
			items.push_back(TItemReward(itemID1, itemNum1));
		}
		if (itemID2 != INVALID_ITEM_TYPE_ID && itemNum2 != 0)
		{
			items.push_back(TItemReward(itemID2, itemNum2));
		}
		if (itemID3 != INVALID_ITEM_TYPE_ID && itemNum3 != 0)
		{
			items.push_back(TItemReward(itemID3, itemNum3));
		}
		if (itemID4 != INVALID_ITEM_TYPE_ID && itemNum4 != 0)
		{
			items.push_back(TItemReward(itemID4, itemNum4));
		}
		return true; 
	}
};

class  CNewRoleTblLoader : 
	public CConfigLoader<CNewRoleTblLoader, CNewRoleTbl>
{
public:
	DLoaderGet();

	virtual bool readRow(ConfigRow* row, sint32 count, CNewRoleTbl* destRow)
	{
		DReadConfigInt(id, id, destRow);
		DReadConfigInt(commanderID, wujiang, destRow);
		DReadConfigInt(strength, health, destRow);	
		DReadConfigInt(gameMoney, youxibi, destRow);
		DReadConfigInt(bindRmb, yuanbao, destRow);
		DReadConfigInt(level, level, destRow);
		DReadConfigInt(sex, sex, destRow);
		DReadConfigInt(exp, exp, destRow);
		DReadConfigInt(itemID1, item1, destRow);
		DReadConfigInt(itemNum1, num1, destRow);
		DReadConfigInt(itemID2, item2, destRow);
		DReadConfigInt(itemNum2, num2, destRow);
		DReadConfigInt(itemID3, item3, destRow);
		DReadConfigInt(itemNum3, num3, destRow);
		DReadConfigInt(itemID4, item4, destRow);
		DReadConfigInt(itemNum4, num4, destRow);
		GXMISC::IntX itemIDs;
		GXMISC::IntX itemNums;
		DReadConfigIntX(itemIDs, item, destRow);
		DReadConfigIntX(itemNums, num, destRow);

		for(uint32 i = 0; i < itemIDs.size(); ++i){
			destRow->items.push_back(TItemReward(itemIDs[i], itemNums[i]));
		}
		
		DReadConfigInt(mapID, map, destRow);
		DReadConfigInt(pos.x, x, destRow);
		DReadConfigInt(pos.y, y, destRow);
		DReadConfigInt(skillTypeID, skill, destRow);
		DReadConfigInt(initMissionID, task, destRow);
		DAddToLoader(destRow);

		return true;
	}
};

#define DNewRoleTblMgr CNewRoleTblLoader::GetInstance()

#endif	// _NEW_ROLE_TBL_H_