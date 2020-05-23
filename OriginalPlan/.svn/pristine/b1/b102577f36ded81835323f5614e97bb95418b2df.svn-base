#ifndef _TRANSPORT_TBL_H_
#define _TRANSPORT_TBL_H_

#include "core/lib_misc.h"

#include "tbl_loader.h"
#include "game_util.h"
#include "tbl_config.h"
#include "game_misc.h"
#include "game_struct.h"

class CTransportConfigTbl : public CConfigTbl
{
public:
	sint32 id;						///< ID
	TMapID_t mapID;					///< 地图
	TAxisPos pos;					///< 坐标
	sint32 otherID;					///< 目标传送点
	sint32 isShow;					///< 是否显示

public:
	TAxisPos_t x;
	TAxisPos_t y;

public:
	DMultiIndexImpl1(sint32, id, 0);
	DObjToStringAlias(CTransportConfigTbl, sint32, NpcID, id);
};

class  CTransportTblLoader : 
	public CConfigLoader<CTransportTblLoader, CTransportConfigTbl>
{
public:
//	typedef CConfigLoader<CTransportTblLoader, CTransportConfigTbl> TBaseType;
	DSingletonImpl();
	DConfigFind();
public:
	bool getDestPos(sint32 id, TMapID_t& mapID, TAxisPos& pos)
	{
		mapID = INVALID_MAP_ID;
		pos.cleanUp();

		CTransportConfigTbl* pRow = find(id);
		if(NULL == pRow)
		{
			return false;
		}

		mapID = pRow->mapID;
		pos = pRow->pos;

		return true;
	}


public:
	virtual bool readRow(ConfigRow* row, sint32 count, TBaseType::ValueProType* destRow)
	{
		DReadConfigInt(id, id, destRow);
		DReadConfigInt(mapID, map, destRow);
		DReadConfigInt(x, x, destRow);
		DReadConfigInt(y, y, destRow);
		destRow->pos.x = destRow->x;
		destRow->pos.y = destRow->y;
		DReadConfigInt(otherID, connect, destRow);
		DReadConfigInt(isShow, show, destRow);
		
		DAddToLoader(destRow);

		return true;
	}
};

#define DTransportTblMgr CTransportTblLoader::GetInstance()

#endif	// _TRANSPORT_TBL_H_