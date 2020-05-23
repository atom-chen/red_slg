#ifndef _MAP_DATA_TBL_H_
#define _MAP_DATA_TBL_H_

#include "tbl_loader.h"
#include "game_util.h"
#include "tbl_config.h"
#include "game_misc.h"
#include "game_struct.h"

class CMapConfigTbl : public CConfigTbl
{
public:
	TMapID_t mapID;				                // 地图ID
	uint8 mapType;				                // 地图类型
	TAxisPos_t x;								// 空坐标x
	TAxisPos_t y;								// 空坐标y
	std::string dataFileName;					// 地图数据文件名

public:
	virtual bool onAfterLoad(void * arg /* = NULL */)
	{
		return true;
	}

public:
	DMultiIndexImpl1(TMapID_t, mapID, INVALID_MAP_ID);
	DObjToStringAlias(CMapConfigTbl, TMapID_t, MapID, mapID);
};

class  CMapTblLoader : 
	public CConfigLoader<CMapTblLoader, CMapConfigTbl>
{
public:
	//typedef CConfigLoader<CMapTblLoader, CMapConfigTbl> TBaseType;
	DSingletonImpl();
	DConfigFind();
public:
	virtual bool onAfterLoad(void* arg)
	{
		return true;
	}

public:
	virtual bool readRow(ConfigRow* row, sint32 count, CMapConfigTbl* destRow)
	{
		DReadConfigInt(mapID, id, destRow);
		DReadConfigInt(mapType, type, destRow);
		DReadConfigInt(x, x, destRow);
		DReadConfigInt(y, y, destRow);
//		DReadConfigTxt(dataFileName, fileName, destRow);

		DAddToLoader(destRow);

		return true;
	}
};

#define DMapTblMgr CMapTblLoader::GetInstance()

#endif	// _MAP_DATA_TBL_H_