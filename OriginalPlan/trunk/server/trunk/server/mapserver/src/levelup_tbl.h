#ifndef _LEVELUP_TBL_H_
#define _LEVELUP_TBL_H_

#include "game_util.h"
#include "game_struct.h"
#include "tbl_config.h"
#include "tbl_loader.h"

typedef struct _xinxiang
{
	TXingXiangId_t maleId;                       ///< 男资源id
	TXingXiangId_t feMaleId;                     ///< 女资源id
}TXingXiang;

class CLevelUpTbl : public CConfigTbl
{
public:
	TLevel_t level;						///< 等级
	TExp_t exp;							///< 经验
	THp_t strength;						///< 体力值
	TGold_t gameMoney;					///< 游戏币
	TRmb_t bindRmb;						///< 绑定元宝
	TItemTypeID_t item;					///< 物品
	TItemNum_t  num;					///< 物品数目
	uint8 soldierNum;					///< 带兵数目
	sint32 baseCampHp;					///< 基地血量
	sint32 defense;						///< 基地防御
	TXingXiang xingXiang;               ///< 形象资源信息

public:
	DMultiIndexImpl1(TLevel_t, level, 0);
	DObjToString(CLevelUpTbl, TLevel_t, level);
};

class  CLevelUpTblLoader : 
	public CConfigLoader<CLevelUpTblLoader, CLevelUpTbl>
{
public:
	//typedef CConfigLoader<CLevelUpTblLoader, CLevelUpTbl> TBaseType;
	DSingletonImpl();
	DConfigFind();
public:
	virtual bool readRow(ConfigRow* row, sint32 count, TBaseType::ValueProType* destRow)
	{
		DReadConfigInt(level, level, destRow);
		DReadConfigInt(exp, exp, destRow);
		DReadConfigInt(strength, health, destRow);
		DReadConfigInt(gameMoney, youxibi, destRow);
		DReadConfigInt(bindRmb, money, destRow);
		DReadConfigInt(item, item, destRow);
		DReadConfigInt(num, num, destRow);
		DReadConfigInt(soldierNum, xiaobing, destRow);
		DReadConfigInt(baseCampHp, jidi, destRow);
		DReadConfigInt(defense, defence, destRow);

		GXMISC::Int2 int2;
		//读章节		
		int2.value1                      = 0;
		int2.value2                      = 0;
		DReadConfigIntXNoErr(int2, xinxiang, destRow);
		destRow->xingXiang.maleId         = int2.value1;
		destRow->xingXiang.feMaleId       = int2.value2;

		DAddToLoader(destRow);

		return true;
	}
};

#define DLevelUpTblMgr CLevelUpTblLoader::GetInstance()

#endif	// _LEVELUP_TBL_H_