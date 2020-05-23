#ifndef _DHM_TBL_H_
#define _DHM_TBL_H_

#include "core/parse_misc.h"
#include "game_util.h"
#include "game_struct.h"
#include "tbl_config.h"
#include "tbl_loader.h"

class CDhmTbl : public CConfigTbl
{
public:
	TExchangeConfigId_t id;			                  //活动序号 
	sint32 giftId;                                    //礼包ids	

public:
	bool checkTblConfig(void)
	{	
		return true;
	}
	virtual bool onAfterLoad(void * arg )
	{ 
		if( ! checkTblConfig() )
		{
			return false;
		}
		return true;
	}

public:	
	DMultiIndexImpl1(TExchangeConfigId_t, id, 0);
	DObjToString(CDhmTbl, TExchangeConfigId_t, id);
};

class  CDhmTblLoader : 
	public CConfigLoader<CDhmTblLoader, CDhmTbl>
{
public:
	DSingletonImpl();
	DConfigFind();
public:
	virtual bool readRow(ConfigRow* row, sint32 count, CDhmTbl* destRow)
	{
		DReadConfigInt( id, id, destRow);	
		DReadConfigInt( giftId, libao, destRow);

		setId(destRow);
		DAddToLoader(destRow);
		return true;
	}

	virtual bool onAfterLoad(void* arg)
	{		
		return true;
	}

	static void setId( CDhmTbl* destRow )
	{
		//自己通过该哈希构造一个键
		return ;
	}
};

#define DDhmTblMgr CDhmTblLoader::GetInstance()

#endif	// _DHM_TBL_H_