#ifndef _LEVELUP_TBL_H_
#define _LEVELUP_TBL_H_

#include "game_util.h"
#include "game_struct.h"
#include "tbl_config.h"
#include "tbl_loader.h"

typedef struct _xinxiang
{
	TXingXiangId_t maleId;                       ///< ����Դid
	TXingXiangId_t feMaleId;                     ///< Ů��Դid
}TXingXiang;

class CLevelUpTbl : public CConfigTbl
{
public:
	TLevel_t level;						///< �ȼ�
	TExp_t exp;							///< ����
	THp_t strength;						///< ����ֵ
	TGold_t gameMoney;					///< ��Ϸ��
	TRmb_t bindRmb;						///< ��Ԫ��
	TItemTypeID_t item;					///< ��Ʒ
	TItemNum_t  num;					///< ��Ʒ��Ŀ
	uint8 soldierNum;					///< ������Ŀ
	sint32 baseCampHp;					///< ����Ѫ��
	sint32 defense;						///< ���ط���
	TXingXiang xingXiang;               ///< ������Դ��Ϣ

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
		//���½�		
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