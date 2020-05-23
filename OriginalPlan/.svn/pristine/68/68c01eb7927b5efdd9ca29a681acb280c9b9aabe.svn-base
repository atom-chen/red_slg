#ifndef _NPC_TBL_H_
#define _NPC_TBL_H_

#include "core/lib_misc.h"

#include "tbl_loader.h"
#include "game_util.h"
#include "tbl_config.h"
#include "game_misc.h"
#include "game_struct.h"


class CNpcConfigTbl : public CConfigTbl
{
public:
	sint32 id;						///< ID
	TAxisPos pos;					///< 坐标
	TMapID_t mapID;					///< 地图
	std::vector<sint32> options;	///< 选项

public:
	sint32 option1;
	sint32 option2;
	TAxisPos_t x;
	TAxisPos_t y;

public:
	DMultiIndexImpl1(sint32, id, 0);
	DObjToStringAlias(CNpcConfigTbl, sint32, NpcID, id);
};

class  CNpcTblLoader : 
	public CConfigLoader<CNpcTblLoader, CNpcConfigTbl>
{
public:
	//typedef CConfigLoader<CNpcTblLoader, CNpcConfigTbl> TBaseType;
	DSingletonImpl();
	DConfigFind();
public:
	virtual bool readRow(ConfigRow* row, sint32 count, TBaseType::ValueProType* destRow)
	{
		DReadConfigInt(id, id, destRow);
		DReadConfigInt(mapID, map, destRow);
		DReadConfigInt(option1, function1, destRow);
		DReadConfigInt(option2, function2, destRow);
		destRow->options.push_back(destRow->option1);
		destRow->options.push_back(destRow->option2);
		DReadConfigInt(x, x, destRow);
		DReadConfigInt(y, y, destRow);
		destRow->pos.x = destRow->x;
		destRow->pos.y = destRow->y;

		DAddToLoader(destRow);

		return true;
	}
};

#define DNpcTblMgr CNpcTblLoader::GetInstance()

#endif	// _NPC_TBL_H_