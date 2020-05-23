/********************************************************************
	created:	2013/09/24
	created:	24:9:2013   15:48
	file base:	world_db_mall
	file ext:	h
	author:		Z_Y_R
	
	purpose:	world　mall db　接口
*********************************************************************/
#ifndef _WORLD_DB_MALL_H_
#define _WORLD_DB_MALL_H_

#include "game_util.h"
#include "db_struct_base.h"
#include "game_time.h"

#pragma pack(push, 1)

/// 商城DB数据结构(目前临时写在这里)
typedef struct _dbGoodInfo : public GXMISC::TDBStructBase
{
	TStoreMarkNum_t			storeMarkNum;			///< 商品编号
	TStoreItemNum_t			storeItemSurNum;		///< 商品剩余可以购买个数
	GXMISC::TGameTime_t		storeValidTime;			///< 商品剩余可以购买的时间
	TstoreCycle_t			storeCycle;				///< 商品周期记录(与局商品同步)
	GXMISC::CGameTime		storeOperatorTime;		///< 商品操作时间
	TGoodStateLise			storeStateTypeList;		///< 商品状态列表: @ref EStoreType

	//附加数值(用于动态修改数据)
	//货币
	//货币值
	//时限
	//限购数量等

	_dbGoodInfo()
	{
		clean();
	}

	void clean()
	{
		DCleanSubStruct(GXMISC::TDBStructBase);
		//::memset(this, 0, sizeof(*this));
	}
}TdbGoodInfo;

typedef struct _WgoodInfo : public _dbGoodInfo, public GXMISC::IArrayEnableSimple<struct _WgoodInfo>
{
	//用于逻辑不用保存到DB
	//uint8					storeIsRecode;			///< 是否要记录到DB
	TstoreActType			storeBuyType;			///< 购买形式
	uint8					storeState;				///< 商品状态
	uint8					storeIsSell;			///< 商品是否出售记录

	_WgoodInfo()
	{
		DArrayKey(storeMarkNum);
		clean();
	} 

	_WgoodInfo(TstoreActType type){
		DArrayKey(storeMarkNum);
		clean();
		storeBuyType = type;
	}

	void clean()
	{
		DCleanSubStruct(GXMISC::TDBStructBase);
		::memset(this, 0, sizeof(*this));
	}
}TWgoodInfo;

typedef CArray1<struct _WgoodInfo>	TGoodDBInfoArray;	///< 商品动态数据

struct CMallGoodData : public GXMISC::TDBStructBase
{
	TGoodDBInfoArray  goodarray;

	CMallGoodData()
	{
		clean();
	}

	void clean()
	{
		goodarray.clear();
	}
};

#pragma pack(pop)

class CMallGoodBaseObj
{
private:
	friend class CWorldMallMgr;

public:
	CMallGoodBaseObj();
	virtual ~CMallGoodBaseObj();

public:

	void clean();

private:
	TWgoodInfo  _dbGoodInfo;		//动态数据
};


#endif //_WORLD_DB_MALL_H_
